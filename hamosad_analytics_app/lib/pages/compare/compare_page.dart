import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '/models/report/report_model.dart';
import '/services/database/analytics_database.dart';
import '/services/providers/teams_numbers_provider.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/scaffold.dart';
import '/widgets/text.dart';
import 'charts/analytics_chart.dart';
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
        FutureBuilder(
          future: AnalyticsDatabase.currentDistrict(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return navigationText('An error has ocurred.\n\n${snapshot.error}');
            }

            if (!snapshot.hasData) {
              return const LoadingScreen();
            }

            final district = snapshot.data!;
            final identifier = DistrictsIdentifier({district});
            final teamsNumbersStream = ref.watch(teamsNumbersProvider(identifier));

            return teamsNumbersStream.when(
              data: (teamsNumbers) => _body(context, teamsNumbers),
              error: (error, _) => navigationText(error.toString()),
              loading: () => const LoadingScreen(),
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, Set<String> teamsNumbers) {
    return Column(
      children: <Widget>[
        _teamsSelect(context, teamsNumbers),
        Gap(10 * AnalyticsTheme.appSizeRatio),
        if (_selectedTeams.isNotEmpty) _selectedTeamsChips(context).padBottom(12),
        const Divider(),
        Gap(8 * AnalyticsTheme.appSizeRatio),
        Expanded(
          child: _charts({
            '1577': [
              const Report(15),
              const Report(10),
              const Report(12),
              const Report(17),
              const Report(12),
              const Report(14),
              const Report(18),
            ],
            '1657': [
              const Report(4),
              const Report(3),
              const Report(6),
            ],
            '1690': [
              const Report(16),
              const Report(21),
              const Report(13),
              const Report(15),
            ],
          }),
        ),
      ],
    );
  }

  Widget _teamsSelect(BuildContext context, Set<String> teamsNumbers) {
    return TeamsSelect(
      teams: teamsNumbers,
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

  Widget _charts(TeamsWithReports teamsWithReports) {
    return ListView.builder(
      itemCount: Charts.length,
      itemBuilder: (context, index) => padBottom(
        16,
        ChartWithSelection(
          initialChartIndex: index,
          selectedTeams: _selectedTeams,
          teamsWithReports: teamsWithReports,
        ),
      ),
    );
  }
}
