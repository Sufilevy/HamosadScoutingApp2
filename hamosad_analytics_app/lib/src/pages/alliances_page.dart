import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models/team.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class AlliancesPage extends StatefulWidget {
  const AlliancesPage({Key? key}) : super(key: key);

  static final Map<String, double Function(Team)> tableEntries = {
    'Win Rate': (team) => team.info.winRate,
    'Min. Auto. Cones': (team) => team.autonomus.cones.min.toDouble(),
    'Avg. Tele. Score': (team) => team.teleop.score.average,
    'Avg. Endg. Cubes': (team) => team.endgame.cubes.average,
  };

  @override
  State<AlliancesPage> createState() => _AlliancesPageState();
}

class _AlliancesPageState extends State<AlliancesPage> {
  final _blueAlliance = Alliance.blue(), _redAlliance = Alliance.red();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          _selectAlliancesBar(),
          const SizedBox(height: 10.0),
          Expanded(child: _alliancesTable()),
        ],
      ),
    );
  }

  Widget _selectAlliancesBar() => AnalyticsContainer(
        height: 60.0,
        child: Row(
          children: [
            _allianceList(_blueAlliance),
            _addTeamsButton(_blueAlliance),
            _divider(),
            _addTeamsButton(_redAlliance),
            _allianceList(_redAlliance),
          ],
        ),
      );

  Widget _allianceList(Alliance alliance) => Expanded(
        child: SizedBox(
          height: 45.0,
          child: AnimatedList(
            key: alliance.listKey,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: alliance.chipsPadding),
            itemBuilder: (context, index, animation) => ScaleTransition(
              scale: animation,
              child: _teamChip(index, alliance),
            ),
          ),
        ),
      );

  Widget _teamChip(int index, Alliance alliance) {
    String title = alliance.teams[index].toString();

    Widget chip([VoidCallback? onDeleted]) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
              decoration: BoxDecoration(
                color: alliance.color,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 29, right: 14),
                    child: SizedBox(
                      child: AnalyticsText.logo(
                        title,
                        color: AnalyticsTheme.foreground1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 9.0),
                    child: IconButton(
                      onPressed: onDeleted,
                      color: AnalyticsTheme.foreground1,
                      disabledColor: AnalyticsTheme.foreground1,
                      splashRadius: 1.0,
                      iconSize: 28.0,
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.cancel_rounded,
                      ),
                    ),
                  ),
                ],
              )),
        );

    return chip(() {
      setState(() {
        alliance.listKey.currentState?.removeItem(
          index,
          (context, animation) => ScaleTransition(
            scale: animation,
            child: chip(),
          ),
          duration: const Duration(milliseconds: 125),
        );
        Future.delayed(
          const Duration(milliseconds: 125),
          () => setState(
            () {
              alliance.teams.removeAt(index);
            },
          ),
        );
      });
    });
  }

  Widget _addTeamsButton(Alliance alliance) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            firstCurve: Curves.easeOut,
            secondCurve: Curves.easeIn,
            crossFadeState: alliance.teams.length < 3
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: IconButton(
              onPressed: () => setState(() {
                alliance.listKey.currentState?.insertItem(
                  alliance.teams.length,
                  duration: const Duration(milliseconds: 125),
                );
                alliance.teams.add(1657);
              }),
              iconSize: 40.0,
              padding: EdgeInsets.zero,
              splashRadius: 1.0,
              icon: Icon(
                Icons.add_circle_rounded,
                color: alliance.color,
              ),
            ),
            secondChild: Transform.rotate(
              angle: -math.pi / 4,
              child: const Icon(
                Icons.add_circle_rounded,
                color: AnalyticsTheme.background3,
                size: 40.0,
              ),
            ),
          ),
        ),
      );

  Widget _divider() => Container(
        height: 45.0,
        width: 2,
        decoration: BoxDecoration(
          color: AnalyticsTheme.foreground2,
          borderRadius: BorderRadius.circular(1.0),
        ),
      );

  Widget _alliancesTable() {
    final entries =
        AlliancesPage.tableEntries.entries.map(_tableEntry).toList();
    return AnalyticsContainer(
      child: ListView.builder(
        itemCount: AlliancesPage.tableEntries.length,
        itemBuilder: (context, index) => entries[index],
      ),
    );
  }

  Widget _tableEntry(MapEntry<String, double Function(Team)> entry) =>
      Text('${entry.key}:  ${entry.value}');
}

class Alliance {
  Alliance.red()
      : color = AnalyticsTheme.redAlliance,
        teams = [],
        listKey = GlobalKey();
  Alliance.blue()
      : color = AnalyticsTheme.blueAlliance,
        teams = [],
        listKey = GlobalKey();

  Color color;
  List<int> teams;
  GlobalKey<AnimatedListState> listKey;

  double get chipsPadding {
    switch (teams.length) {
      case 1:
        return 310.0;
      case 2:
        return 220.5;
      case 3:
        return 131.0;
      default:
        return 310.0;
    }
  }
}
