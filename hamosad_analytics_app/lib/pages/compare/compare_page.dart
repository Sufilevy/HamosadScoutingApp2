import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '/services/providers/teams_provider.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/scaffold.dart';
import '/widgets/text.dart';
import 'charts/chart_with_selection.dart';
import 'charts/charts.dart';
import 'teams/selected_teams_chips.dart';
import 'teams/teams_select.dart';

class ComparePage extends ConsumerStatefulWidget {
  const ComparePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ComparePageState();
}

class _ComparePageState extends ConsumerState<ComparePage> {
  var _selectedTeams = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalyticsAppBar(title: 'Compare Teams'),
      drawer: const AnalyticsDrawer(),
      body: padSymmetric(
        horizontal: 12,
        vertical: 12,
        _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: <Widget>[
        _teamsSelect(context),
        Gap(10 * AnalyticsTheme.appSizeRatio),
        if (_selectedTeams.isNotEmpty) _selectedTeamsChips(context).padBottom(12),
        const Divider(),
        Gap(8 * AnalyticsTheme.appSizeRatio),
        Expanded(
          child: _charts(),
        ),
      ],
    );
  }

  Widget _teamsSelect(BuildContext context) {
    return TeamsSelect(
      teams: TeamInfo.teams,
      selectedTeams: _selectedTeams,
      onSelectionChange: (teamsList) {
        final teams = teamsList.toSet();
        if (_selectedTeams.isEmpty || !setEquals(_selectedTeams, teams)) {
          setState(() => _selectedTeams = teams);
        }
      },
    );
  }

  Widget _selectedTeamsChips(BuildContext context) {
    return SelectedTeamsChips(
      selectedTeams: _selectedTeams,
      onSelectionChange: (teams) => setState(() => _selectedTeams = teams),
    );
  }

  Widget _charts() {
    final identifier = TeamsWithReportsIdentifier(_selectedTeams, const {'district1-1657'});
    final teamStream = ref.watch(teamsWithReportsProvider(identifier));

    return teamStream.when(
      data: (teamsWithReports) => _selectedTeams.isEmpty || teamsWithReports.isEmpty
          ? _noReportsMessage()
          : ListView.builder(
              itemCount: Charts.length,
              itemBuilder: (context, index) => padBottom(
                16,
                ChartWithSelection(
                  initialChartIndex: index,
                  teamsWithReports: const {},
                ),
              ),
            ),
      error: (error, _) => navigationText(error),
      loading: () => _selectedTeams.isEmpty ? _noReportsMessage() : const LoadingScreen(),
    );
  }

  Widget _noReportsMessage() {
    return navigationText(
      'Select teams with\nsubmitted reports\nto view charts.',
      fontSize: 32,
    ).padSymmetric(horizontal: 24);
  }
}
