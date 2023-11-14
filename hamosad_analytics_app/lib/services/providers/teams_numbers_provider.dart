import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/database/analytics_database.dart';

class DistrictsIdentifier extends Equatable {
  const DistrictsIdentifier(this.districts);

  final Set<String> districts;

  @override
  List<Object?> get props => [districts];
}

final teamsNumbersProvider = StreamProvider.autoDispose.family<Set<String>, DistrictsIdentifier>(
  (_, identifier) {
    final districts = identifier.districts;

    final snapshots = districts.map(
      (district) => AnalyticsDatabase.teamsStreamOfDistrict(district),
    );

    return StreamGroup.merge(snapshots).asyncMap(
      (query) async {
        final teamsFutures = districts.map(
          (district) => AnalyticsDatabase.teamsOfDistrict(district),
        );
        final teams = await Future.wait(teamsFutures);

        return teams
            .reduce((allTeams, teamsOfDistrict) => allTeams..addAll(teamsOfDistrict))
            .toSet();
      },
    );
  },
);
