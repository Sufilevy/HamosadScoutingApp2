import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/services/database/database.dart';
import '/widgets/loading_screen.dart';
import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';
import '/widgets/text.dart';

class TeamDetailsPage extends ConsumerWidget {
  const TeamDetailsPage(this.teamNumber, {super.key});

  final String teamNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);

    return Scaffold(
      appBar: AnalyticsAppBar(title: 'Team $teamNumber'),
      drawer: const AnalyticsDrawer(),
      body: FutureBuilder(
        future: database.currentDistrictName(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return navigationText('An error has ocurred.');
          }

          if (!snapshot.hasData) {
            return const LoadingScreen();
          }

          final districtName = snapshot.data!;
          final teamStream = ref.watch(teamProvider((teamNumber, districtName)));

          return teamStream.when(
            data: (team) => Column(
              children: team.reportsIds.map(navigationText).toList(),
            ),
            error: (error, _) => navigationText(error.toString()),
            loading: () => const LoadingScreen(),
          );
        },
      ),
    );
  }
}
