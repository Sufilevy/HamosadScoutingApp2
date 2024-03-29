import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
    await _getMatches();
  }

  static Future<void> finalize() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  static String _generateReportId(
      String match, String scouter, String teamNumber) {
    return '${match == 'Eliminations' ? 'elims' : match}-${scouter.trim().replaceAll(' ', '_')}-$teamNumber-${List.generate(4, (index) => _chars[_random.nextInt(_chars.length)]).join()}';
  }

  static Map<String, dynamic> _getDateTime() {
    DateTime now = DateTime.now();

    return {
      'day': now.day,
      'month': now.month,
      'year': now.year,
      'time': DateFormat('dd/MM HH:mm:ss').format(now),
    };
  }

  static Future<void> sendReport(
    Map<String, dynamic> data, {
    String? id,
  }) async {
    data.addAll({'datetime': _getDateTime()});

    final reports = _db.collection('reports');
    final docName = '$_districtName-${data['info']['scouterTeamNumber']}';

    await reports.doc(docName).update({
      id ??
          _generateReportId(data['info']['match'] ?? 'pit',
              data['info']['scouter'], data['info']['teamNumber']): data,
    });
  }

  static late Map<String, List<String>> matches;

  static Future<void> _getMatches() async {
    final matchesJson = await _db.collection('district').doc('matches').get();
    matches = matchesJson.data()?.mapValues((match) =>
            (match.value as List).map((team) => team.toString()).toList()) ??
        {};
  }
}
