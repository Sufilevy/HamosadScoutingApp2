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
      : _selectedDistrcits = [],
        _db = FirebaseFirestore.instance,
        _districts = [],
        _reports = [],
        _teams = {};

  final FirebaseFirestore _db;
  List<String> _selectedDistrcits;
  List<String> _districts;
  List<Report> _reports;
  Map<int, TeamNameAndLocation> _teams;

  List<Report> get reports => _reports;
  Map<int, TeamNameAndLocation> get teams => _teams;

  Future<void> updateFromFirestore() async {
    _selectedDistrcits.add(await _getCurrentDistrict());
    _districts = await _getDistricts();

    final reports = await _getReportsFromFirestore();
    _reports = reports
        .mapEntries((report) => Report.fromJson(report.value, id: report.key))
        .toList();

    final teams = await _getTeamsFromFirestore();
    _teams = teams.map((key, value) => MapEntry(
          key.toInt(),
          TeamNameAndLocation.fromJson(value),
        ));
  }

  Future<String> _getCurrentDistrict() async {
    final informationDoc =
        await _db.collection('district').doc('information').get();
    return '${informationDoc.get('name')}-1657';
  }

  Future<List<String>> _getDistricts() async {
    final reportsCollection = await _db.collection('reports').get();
    return reportsCollection.docs
        .map((doc) => doc.id)
        .whereNot((docName) => docName.contains('pit'))
        .toList();
  }

  void setSelectedDistrict(List<String> districts) {
    _selectedDistrcits = districts;
  }

  List<String> get districts => _districts;

  List<String> get selectedDistricts => _selectedDistrcits;

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

extension TeamsMapToTeamNamesList on Map<int, TeamNameAndLocation> {
  List<String> toTeamNames() {
    return mapEntries((entry) => '${entry.key} ${entry.value.name}').toList();
  }
}
