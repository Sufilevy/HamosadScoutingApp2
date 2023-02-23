import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class TeamDetailsPage extends StatefulWidget {
  const TeamDetailsPage({Key? key}) : super(key: key);

  static Team? team;

  @override
  State<TeamDetailsPage> createState() => _TeamDetailsPageState();
}

class _TeamDetailsPageState extends State<TeamDetailsPage> {
  late final Map<AnalyticsTab, List<Widget>> _tabs;
  final Cubit<AnalyticsTab> _currentTab = Cubit(AnalyticsTab.general);

  @override
  void initState() {
    if (TeamDetailsPage.team != null) {
      final team = TeamDetailsPage.team!;
      _tabs = {
        AnalyticsTab.general: [
          Row(
            children: [
              AnalyticsStatChip.fromStat(team.summary.score,
                  title: 'Total Score'),
              AnalyticsStatChip.fromStat(team.auto.score, title: 'Auto Score'),
              AnalyticsStatChip.fromStat(team.teleop.score,
                  title: 'Teleop Score'),
              AnalyticsStatChip.fromStat(team.endgame.score,
                  title: 'Endgame Score'),
              AnalyticsDataWinRate(
                won: team.summary.won,
                lost: team.summary.lost,
              ),
            ],
          ),
          Row(
            children: [
              AnalyticsDataChip(title: , data: team.summary),
              TeamDropoffsChart(dropoffs: team.summary.dropoffs),
            ],
          ),
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
    }
    super.initState();
  }

  Widget _buildTitle() {
    if (TeamDetailsPage.team == null) {
      return AnalyticsText.navigation('Search for a team:');
    } else {
      final team = TeamDetailsPage.team!;
      return Column(
        children: [
          AnalyticsPageTitle(
            title: 'Team ${team.info.number}',
            subtitle: '${team.info.name}, ${team.info.location}',
          ),
          const SizedBox(height: 20.0),
          AnalyticsTabsSelector(
            currentTabCubit: _currentTab,
            onTabSelected: () => setState(() {}),
          ),
        ],
      );
    }
  }

  Widget _buildBody() => Column(
        key: ValueKey<AnalyticsTab>(_currentTab.data),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _tabs[_currentTab.data]!,
      );

  @override
  Widget build(BuildContext context) {
    return AnalyticsPage(title: _buildTitle(), body: _buildBody());
  }
}
