import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '/models/game_report/game_report.dart';
import '/models/pit_report.dart';
import '/services/utilities.dart';

abstract class ScoutingDatabase {
  static late Map<String, List<String>> matches;

  static final _db = FirebaseFirestore.instance;
  static var _districtName = '';

  static Future<void> initialize() async {
    await FirebaseAuth.instance.signInAnonymously();

    final informationDoc = await _db.collection('information').doc('districts').get();
    _districtName = informationDoc.get('current');

    await _getMatches();
  }

  static Future<void> finalize() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  static Future<void> sendReport(
    GameReport report, {
    required bool isRematch,
    String? lastId,
  }) async {
    final scouterTeamNumber = report.scouterTeamNumber.data;
    final collectionName = '$_districtName-$scouterTeamNumber';
    final districtReports = _db.collection(collectionName);

    var docName = report.teamNumber.data!;
    var teamReports = districtReports.doc(docName);
    if (!(await teamReports.get()).exists) {
      teamReports.set({});
      teamReports = districtReports.doc(docName);
    }

    final match = report.match.data!
        .replaceAll('Eliminations ', 'elims')
        .replaceAll('(Round ', '')
        .replaceAll(')', '')
        .replaceAll('(Finals)', '-finals');
    final scouter = report.scouter.data.trim().replaceAll(' ', '_').toLowerCase();
    final datetime = _getDatetime();
    final reportId = lastId ?? '$match-$scouter-$datetime';

    if (isRematch) {
      final currentSnapshot = await teamReports.get();
      final currentReports = currentSnapshot.data() ?? {};

      currentReports.removeWhere((id, _) => id.contains('$match-$scouter'));
      currentReports[reportId] = report;

      teamReports.set(currentReports);
    } else {
      await teamReports.update({reportId: report.toJson()});
    }

    await _db.waitForPendingWrites();
  }

  static Future<void> sendPitReport(
    PitReport report, {
    String? lastId,
  }) async {
    final scouterTeamNumber = report.scouterTeamNumber.data;
    final collectionName = '$_districtName-$scouterTeamNumber';
    final districtReports = _db.collection(collectionName);

    final docName = '${report.teamNumber.data!}-pit';
    var teamPitReports = districtReports.doc(docName);
    if (!(await teamPitReports.get()).exists) {
      teamPitReports.set({});
      teamPitReports = districtReports.doc(docName);
    }

    final scouter = report.scouter.data.trim().replaceAll(' ', '_').toLowerCase();
    final datetime = _getDatetime();
    final reportId = lastId ?? '$scouter-$datetime';

    await teamPitReports.update({reportId: report.toJson()});
    await _db.waitForPendingWrites();
  }

  static String _getDatetime() {
    return DateFormat('HH:mm:ss-dd_MM_yy').format(DateTime.now());
  }

  static Future<void> _getMatches() async {
    final matchesJson = await _db.collection('information').doc('matches').get();

    matches = matchesJson.data()?.mapValues((match) => (match.value as List).mapToStrings()) ?? {};
  }
}
