import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class TeamDetailsPage extends StatefulWidget {
  const TeamDetailsPage({Key? key}) : super(key: key);

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  final Cubit<AnalyticsTab> _currentTab = Cubit(AnalyticsTab.general);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        children: [
          _title,
          const SizedBox(height: 20.0),
          AnalyticsTabsSelector(
            currentTabCubit: _currentTab,
            onTabSelected: () => setState(() {}),
          ),
          const SizedBox(height: 20.0),
          _tabBody,
        ],
      ),
    );
  }

  Widget get _title => Row(
        children: [
          SizedBox(
            width: 120,
            height: 30,
            child: Align(
              alignment: Alignment.centerRight,
              child: AnalyticsText.dataTitle('Team 3075'),
            ),
          ),
          const SizedBox(
            width: 20,
            height: 30,
            child: VerticalDivider(
              color: AnalyticsTheme.foreground1,
              thickness: 1.5,
              width: 30,
            ),
          ),
          SizedBox(
            width: 450,
            height: 30,
            child: Align(
              alignment: Alignment.centerLeft,
              child:
                  AnalyticsText.dataSubtitle('Ha-Dream Team, Hod-Ha\'Sharon'),
            ),
          ),
        ],
      );

  Widget get _tabBody => Expanded(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AnalyticsTheme.background2,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: AnalyticsFadeSwitcher(
                    child: Column(
                  key: ValueKey<AnalyticsTab>(_currentTab.data),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _tabs[_currentTab.data]!,
                )),
              ),
            ),
          ],
        ),
      );

  final Map<AnalyticsTab, List<Widget>> _tabs = {
    AnalyticsTab.general: [
      const AnalyticsDataChip(title: 'Average Score', data: '34'),
      const AnalyticsDataChip(title: 'Average RP', data: '2.33'),
      const AnalyticsDataWinRate(won: 20, lost: 8),
    ],
    AnalyticsTab.autonomous: [
      const Text('Autonomous'),
    ],
    AnalyticsTab.teleop: [
      const Text('Teleop'),
    ],
    AnalyticsTab.endgame: [
      const Text('Endgame'),
    ],
  };
}
