import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/pages/team_details/widgets/number_chip.dart';

import '/services/database/database.dart';
import '/widgets/loading_screen.dart';
import '/widgets/paddings.dart';
import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';
import '/widgets/text.dart';
import 'widgets/team_info_chip.dart';

class TeamDetailsPage extends ConsumerWidget {
  const TeamDetailsPage(this.teamNumber, {super.key});

  final String teamNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AnalyticsAppBar(title: 'Team $teamNumber'),
      drawer: const AnalyticsDrawer(),
      body: padSymmetric(
        horizontal: 12.0,
        vertical: 12.0,
        Column(
          children: [
            const Row(
              children: [
                TeamInfoChip('Steampunk', icon: Icons.people_rounded),
                TeamInfoChip('Binyamina', icon: Icons.location_city_rounded),
              ],
            ).padBottom(10.0),
            const Row(
              children: [
                NumberChip('Average Score', data: 64.15),
                NumberChip('Average RP', data: 2.3),
              ],
            ).padBottom(10.0),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: AnalyticsDatabase.currentDistrict(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return navigationText('An error has ocurred.\n\n${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const LoadingScreen();
        }

        final district = snapshot.data!;
        final identifier = ReportsIdentifier(teamNumber, {district});
        final teamStream = ref.watch(teamProvider(identifier));

        return teamStream.when(
          data: (team) => Column(
            children: team.reportsIds.map(navigationText).toList(),
          ),
          error: (error, _) => navigationText(error.toString()),
          loading: () => const LoadingScreen(),
        );
      },
    );
  }
}
