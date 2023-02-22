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

  ScoutingDatabase();

  static Future<void> initialize() async {
    await FirebaseAuth.instance.signInAnonymously();
    final informationDoc =
        await _db.collection('district').doc('information').get();
    _districtName = informationDoc.get('name');
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
      await _db
          .collection('reports')
          .doc(_districtName)
          .update({id ?? _generateReportId(): data});
    } else {
      await _db
          .collection('reports')
          .doc('$_districtName-pit')
          .update({id ?? _generateReportId(): data});
    }
  }
}
