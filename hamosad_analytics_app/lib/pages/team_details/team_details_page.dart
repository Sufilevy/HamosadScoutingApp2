import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  TeamDetailsPage({super.key, this.teamNumber});

  final String? teamNumber;
  final List<GlobalKey> _sectionKeys = [
    GlobalKey(debugLabel: 'Auto'),
    GlobalKey(debugLabel: 'Teleop'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return teamNumber == null ? _selectTeamPage(context) : _teamDetailsPage(context);
  }

  Widget _selectTeamPage(BuildContext context) {
    return Scaffold(
      appBar: const AnalyticsAppBar(
        title: 'Team Details',
      ),
      drawer: const AnalyticsDrawer(),
      body: padSymmetric(
        horizontal: 12,
        vertical: 12,
        Center(
          child: navigationText('Search for a team to view details.', fontSize: 32),
        ),
      ),
    );
  }

  Widget _teamDetailsPage(BuildContext context) {
    final teamInfo = TeamInfo.fromNumber(teamNumber!);

    return Scaffold(
      appBar: AnalyticsAppBar(
        title: 'Team $teamNumber',
        titleAvatar: _teamColorAvatar(teamInfo.color),
      ),
      drawer: const AnalyticsDrawer(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: padSymmetric(
        horizontal: 12,
        vertical: 12,
        _detailsView(teamInfo),
      ),
    );
  }

  AnalyticsBottomNavigationBar _bottomNavigationBar() {
    return AnalyticsBottomNavigationBar(
      onTap: (newIndex) {
        final sectionContext = _sectionKeys[newIndex].currentContext;
        Scrollable.ensureVisible(sectionContext!, duration: 250.milliseconds);
      },
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.code),
          label: 'Auto',
          backgroundColor: AnalyticsTheme.background1,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidUser),
          label: 'Teleop',
          backgroundColor: AnalyticsTheme.background1,
        ),
      ],
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
        final identifier = TeamReportsIdentifier(teamNumber!, {district});
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

  Widget _detailsView(TeamInfo teamInfo) {
    final durations = ActionDurationsStat.defaults();
    durations.updateWithDuration(ActionDuration.zeroToTwo);
    durations.updateWithDuration(ActionDuration.twoToFive);
    durations.updateWithDuration(ActionDuration.twoToFive);
    durations.updateWithDuration(ActionDuration.twoToFive);
    durations.updateWithDuration(ActionDuration.fivePlus);
    durations.updateWithDuration(ActionDuration.fivePlus);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ChipRow(
            children: <Widget>[
              TeamInfoChip(teamInfo.name, icon: FontAwesomeIcons.users),
              TeamInfoChip(teamInfo.location, icon: FontAwesomeIcons.city),
            ],
          ),
          const SectionDivider(),
          const ChipRow(
            children: <Widget>[
              NumberChip('Average Score', data: 64.15),
              NumberChip('Average RP', data: 2.3),
            ],
          ),
          SectionTitle(key: _sectionKeys[0], icon: FontAwesomeIcons.code, title: 'Auto'),
          const ChipRow(
            smallChips: true,
            children: <Widget>[
              NumberChip('Top Row', data: 12.3, small: true),
              NumberChip('Middle Row', data: 42.3, small: true),
              NumberChip('Bottom Row', data: 5.13, small: true),
            ],
          ),
          SectionTitle(key: _sectionKeys[1], icon: FontAwesomeIcons.solidUser, title: 'Teleop'),
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
    );
  }
}
