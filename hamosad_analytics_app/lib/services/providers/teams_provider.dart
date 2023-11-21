import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/analytics.dart';
import '/services/database/analytics_database.dart';

class TeamsWithReportsIdentifier extends Equatable {
  const TeamsWithReportsIdentifier(this.teamsNumbers, this.districts);

  final Set<String> teamsNumbers;
  final Set<String> districts;

  @override
  List<Object?> get props => [teamsNumbers, districts];
}

final teamsWithReportsProvider =
    StreamProvider.autoDispose.family<Map<String, Json>, TeamsWithReportsIdentifier>(
  (_, identifier) async* {
    final TeamsWithReportsIdentifier(:teamsNumbers, :districts) = identifier;

    final snapshots = districts.map(
      (district) => teamsNumbers.map(
        (teamNumber) => AnalyticsDatabase.reportsStreamOfTeam(teamNumber, district),
      ),
    );

    final streamGroups = snapshots.map((s) => StreamGroup.merge(s));
    final stream = StreamGroup.merge(streamGroups);

    await for (final doc in stream) {
      final docDistrict = doc.reference.parent.id;
      final docTeamNumber = doc.reference.id;
      final teamsWithReports = <String, Json>{};

      for (final district in districts) {
        for (final teamNumber in teamsNumbers) {
          fromDatabase() async => await AnalyticsDatabase.reportsOfTeam(teamNumber, district);

          final reports = (district == docDistrict && teamNumber == docTeamNumber)
              ? doc.data() ?? await fromDatabase()
              : await fromDatabase();

          if (reports.isEmpty) continue;

          teamsWithReports.update(
            teamNumber,
            (existing) => existing..addAll(reports),
            ifAbsent: () => reports,
          );
        }
      }

      yield teamsWithReports;
    }
  },
);
