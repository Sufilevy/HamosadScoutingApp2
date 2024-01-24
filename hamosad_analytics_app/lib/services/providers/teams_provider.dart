import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/analytics.dart';
import '/services/database/analytics_database.dart';
import '/services/providers/selected_districts_provider.dart';

class TeamsIdentifier extends Equatable {
  const TeamsIdentifier(this.teamsNumbers);

  final TeamsNumbers teamsNumbers;

  @override
  List<Object?> get props => [teamsNumbers];
}

typedef TeamsWithRawReports = Map<String, Json>;

final teamsWithReportsProvider = StreamProvider.autoDispose.family(
  (ref, TeamsIdentifier identifier) async* {
    final districtsAsyncValue = ref.watch(selectedDistrictsProvider);
    final districts = districtsAsyncValue.value!;

    final TeamsIdentifier(:teamsNumbers) = identifier;

    final snapshots = districts.map(
      (district) => teamsNumbers.map(
        (teamNumber) => AnalyticsDatabase.reportsStreamOfTeam(teamNumber, district),
      ),
    );

    final streamGroups = snapshots.map((s) => StreamGroup.merge(s));
    final stream = StreamGroup.merge(streamGroups);

    await for (final snapshot in stream) {
      final snapshotDistrict = snapshot.reference.parent.id;
      final snapshotTeamNumber = snapshot.reference.id;
      final teamsWithReports = <String, Json>{};

      for (final district in districts) {
        for (final teamNumber in teamsNumbers) {
          fromDatabase() async => await AnalyticsDatabase.reportsOfTeam(teamNumber, district);

          final reports = (district == snapshotDistrict && teamNumber == snapshotTeamNumber)
              ? snapshot.data() ?? await fromDatabase()
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
