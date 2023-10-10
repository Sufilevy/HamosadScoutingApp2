import 'package:flutter/material.dart';

import '/widgets/scaffold/app_bar.dart';
import '/widgets/scaffold/drawer.dart';
import '/widgets/text.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalyticsAppBar(title: 'Teams'),
      drawer: const AnalyticsDrawer(),
      body: Center(
        child: navigationText('Hello World!'),
      ),
    );
  }
}
