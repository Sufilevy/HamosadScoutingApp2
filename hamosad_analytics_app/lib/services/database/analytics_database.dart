import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/analytics.dart';
import '/services/database/map_getters.dart';

class AnalyticsDatabase {
  static final _firestore = FirebaseFirestore.instance;

  static Future<String> currentDistrict() async {
    final districts = await allDistricts();
    final currentDistrict = districts.firstOrNull;

    if (currentDistrict == null) {
      final districtsSnapshot = await _firestore.collection('information').doc('districts').get();
      return districtsSnapshot.data()!.getString('current')!; // Panic if it doesn't exist
    }

    return currentDistrict;
  }

  static Future<List<String>> allDistricts() async {
    final districtsSnapshot = await _firestore.collection('information').doc('districts').get();
    return districtsSnapshot.data()?.getList<String>('all') ?? [];
  }

  static Stream<DocumentSnapshot<Json>> reportStreamOfTeam(String teamNumber, String district) {
    if (!district.contains('-')) district += '-1657';

    return _firestore.collection(district).doc(teamNumber).snapshots();
  }

  static Future<Json> reportsOfTeam(String teamNumber, String district) async {
    if (!district.contains('-')) district += '-1657';

    final doc = await _firestore.collection(district).doc(teamNumber).get();

    return doc.data() ?? {};
  }
}
