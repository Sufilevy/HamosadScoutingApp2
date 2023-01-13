import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';
import 'package:sidebarx/sidebarx.dart';

class AnalyticsApp extends StatefulWidget {
  const AnalyticsApp({super.key});

  @override
  State<AnalyticsApp> createState() => _AnalyticsAppState();
}

class _AnalyticsAppState extends State<AnalyticsApp> {
  Widget pages(int index) => [
        const TeamDetailsPage(),
        const TeamsPage(),
        const ReportDetailsPage(),
        const ReportsPage(),
        const AlliancesPage()
      ][index];

  final SidebarXController _sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  @override
  void initState() {
    super.initState();
    _sidebarController.addListener((() => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Analytics',
      themeMode: ThemeMode.dark,
      home: Scaffold(
        backgroundColor: AnalyticsTheme.background1,
        body: Row(
          children: [
            Sidebar(
              _sidebarController,
              onRefreshData: () => setState(() {}),
              items: const [
                SidebarXItem(
                  icon: Icons.people_outline_rounded,
                  label: 'Team Details',
                ),
                SidebarXItem(
                  icon: Icons.groups_outlined,
                  label: 'Teams',
                ),
                SidebarXItem(
                  icon: Icons.assignment_outlined,
                  label: 'Report Details',
                ),
                SidebarXItem(
                  icon: Icons.source_outlined,
                  label: 'Reports',
                ),
                SidebarXItem(
                  icon: Icons.assessment_outlined,
                  label: 'Alliances',
                ),
              ],
            ),
            Expanded(
              child: AnalyticsFadeSwitcher(
                child: Container(
                  key: ValueKey<int>(_sidebarController.selectedIndex),
                  child: pages(_sidebarController.selectedIndex),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
