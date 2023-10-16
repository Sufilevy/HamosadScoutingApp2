import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/analytics.dart';
import '/models/team/team.dart';

class AnalyticsDatabase {
  final _firestore = FirebaseFirestore.instance;

  Future<String> currentDistrictName() async {
    final districtsSnapshot = await _firestore.collection('information').doc('districts').get();
    return districtsSnapshot.get('current');
  }

  Future<List<String>> allDistrictsNames() async {
    final districtsSnapshot = await _firestore.collection('information').doc('districts').get();
    return districtsSnapshot.get('all');
  }

  Stream<DocumentSnapshot<Json>> reportsOfTeamFromDistrict(String teamNumber, String district) =>
      _firestore.collection(district).doc(teamNumber).snapshots();
}

final databaseProvider = Provider<AnalyticsDatabase>((ref) => AnalyticsDatabase());

typedef TeamNumber = String;
typedef DistrictName = String;

final teamProvider = StreamProvider.autoDispose.family<Team, (TeamNumber, DistrictName)>(
  (ref, args) {
    final database = ref.watch(databaseProvider);

    final (teamNumber, districtName) = args;
    final team = Team(teamNumber);
    return database
        .reportsOfTeamFromDistrict(teamNumber, districtName)
        .map((event) => team.updateWithReports(event.data()));
  },
);
