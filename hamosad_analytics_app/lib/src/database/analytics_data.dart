import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/models.dart';

class AnalyticsData {
  const AnalyticsData(
    this.teamsByNumber,
    this.teamsWithNumber,
  );

  /// The teams that have data submitted on them in the reports, sorted by their number.
  final List<Team> teamsByNumber;

  /// The teams that have data submitted on them in the reports, in a {teamNumber: team} format.
  final Map<int, Team> teamsWithNumber;

  /// Generate an [AnalyticsData] object from a list of reports.
  factory AnalyticsData.fromReports(AnalyticsDatabase database) {
    var teamsWithNumber = <int, Team>{};

    for (final report in database.reports) {
      // Add the team the report is about to the teams map if it's not already there
      final nameAndLocation = database.teams[report.teamNumber] ??
          TeamNameAndLocation(
            name: 'Team ${report.teamNumber}',
            location: 'Israel',
          );
      teamsWithNumber.putIfAbsent(
        report.teamNumber,
        () => Team(
          number: report.teamNumber,
          name: nameAndLocation.name,
          location: nameAndLocation.location,
        ),
      );

      // Update the team's stats with the current report
      final team = teamsWithNumber[report.teamNumber]!;
      team.auto.updateWithReport(report.auto, report.matchAndScouter);
      team.teleop.updateWithReport(report.teleop, report.matchAndScouter);
      team.endgame.updateWithReport(report.endgame, report.matchAndScouter);
      team.summary.updateWithReport(report);
      team.reports.add(report);
    }

    return _fromTeamsWithNumber(teamsWithNumber);
  }

  static AnalyticsData _fromTeamsWithNumber(Map<int, Team> teamsWithNumber) {
    final teamsList = teamsWithNumber.mapEntries((team) => team.value);
    final teamsByNumber = teamsList.sortedBy((team) => team.info.number);

    return AnalyticsData(
      teamsByNumber,
      teamsWithNumber,
    );
  }
}

final Provider<AnalyticsData> analytisDataProvider = Provider((ref) {
  final database = ref.watch(analyticsDatabaseProvider);
  return AnalyticsData.fromReports(database);
});
