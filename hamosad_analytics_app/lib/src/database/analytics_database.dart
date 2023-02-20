import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/models.dart';

class TeamNameAndLocation {
  const TeamNameAndLocation({required this.name, required this.location});

  final String name, location;

  TeamNameAndLocation.fromJson(Json json)
      : name = json['name'],
        location = json['location'];
}

class AnalyticsDatabase {
  AnalyticsDatabase()
      : _dataStamp = '',
        _reports = [],
        _teams = {};

  String _dataStamp;
  List<Report> _reports;
  Map<int, TeamNameAndLocation> _teams;

  List<Report> get reports => _reports;
  String get dataStamp => _dataStamp;
  Map<int, TeamNameAndLocation> get teams => _teams;

  Future<void> updateFromFirestore() async {
    _dataStamp = await _getDataStampFromFirestore();

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

  Future<String> _getDataStampFromFirestore() {
    return Future.value('');
  }

  Future<Json> _getReportsFromFirestore() async {
    return Future.value({});
  }

  Future<Json> _getTeamsFromFirestore() async {
    return Future.value({});
  }
}

final Provider<AnalyticsDatabase> analyticsDatabaseProvider = Provider((ref) {
  return AnalyticsDatabase();
});
