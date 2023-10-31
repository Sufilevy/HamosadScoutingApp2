import 'package:flutter/material.dart';

import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key, this.teams, this.graph});

  final List<String>? teams;
  final String? graph;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AnalyticsAppBar(title: 'Compare Teams'),
      drawer: AnalyticsDrawer(),
    );
  }
}
