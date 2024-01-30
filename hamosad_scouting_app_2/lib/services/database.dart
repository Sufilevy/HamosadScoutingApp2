import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/models/cubit.dart';
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
    debugPrint('Finished database initialization.');
  }

  static Future<void> finalize() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  static Future<void> sendReport(
    Json report, {
    required bool isRematch,
    String? lastId,
  }) async {
    final datetime = _getDatetime();

    final scouterTeamNumber = report['0-info']['scouterTeamNumber'];
    final collectionName = '$_districtName-$scouterTeamNumber';
    final districtReports = _db.collection(collectionName);

    var teamReports = districtReports.doc(report['0-info']['teamNumber']);
    final currentReports = (await teamReports.get()).data();
    if (currentReports == null || currentReports.isEmpty) {
      teamReports.set({});
      teamReports = districtReports.doc(report['0-info']['teamNumber']);
    }

    final match = report['0-info']['match']
        .toString()
        .replaceAll('Eliminations ', 'elims')
        .replaceAll('(Round ', '')
        .replaceAll(')', '')
        .replaceAll('(Finals)', '-finals');
    final scouter =
        report['0-info']['scouter'].toString().trim().replaceAll(' ', '_').toLowerCase();

    final reportId = '$match-$scouter-$datetime';

    if (isRematch) {
      final currentSnapshot = await teamReports.get();
      final currentReports = currentSnapshot.data() ?? {};

      currentReports.removeWhere((id, _) => id.contains('$match-$scouter'));
      currentReports[reportId] = report;

      teamReports.set(currentReports);
    } else {
      await teamReports.update({reportId: report});
    }

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
