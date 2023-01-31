import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class TeamDetailsPage extends StatefulWidget {
  const TeamDetailsPage({Key? key}) : super(key: key);

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  final Map<AnalyticsTab, List<Widget>> _tabs = {
    AnalyticsTab.general: [
      const AnalyticsDataChip(title: 'Average Score', data: '34'),
      const AnalyticsDataChip(title: 'Average RP', data: '2.33'),
      const AnalyticsDataWinRate(won: 20, lost: 8),
      const AnalyticsStatChip(
          title: 'Autunomous Score', average: '100', max: '20', min: '103'),
    ],
    AnalyticsTab.auto: [
      const Text('Auto'),
    ],
    AnalyticsTab.teleop: [
      const Text('Teleop'),
    ],
    AnalyticsTab.endgame: [
      const Text('Endgame'),
    ],
  };
  final Cubit<AnalyticsTab> _currentTab = Cubit(AnalyticsTab.general);

  @override
  Widget build(BuildContext context) {
    return AnalyticsPage(title: _title(), body: _body());
  }

  Widget _title() => Column(
        children: [
          const AnalyticsPageTitle(
            title: 'Team 3075',
            subtitle: 'Ha-Dream Team, Hod-Ha\'Sharon',
          ),
          const SizedBox(height: 20.0),
          AnalyticsTabsSelector(
            currentTabCubit: _currentTab,
            onTabSelected: () => setState(() {}),
          ),
        ],
      );

  Widget _body() => Column(
        key: ValueKey<AnalyticsTab>(_currentTab.data),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _tabs[_currentTab.data]!,
      );
}
