import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/analytics.dart';
import '/models/team/team_model.dart';
import '/services/database/map_getters.dart';

class AnalyticsDatabase {
  static final _firestore = FirebaseFirestore.instance;

  static Future<String> currentDistrict() async {
    final districts = await allDistricts();
    final currentDistrict = districts.firstOrNull;

    if (currentDistrict == null) {
      final districtsSnapshot =
          await _firestore.collection('information').doc('districts').get();
      return districtsSnapshot
          .data()!
          .getString('current')!; // Panic if it doesn't exist
    }

    return currentDistrict;
  }

  static Future<List<String>> allDistricts() async {
    final districtsSnapshot =
        await _firestore.collection('information').doc('districts').get();
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

class ReportsIdentifier extends Equatable {
  const ReportsIdentifier(this.teamNumber, this.districts);

  final String teamNumber;
  final Set<String> districts;

  @override
  List<Object?> get props => [teamNumber, districts];
}

final teamProvider = StreamProvider.autoDispose.family<Team, ReportsIdentifier>(
  (ref, args) {
    final ReportsIdentifier(:teamNumber, :districts) = args;

    final snapshots = districts.map(
      (district) => AnalyticsDatabase.reportStreamOfTeam(teamNumber, district),
    );

    return StreamGroup.merge(snapshots).asyncMap(
      (doc) async {
        final docDistrict = doc.reference.parent.id;
        final team = Team(teamNumber);

        for (final district in districts) {
          final reports = (district == docDistrict)
              ? doc.data()
              : await AnalyticsDatabase.reportsOfTeam(teamNumber, district);

          team.updateWithReports(reports);
        }

        return team;
      },
    );
  },
);

class DistrictsIdentifier extends Equatable {
  const DistrictsIdentifier(this.districts);

  final Set<String> districts;

  @override
  List<Object?> get props => [districts];
}

final teamsProvider = StreamProvider.autoDispose
    .family<List<Team>, DistrictsIdentifier>((ref, arg) {
  final DistrictsIdentifier(:districts) = arg;

  final snapshots = AnalyticsDatabase.reportsFromDistricts(districts);


  return snapshots.first.map((event) => );
});
