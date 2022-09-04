// ignore_for_file: avoid_print

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScoutingDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static String _districtName = '';
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _random = Random();

  ScoutingDatabase();

  static Future<void> initialize() async {
    await FirebaseAuth.instance.signInAnonymously();
    final informationRef = _db.doc('/matches/information');
    _districtName = (await informationRef.get()).get('currentDistrict');
  }

  static Future<void> finalize() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  static String _generateReportId() {
    return List.generate(8, (index) => _chars[_random.nextInt(_chars.length)])
        .join();
  }

  static void sendReport(Map<String, Object?> data) async {
    await FirebaseAuth.instance.signInAnonymously();
    await _db
        .doc('/reports/$_districtName')
        .update({_generateReportId(): data});
  }
}
