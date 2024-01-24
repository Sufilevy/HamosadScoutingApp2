import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/analytics.dart';
import '/services/database/analytics_database.dart';
import '/services/providers/selected_districts_provider.dart';

final teamsNumbersProvider = StreamProvider.autoDispose<TeamsNumbers>(
  (ref) async* {
    final districtsAsyncValue = ref.watch(selectedDistrictsProvider);
    final districts = districtsAsyncValue.value!;

    final snapshots = districts.map(
      (district) => AnalyticsDatabase.teamsStreamOfDistrict(district),
    );

    final stream = StreamGroup.merge(snapshots);

    await for (final snapshot in stream) {
      final snapshotDistrict = snapshot.docs.first.reference.parent.id;
      final teamsNumbers = TeamsNumbers();

      for (final district in districts) {
        final teams = (district == snapshotDistrict)
            ? snapshot.docs.map((doc) => doc.id).toSet()
            : await AnalyticsDatabase.teamsNumbersOfDistrict(district);

        teamsNumbers.addAll(teams);
      }

      yield teamsNumbers;
    }
  },
);
