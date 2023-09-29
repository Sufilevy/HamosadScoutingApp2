import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hamosad_scouting_app_2/models/report.dart';
import 'package:hamosad_scouting_app_2/services/utilities.dart';
import 'package:intl/intl.dart';

class ScoutingDatabase {
  static late Map<String, List<String>> matches;

  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static String _districtName = '';

  static Future<void> initialize() async {
    await FirebaseAuth.instance.signInAnonymously();

    final informationDoc = await _db.collection('district').doc('information').get();
    _districtName = informationDoc.get('name');

    await _getMatches();
  }

  static Future<void> finalize() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  static Future<void> sendReport(
    Map<String, dynamic> data, {
    String? id,
  }) async {
    final datetime = _getDatetime();
    data.addAll({'datetime': datetime});

    final reports = _db.collection('reports');
    final docName = '$_districtName-${data['info']['scouterTeamNumber']}';

    await reports.doc(docName).update({
      id ??
          _generateReportId(
            data['info']['match'] ?? 'pit',
            data['info']['scouter'],
            data['info']['teamNumber'],
            datetime,
          ): data,
    });
  }

  static String _generateReportId(
    String match,
    String scouter,
    String teamNumber,
    Json datetime,
  ) =>
      '${match == 'Eliminations' ? 'elims' : match}'
      '-${scouter.trim().replaceAll(' ', '_')}'
      '-$teamNumber'
      '-${datetime['time']}';

  static Map<String, dynamic> _getDatetime() {
    DateTime now = DateTime.now();

    return {
      'day': now.day,
      'month': now.month,
      'year': now.year,
      'time': DateFormat('dd/MM HH:mm:ss').format(now),
    };
  }

  static Future<void> _getMatches() async {
    final matchesJson = await _db.collection('district').doc('matches').get();

    matches = matchesJson.data()?.mapValues((match) => (match.value as List).mapToStrings()) ?? {};
  }
}
