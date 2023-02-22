import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/models.dart';

class TeamNameAndLocation {
  const TeamNameAndLocation({required this.name, required this.location});

  final String name, location;

  TeamNameAndLocation.fromJson(Json json)
      : name = json['name'],
        location = json['location'];

  @override
  String toString() {
    return '$name, $location';
  }
}

class AnalyticsDatabase {
  AnalyticsDatabase()
      : _db = FirebaseFirestore.instance,
        _selectedDistrcits = {},
        _reports = [],
        _teams = {};

  final FirebaseFirestore _db;
  final Set<String> _selectedDistrcits;
  List<Report> _reports;
  Map<int, TeamNameAndLocation> _teams;

  List<Report> get reports => _reports;
  Map<int, TeamNameAndLocation> get teams => _teams;

  Future<void> updateFromFirestore() async {
    _selectedDistrcits.add(await getCurrentDistrict());

    final reports = await _getReportsFromFirestore();
    _reports = reports
        .mapEntries((report) => Report.fromJson(report.value))
        .filterNotNull()
        .toList();

    final teams = await _getTeamsFromFirestore();
    _teams = teams.map((key, value) => MapEntry(
          key.toInt(),
          TeamNameAndLocation.fromJson(value),
        ));
  }

  Future<String> getCurrentDistrict() async {
    final informationDoc =
        await _db.collection('district').doc('information').get();
    return informationDoc.get('name');
  }

  Future<Json> _getReportsFromFirestore() async {
    Json reports = {};

    final reportsRef = _db.collection('reports');
    for (final district in _selectedDistrcits) {
      final districtDoc = await reportsRef.doc(district).get();
      reports.addAll(districtDoc.data() ?? {});
    }

    return reports;
  }

  Future<Json> _getTeamsFromFirestore() async {
    final teamsDoc = await _db.collection('district').doc('teams').get();
    return teamsDoc.data() ?? {};
  }
}

final Provider<AnalyticsDatabase> analyticsDatabaseProvider = Provider((ref) {
  return AnalyticsDatabase();
});
