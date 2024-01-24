import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/analytics.dart';
import '/services/database/analytics_database.dart';

final selectedDistrictsProvider = AsyncNotifierProvider<SelectedDistrictsNotifier, Districts>(
  () {
    return SelectedDistrictsNotifier();
  },
);

class SelectedDistrictsNotifier extends AsyncNotifier<Districts> {
  @override
  FutureOr<Districts> build() async {
    return {
      await AnalyticsDatabase.currentDistrict(),
    };
  }

  void setDistricts(Districts districts) {
    state = AsyncValue.data(districts);
  }
}
