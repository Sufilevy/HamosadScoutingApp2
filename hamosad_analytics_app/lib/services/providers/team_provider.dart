import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/team/team_model.dart';
import '/services/database/analytics_database.dart';
import '/services/providers/selected_districts_provider.dart';

final teamReportsProvider = StreamProvider.autoDispose.family(
  (ref, String teamNumber) async* {
    final districtsAsyncValue = ref.watch(selectedDistrictsProvider);
    final districts = districtsAsyncValue.value!;

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
