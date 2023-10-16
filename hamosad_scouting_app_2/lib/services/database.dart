import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';
import '/services/utilities.dart';

class ScoutingDatabase {
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
    Json report, {
    String? lastId,
  }) async {
    final datetime = _getDatetime();
    report.addAll({'datetime': datetime});

    final scouterTeamNumber = report['info']['scouterTeamNumber'];
    final collectionName = '$_districtName-$scouterTeamNumber';
    final districtReports = _db.collection(collectionName);

    final teamReports = districtReports.doc(report['info']['teamNumber']);
    final id = lastId ?? _generateReportId(report['info'], datetime);

    await teamReports.update({id: report});
    await _db.waitForPendingWrites();
  }

  static String _generateReportId(Json reportInfo, Json datetime) {
    final match = reportInfo['match'].toString();
    final scouter = reportInfo['scouter'].toString().trim().replaceAll(' ', '_').toLowerCase();

    return '${match == 'Eliminations' ? 'elims' : match}'
        '-$scouter'
        '-${datetime['time']}';
  }

  static Json _getDatetime() {
    final now = DateTime.now();

    return {
      'day': now.day,
      'month': now.month,
      'year': now.year,
      'time': DateFormat('HH:mm:ss-dd/MM ').format(now),
    };
  }

  static Future<void> _getMatches() async {
    final matchesJson = await _db.collection('district').doc('matches').get();

    matches = matchesJson.data()?.mapValues((match) => (match.value as List).mapToStrings()) ?? {};
  }
}
