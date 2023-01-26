import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart' as db;
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

  List<Team> get _teams {
    return _blueAlliance.teams.followedBy(_redAlliance.teams).toList();
  }

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
          child: AnimatedPadding(
            padding: EdgeInsets.only(left: alliance.chipsPadding),
            duration: 200.milliseconds,
            child: AnimatedList(
              key: alliance.listKey,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index, animation) => ScaleTransition(
                scale: animation,
                child: _teamChipButton(index, alliance),
              ),
            ),
          ),
        ),
      );

  Widget _teamChipButton(int index, Alliance alliance) {
    return _teamChip(index, alliance, onDeleted: () {
      setState(() {
        Future.delayed(
          175.milliseconds,
          () => setState(() {
            alliance.teams.removeAt(index);
          }),
        );
        alliance.listKey.currentState?.removeItem(
          index,
          (context, animation) => ScaleTransition(
            scale: animation,
            child: _teamChip(index, alliance),
          ),
          duration: 125.milliseconds,
        );
      });
    });
  }

  Widget _teamChip(int index, Alliance alliance, {VoidCallback? onDeleted}) {
    String title = alliance.teams[index].info.number.toString();
    return Padding(
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
  }

  Widget _addTeamsButton(Alliance alliance) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 250),
            turns: alliance.teams.length < 3 ? 0.0 : 0.125,
            curve: Curves.easeOut,
            child: IconButton(
              onPressed: () => setState(
                alliance.teams.length < 3
                    ? () {
                        alliance.listKey.currentState?.insertItem(
                          alliance.teams.length,
                          duration: const Duration(milliseconds: 125),
                        );
                        alliance.teams.add(db
                            .getTeams()
                            .firstWhere((team) => !_teams.contains(team)));
                      }
                    : () {
                        Future.delayed(
                          175.milliseconds,
                          () => setState(() {
                            alliance.teams.clear();
                          }),
                        );
                        for (var i = 0; i < 3; i++) {
                          alliance.listKey.currentState?.removeItem(
                            0,
                            (context, animation) => ScaleTransition(
                              scale: animation,
                              child: _teamChip(0, alliance),
                            ),
                            duration: 125.milliseconds,
                          );
                        }
                      },
              ),
              iconSize: 40.0,
              padding: EdgeInsets.zero,
              splashRadius: 1.0,
              icon: Icon(
                Icons.add_circle_rounded,
                color: alliance.color
                    .withOpacity(alliance.teams.length < 3 ? 1.0 : 0.7),
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
    final entries = AlliancesPage.tableEntries.entries
        .map((entry) => _tableEntry(entry))
        .toList();
    return AnalyticsContainer(
      child: ListView.builder(
        itemCount: AlliancesPage.tableEntries.length,
        itemBuilder: (context, index) => entries[index],
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
      ),
    );
  }

  Widget _tableEntry(
    MapEntry<String, double Function(Team)> entry,
  ) {
    final teams = _teams
        .map((team) => Pair(team.info.number, entry.value(team)))
        .sortedByDescending((team) => team.second);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: AnalyticsContainer(
        height: 60.0,
        color: AnalyticsTheme.background1,
        padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10.0),
        child: Row(
          children: [
            Container(
              width: 300.0,
              alignment: Alignment.center,
              child: AnalyticsText.dataTitle(entry.key),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: _divider(),
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: teams.length,
                itemBuilder: (context, index) => _teamEntry(teams[index]),
                separatorBuilder: (context, index) => _divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamEntry(Pair<int, double> team) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            AnalyticsText.dataTitle(
              team.first.toString(),
              color: _teamColor(
                team.first,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.0, right: 8.0),
              child: Container(
                width: 4.0,
                height: 4.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AnalyticsTheme.foreground2,
                ),
              ),
            ),
            AnalyticsText.dataSubtitle(
              team.second.toStringAsPrecision(4).slice(0, 3),
            ),
          ],
        ),
      );

  Color _teamColor(int teamNumber) => _blueAlliance.contains(teamNumber)
      ? _blueAlliance.color
      : _redAlliance.color;
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
  List<Team> teams;
  GlobalKey<AnimatedListState> listKey;

  double get chipsPadding {
    switch (teams.length) {
      case 1:
        return 320.0;
      case 2:
        return 230.5;
      case 3:
        return 140.0;
      default:
        return 320.0;
    }
  }

  bool contains(int teamNumber) =>
      teams.any((team) => team.info.number == teamNumber);
}
