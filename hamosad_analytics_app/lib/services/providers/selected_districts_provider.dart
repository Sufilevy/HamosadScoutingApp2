import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/database/analytics_database.dart';

typedef Districts = Set<String>;

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

  void setDistricts(Set<String> districts) {
    state = AsyncValue.data(districts);
  }
}
