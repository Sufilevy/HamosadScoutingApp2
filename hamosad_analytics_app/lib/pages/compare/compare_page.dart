import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/widgets/padding.dart';
import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';
import 'widgets/select_teams.dart';

final availableTeams = ['1577', '1657', '1690'];

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
              teams: availableTeams,
              selectedTeams: selectedTeams,
              onSelectionChange: (teams) {
                if (selectedTeams == null || !listEquals(selectedTeams!, teams)) {
                  context.go(_newPageUri(teams).toString());
                }
              },
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
        if (graph != null) 'graph': graph,
        if (teams.isNotEmpty) 'teams': teams.join(','),
      },
    );
  }
}
