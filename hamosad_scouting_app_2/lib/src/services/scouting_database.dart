import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

enum ReportType { game, pit }

class ScoutingDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static String _districtName = '';
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _random = Random();
  static final DocumentReference _informationRef =
      _db.doc('/matches/information');
  static late final DocumentReference _gameReportsRef, _pitReportsRef;

  ScoutingDatabase();

  static Future<void> initialize() async {
    await FirebaseAuth.instance.signInAnonymously();
    _districtName = (await _informationRef.get()).get('currentDistrict');
    _gameReportsRef = _db.doc('/gameReports/$_districtName');
    _pitReportsRef = _db.doc('/pitReports/$_districtName');
  }

  static Future<void> finalize() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  static String _generateReportId() {
    return List.generate(8, (index) => _chars[_random.nextInt(_chars.length)])
        .join();
  }

  static Map<String, dynamic> _getDateTime() {
    DateTime now = DateTime.now();

    return {
      "day": now.day,
      "month": now.month,
      "year": now.year,
      "time": DateFormat('dd/MM HH:mm:ss').format(now),
    };
  }

  static void sendReport(
    Map<String, dynamic> data, {
    ReportType reportType = ReportType.game,
    String? id,
  }) async {
    data.addAll({'dateTime': _getDateTime()});

    if (reportType == ReportType.game) {
      await _gameReportsRef.update({id ?? _generateReportId(): data});
    } else {
      await _pitReportsRef.update({id ?? _generateReportId(): data});
    }
  }
}
