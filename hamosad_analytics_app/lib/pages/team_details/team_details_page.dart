import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/team/stats/duration_models.dart';
import '/services/database/database.dart';
import '/theme.dart';
import '/widgets/loading_screen.dart';
import '/widgets/padding.dart';
import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';
import '/widgets/text.dart';
import 'widgets/chip_row.dart';
import 'widgets/durations_chip.dart';
import 'widgets/number_chip.dart';
import 'widgets/section_title.dart';
import 'widgets/team_info_chip.dart';

class TeamDetailsPage extends ConsumerWidget {
  const TeamDetailsPage(this.teamNumber, {super.key});

  final String teamNumber;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamInfo = TeamInfo.fromNumber(teamNumber);

    final durations = ActionDurationsStat.defaults();
    durations.updateWithDuration(ActionDuration.zeroToTwo);
    durations.updateWithDuration(ActionDuration.twoToFive);
    durations.updateWithDuration(ActionDuration.twoToFive);
    durations.updateWithDuration(ActionDuration.twoToFive);
    durations.updateWithDuration(ActionDuration.fivePlus);
    durations.updateWithDuration(ActionDuration.fivePlus);

    return Scaffold(
      appBar: AnalyticsAppBar(
        title: 'Team $teamNumber',
        titleAvatar: _teamColorAvatar(teamInfo.color),
      ),
      drawer: const AnalyticsDrawer(),
      body: padSymmetric(
        horizontal: 12.0,
        vertical: 12.0,
        Column(
          children: [
            ChipRow(
              children: [
                TeamInfoChip(teamInfo.name, icon: Icons.people_rounded),
                TeamInfoChip(teamInfo.location, icon: Icons.location_city_rounded),
              ],
            ),
            const SectionDivider(),
            const ChipRow(
              children: [
                NumberChip('Average Score', data: 64.15),
                NumberChip('Average RP', data: 2.3),
              ],
            ),
            const SectionTitle(icon: Icons.code_rounded, title: 'Auto'),
            const ChipRow(
              smallChips: true,
              children: [
                NumberChip('Top Row', data: 12.3, small: true),
                NumberChip('Middle Row', data: 42.3, small: true),
                NumberChip('Bottom Row', data: 5.13, small: true),
              ],
            ),
            const SectionTitle(icon: Icons.person_rounded, title: 'Teleop'),
            const ChipRow(
              smallChips: true,
              children: [
                NumberChip('Top Row', data: 12.3, small: true),
                NumberChip('Middle Row', data: 42.3, small: true),
                NumberChip('Bottom Row', data: 5.13, small: true),
              ],
            ),
            ChipRow(
              children: [
                DurationsChip(
                  title: 'Dropoffs',
                  durations: durations,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _teamColorAvatar(Color color) {
    return pad(
      right: 10.0,
      top: 5.0,
      Container(
        width: 16.0 * AnalyticsTheme.appSizeRatio,
        height: 16.0 * AnalyticsTheme.appSizeRatio,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
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
