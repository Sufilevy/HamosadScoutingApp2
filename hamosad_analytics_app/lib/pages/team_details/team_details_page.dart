import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/team/stats/duration_models.dart';
import '/services/database/analytics_database.dart';
import '/services/providers/team_provider.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/scaffold.dart';
import '/widgets/text.dart';
import 'chips/durations_chip.dart';
import 'chips/four_rates_chip.dart';
import 'chips/number_chip.dart';
import 'chips/success_rate_chip.dart';
import 'chips/team_info_chip.dart';
import 'layout/chip_row.dart';
import 'layout/section_title.dart';

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
        horizontal: 12,
        vertical: 12,
        Column(
          children: <Widget>[
            ChipRow(
              children: <Widget>[
                TeamInfoChip(teamInfo.name, icon: Icons.people_rounded),
                TeamInfoChip(teamInfo.location, icon: Icons.location_city_rounded),
              ],
            ),
            const SectionDivider(),
            const ChipRow(
              children: <Widget>[
                NumberChip('Average Score', data: 64.15),
                NumberChip('Average RP', data: 2.3),
              ],
            ),
            const SectionTitle(icon: Icons.code_rounded, title: 'Auto'),
            const ChipRow(
              smallChips: true,
              children: <Widget>[
                NumberChip('Top Row', data: 12.3, small: true),
                NumberChip('Middle Row', data: 42.3, small: true),
                NumberChip('Bottom Row', data: 5.13, small: true),
              ],
            ),
            const SectionTitle(icon: Icons.person_rounded, title: 'Teleop'),
            const ChipRow(
              smallChips: true,
              children: <Widget>[
                NumberChip('Top Row', data: 12.3, small: true),
                NumberChip('Middle Row', data: 42.3, small: true),
                NumberChip('Bottom Row', data: 5.13, small: true),
              ],
            ),
            ChipRow(
              children: <Widget>[
                DurationsChip(
                  title: 'Dropoffs',
                  durations: durations,
                ),
              ],
            ),
            ChipRow(
              children: <Widget>[
                FourRatesChip(
                  titles: const ['Not Attempt', 'Failed', 'Docked', 'Engaged'],
                  rates: const [0.3, 0.25, 0.1, 0.35],
                ),
              ],
            ),
            const ChipRow(
              flexes: [2, 1],
              children: <Widget>[
                SuccessRateChip(
                  title: 'Docked',
                  successRate: 0.7,
                  failRate: 0.3,
                ),
                NumberChip('Bottom Row', data: 5.13, small: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamColorAvatar(Color color) {
    return pad(
      right: 10,
      top: 5,
      Container(
        width: 16 * AnalyticsTheme.appSizeRatio,
        height: 16 * AnalyticsTheme.appSizeRatio,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref) {
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
        final identifier = TeamReportsIdentifier(teamNumber, {district});
        final teamStream = ref.watch(teamReportsProvider(identifier));

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
