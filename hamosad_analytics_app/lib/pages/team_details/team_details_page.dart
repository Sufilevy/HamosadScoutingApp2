import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:search_page/search_page.dart';

import '/services/providers/team_provider.dart';
import '/theme.dart';
import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/scaffold.dart';
import '/widgets/text.dart';
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
    return teamNumber == null ? _selectTeamPage(context) : _teamDetailsPage(context, ref);
  }

  Widget _selectTeamPage(BuildContext context) {
    final body = Scaffold(
      appBar: AnalyticsAppBar(
        title: 'Team Details',
        actions: [
          _searchTeamButton(context),
        ],
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
    Future.delayed(50.milliseconds, () => _showSearchTeamPage(context));
    return body;
  }

  Widget _teamDetailsPage(BuildContext context, WidgetRef ref) {
    final teamInfo = TeamInfo.fromNumber(teamNumber!);

    return Scaffold(
      appBar: AnalyticsAppBar(
        title: 'Team $teamNumber',
        titleAvatar: _teamColorAvatar(teamInfo.color),
        actions: [
          _searchTeamButton(context),
        ],
      ),
      drawer: const AnalyticsDrawer(),
      bottomNavigationBar: _bottomNavigationBar(),
      body: padSymmetric(
        horizontal: 12,
        vertical: 12,
        _detailsView(teamInfo, ref),
      ),
    );
  }

  Widget _searchTeamButton(BuildContext context) {
    return IconButton(
      icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
      onPressed: () => _showSearchTeamPage(context),
    );
  }

  void _showSearchTeamPage(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchPage(
        items: TeamInfo.teams.toList(),
        filter: (team) => [team.first, team.second.name, team.second.location],
        searchLabel: 'Search for a team',
        showItemsOnEmpty: true,
        suggestion: navigationTitleText('Search for a team by team number, name or location.'),
        failure: Center(child: navigationTitleText('No teams matching the filter.')),
        itemStartsWith: true,
        builder: (team) => padSymmetric(
          vertical: 5,
          horizontal: 10,
          ListTile(
            title: Row(
              children: [
                dataTitleText(team.first),
                Gap(20 * AnalyticsTheme.appSizeRatio),
                const DotDivider(),
                Gap(20 * AnalyticsTheme.appSizeRatio),
                dataSubtitleText(
                  '${team.second.name}, ${team.second.location}',
                  color: AnalyticsTheme.foreground2,
                ),
              ],
            ),
            onTap: () {
              context.pop();
              context.go('/team/${team.first}');
            },
            leading: _teamColorAvatar(team.second.color),
          ),
        ),
        searchStyle: AnalyticsTheme.navigationStyle,
        sort: (teamA, teamB) => teamA.first.compareTo(teamB.first),
      ),
    );
  }

  Widget _bottomNavigationBar() {
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

  Widget _detailsView(TeamInfo teamInfo, WidgetRef ref) {
    final teamStream = ref.watch(teamReportsProvider(teamNumber!));

    return teamStream.when(
      loading: () => const LoadingScreen(),
      error: (error, _) => navigationText(error.toString()),
      data: (team) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ChipRow(
              children: <Widget>[
                TeamInfoChip(teamInfo.name, icon: FontAwesomeIcons.users),
                TeamInfoChip(teamInfo.location, icon: FontAwesomeIcons.city),
              ],
            ),
            const SectionDivider(),
            navigationText(team.teamNumber),
            Column(
              children: team.reportsIds.map(dataSubtitleText).toList(),
            )
          ],
        ),
      ),
    );
  }
}
