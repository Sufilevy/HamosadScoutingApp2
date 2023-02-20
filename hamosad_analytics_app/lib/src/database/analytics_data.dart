import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/models.dart';

class AnalyticsData {
  const AnalyticsData(
    this.dataStamp,
    this.teamsByNumber,
    this.teamsWithNumber,
    this.teamsByRank,
  );

  /// The stamp linked with this data, created when a 'Hamosad Scouting App' client submits a report.
  ///
  /// The stamp's format is: '$time-$tag', where time is millisecondsSinceEpoch
  /// when the data was changed, and tag is a randomly generated 4-characters string.
  final String dataStamp;

  /// The teams that have data submitted on them in the reports, sorted by their number.
  final List<Team> teamsByNumber;

  /// The teams that have data submitted on them in the reports, in a {teamNumber: team} format.
  final Map<int, Team> teamsWithNumber;

  /// The teams that have data submitted on them in the reports, sorted by their rank.
  final List<Team> teamsByRank;

  @override
  bool operator ==(Object other) {
    if (other is AnalyticsData) {
      return hashCode == other.hashCode;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => dataStamp.hashCode;

  /// Generate an [AnalyticsData] object from a list of reports.
  factory AnalyticsData.fromReports(AnalyticsDatabase database) {
    var teamsWithNumber = <int, Team>{};

    for (final report in database.reports) {
      // Add the team the report is about to the teams map if it's not already there
      final nameAndLocation = database.teams[report.teamNumber]!;
      teamsWithNumber.putIfAbsent(
        report.teamNumber,
        () => Team.only(
          info: TeamInfo.only(
            number: report.teamNumber,
            name: nameAndLocation.name,
            location: nameAndLocation.location,
          ),
        ),
      );
    }

    return _fromTeamsWithNumber(database.dataStamp, teamsWithNumber);
  }

  static AnalyticsData _fromTeamsWithNumber(
    String dataStamp,
    Map<int, Team> teamsWithNumber,
  ) {
    final teamsList = teamsWithNumber.mapEntries((team) => team.value);
    final teamsByNumber = teamsList.sortedBy((team) => team.info.number);
    final teamsByRank = teamsList.sortedBy((team) => team.info.rank);

    return AnalyticsData(
      dataStamp,
      teamsByNumber,
      teamsWithNumber,
      teamsByRank,
    );
  }
}

final Provider<AnalyticsData> analytisDataProvider = Provider((ref) {
  final database = ref.watch(analyticsDatabaseProvider);
  return AnalyticsData.fromReports(database);
});
