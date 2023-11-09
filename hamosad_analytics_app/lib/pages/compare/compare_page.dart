import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/theme.dart';
import '/widgets/padding.dart';
import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';
import 'graphs.dart';
import 'widgets/graph_with_selection.dart';
import 'widgets/selected_teams_chips.dart';
import 'widgets/teams_select.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key, this.selectedTeams});

  final List<String>? selectedTeams;

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
            TeamsSelect(
              teams: TeamInfo.teams,
              selectedTeams: selectedTeams,
              onSelectionChange: (teams) {
                if (selectedTeams == null || !listEquals(selectedTeams!, teams)) {
                  context.go(_newPageUri(teams).toString());
                }
              },
            ).padBottom(10),
            if (selectedTeams != null)
              SelectedTeamsChips(
                selectedTeams: selectedTeams!,
                onSelectionChange: (teams) {
                  context.go(_newPageUri(teams).toString());
                },
              ).padBottom(12),
            const Divider().padBottom(8),
            Expanded(
              child: ListView.builder(
                itemCount: Graph.allGraphs.length,
                itemBuilder: (context, index) => padBottom(
                  16,
                  GraphWithSelection(
                    initialGraphIndex: index,
                    selectedTeams: selectedTeams ?? [],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Uri _newPageUri(List<String> teams) {
    return Uri(
      path: '/compare',
      queryParameters: {
        if (teams.isNotEmpty) 'teams': teams.join(','),
      },
    );
  }
}
