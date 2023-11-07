import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/theme.dart';
import '/widgets/padding.dart';
import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';
import '/widgets/text.dart';
import 'widgets/select_teams.dart';
import 'widgets/selected_teams_chips.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key, this.selectedTeams, this.graph});

  final List<String>? selectedTeams;
  final String? graph;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalyticsAppBar(title: 'Compare Teams'),
      drawer: const AnalyticsDrawer(),
      body: padSymmetric(
        horizontal: 12,
        vertical: 12,
        Column(
          children: <Widget>[
            SelectTeams(
              teams: TeamInfo.teams,
              selectedTeams: selectedTeams,
              onSelectionChange: (teams) {
                if (selectedTeams == null || !listEquals(selectedTeams!, teams)) {
                  context.go(_newPageUri(teams).toString());
                }
              },
            ).padBottom(5),
            SelectedTeamsChips(
              selectedTeams: selectedTeams,
              onSelectionChange: (teams) {
                context.go(_newPageUri(teams).toString());
              },
            ).padBottom(15),
            navigationText('Graph :)')
          ],
        ),
      ),
    );
  }

  Uri _newPageUri(List<String> teams) {
    return Uri(
      path: '/compare',
      queryParameters: {
        if (graph != null) 'graph': graph,
        if (teams.isNotEmpty) 'teams': teams.join(','),
      },
    );
  }
}
