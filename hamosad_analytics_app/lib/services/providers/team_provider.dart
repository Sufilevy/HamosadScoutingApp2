import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/team/team_model.dart';
import '/services/database/analytics_database.dart';

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
