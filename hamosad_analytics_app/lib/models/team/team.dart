import '/models/analytics.dart';

class Team {
  Team(this.teamNumber);

  final String teamNumber;
  final List<String> reportsIds = [];

  Team updateWithReports(Json? reports) {
    if (reports == null) return this;

    for (final MapEntry(key: reportId, value: report) in reports.entries) {
      reportsIds.add(reportId);
    }

    return this;
  }
}
