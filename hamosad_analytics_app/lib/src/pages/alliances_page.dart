import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class AlliancesPage extends StatefulWidget {
  const AlliancesPage({Key? key}) : super(key: key);

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
        height: 60,
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
        child: Center(
          child: AnimatedList(
            key: alliance.listKey,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index, animation) => ScaleTransition(
              scale: animation,
              child: _teamChip(index, alliance),
            ),
          ),
        ),
      );

  Widget _teamChip(int index, Alliance alliance) {
    String title = alliance.teams[index].toString();
    Color color = alliance.color;

    Widget chip([VoidCallback? onDeleted]) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Chip(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 9.0,
            ),
            label: Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 13.0,
              ),
              child: AnalyticsText.logo(
                title,
                color: AnalyticsTheme.foreground1,
              ),
            ),
            onDeleted: onDeleted,
            deleteIcon: const Icon(
              Icons.cancel_rounded,
              color: AnalyticsTheme.foreground1,
              size: 28.0,
            ),
          ),
        );

    return chip(
      () => setState(() {
        alliance.listKey.currentState?.removeItem(
          index,
          (context, animation) => ScaleTransition(
            scale: animation,
            child: chip(),
          ),
          duration: const Duration(milliseconds: 100),
        );
        alliance.teams.removeAt(index);
      }),
    );
  }

  Widget _addTeamsButton(Alliance alliance) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            firstCurve: Curves.linearToEaseOut,
            secondCurve: Curves.linearToEaseOut,
            crossFadeState: alliance.teams.length < 3
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: IconButton(
              onPressed: () => setState(() {
                alliance.listKey.currentState?.insertItem(
                  alliance.teams.length,
                  duration: const Duration(milliseconds: 100),
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

  Widget _alliancesTable() => const AnalyticsContainer(
        child: Text('body'),
      );
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
}
