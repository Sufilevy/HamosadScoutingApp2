import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/analytics.dart';
import 'json_typed_getters.dart';

abstract class AnalyticsDatabase {
  static final _firestore = FirebaseFirestore.instance;

  /// Returns the current district's name.
  ///
  /// If the districts list in `/information/districts/all`
  /// is empty, falls back to `/information/districts/current`.
  static Future<String> currentDistrict() async {
    final districts = await allDistricts();
    final currentDistrict = districts.firstOrNull;

    if (currentDistrict != null) return currentDistrict;

    final districtsSnapshot = await _firestore.collection('information').doc('districts').get();
    return districtsSnapshot.data()!.getString('current')!; // Panic if it doesn't exist
  }

  /// Returns the names of all districts from `/information/districts/all`.
  static Future<List<String>> allDistricts() async {
    final districtsSnapshot = await _firestore.collection('information').doc('districts').get();
    return districtsSnapshot.data()?.getList<String>('all') ?? [];
  }

  /// Returns the stream of snapshots of a district from `/<district>`.
  static Stream<QuerySnapshot<Json>> teamsStreamOfDistrict(String district) {
    if (!district.contains('-')) district += '-1657';

    return _firestore.collection(district).snapshots();
  }

  /// Returns the existing teams of a district from `/<district>`.
  static Future<Set<String>> teamsOfDistrict(String district) async {
    if (!district.contains('-')) district += '-1657';

    final query = await _firestore.collection(district).get();

    return query.docs.map((doc) => doc.id).toSet();
  }

  /// Returns the stream of snapshots of a team in a
  /// specific district from `/<district>/<teamNumber>`.
  static Stream<DocumentSnapshot<Json>> reportsStreamOfTeam(String teamNumber, String district) {
    if (!district.contains('-')) district += '-1657';

    return _firestore.collection(district).doc(teamNumber).snapshots();
  }

  /// Returns the current submitted reports of a team in
  /// a specific district from `/<district>/<teamNumber>`.
  static Future<Json> reportsOfTeam(String teamNumber, String district) async {
    if (!district.contains('-')) district += '-1657';

    final doc = await _firestore.collection(district).doc(teamNumber).get();

    return doc.data() ?? {};
  }
}
