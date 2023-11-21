import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/team/team_model.dart';
import '/services/database/analytics_database.dart';

class TeamReportsIdentifier extends Equatable {
  const TeamReportsIdentifier(this.teamNumber, this.districts);

  final String teamNumber;
  final Set<String> districts;

  @override
  List<Object?> get props => [teamNumber, districts];
}

final teamReportsProvider = StreamProvider.autoDispose.family<Team, TeamReportsIdentifier>(
  (_, identifier) async* {
    final TeamReportsIdentifier(:teamNumber, :districts) = identifier;

    final snapshots = districts.map(
      (district) => AnalyticsDatabase.reportsStreamOfTeam(teamNumber, district),
    );

    final stream = StreamGroup.merge(snapshots);

    await for (final doc in stream) {
      final docDistrict = doc.reference.parent.id;
      final team = Team(teamNumber);

      for (final district in districts) {
        final reports = (district == docDistrict)
            ? doc.data()
            : await AnalyticsDatabase.reportsOfTeam(teamNumber, district);

        team.updateWithReports(reports);
      }

      yield team;
    }
  },
);
