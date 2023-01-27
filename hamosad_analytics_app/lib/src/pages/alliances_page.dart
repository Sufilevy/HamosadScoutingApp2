import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
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
    return _blueAlliance.teamsWith(_redAlliance);
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
            AddTeamsButton(
              alliance: _blueAlliance,
              otherAlliance: _redAlliance,
              addTeam: _addTeamToAlliance,
              clearTeams: _clearAllianceTeams,
            ),
            _divider(),
            AddTeamsButton(
              alliance: _redAlliance,
              otherAlliance: _blueAlliance,
              addTeam: _addTeamToAlliance,
              clearTeams: _clearAllianceTeams,
            ),
            _allianceList(_redAlliance),
          ],
        ),
      );

  void _addTeamToAlliance(Alliance alliance, Team team) => setState(() {
        alliance.listKey.currentState?.insertItem(
          alliance.teams.length,
          duration: 125.milliseconds,
        );
        alliance.teams.add(team);
        alliance.teamsLength.value++;
      });

  void _clearAllianceTeams(Alliance alliance) => setState(() {
        Future.delayed(
          175.milliseconds,
          () => setState(() {
            alliance.teams.clear();
            alliance.teamsLength.value = 0;
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
      });

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
            alliance.teamsLength.value--;
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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: AlliancesPage.tableEntries.length,
        itemBuilder: (context, index) => entries[index],
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
  ValueNotifier<int> teamsLength = ValueNotifier(0);
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

  bool get isBlue {
    return color == AnalyticsTheme.blueAlliance;
  }

  List<Team> teamsWith(Alliance otherAlliance) =>
      teams.followedBy(otherAlliance.teams).toList();
}

class AddTeamsButton extends StatefulWidget {
  const AddTeamsButton({
    Key? key,
    required this.alliance,
    required this.otherAlliance,
    required this.addTeam,
    required this.clearTeams,
  }) : super(key: key);

  final Alliance alliance, otherAlliance;
  final void Function(Alliance, Team) addTeam;
  final void Function(Alliance) clearTeams;

  @override
  State<AddTeamsButton> createState() => _AddTeamsButtonState();
}

class _AddTeamsButtonState extends State<AddTeamsButton>
    with SingleTickerProviderStateMixin {
  bool _isMenuOpen = false;
  late final AnimationController _colorAnimationController;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _colorAnimationController = AnimationController(
      vsync: this,
      duration: 250.milliseconds,
    );
    _colorAnimation = ColorTween(
      begin: widget.alliance.color,
      end: AnalyticsTheme.primary,
    ).animate(_colorAnimationController)
      ..addListener(() => setState(() {}));

    widget.alliance.teamsLength.addListener(() => setState(() {
          if (widget.alliance.teams.length == 2) {
            _colorAnimationController.reverse();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: _isMenuOpen,
      closeDuration: 150.milliseconds,
      portalFollower: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() {
          _isMenuOpen = false;
        }),
        child: TweenAnimationBuilder(
          duration: 150.milliseconds,
          tween: ColorTween(
            begin: Colors.transparent,
            end: _isMenuOpen ? Colors.black26 : Colors.transparent,
          ),
          builder: (context, color, child) => ColoredBox(color: color!),
        ),
      ),
      child: PortalTarget(
        visible: _isMenuOpen,
        anchor: const Aligned(
          follower: Alignment.topCenter,
          target: Alignment.bottomCenter,
        ),
        portalFollower: _addTeamsPopup(),
        child: _button(),
      ),
    );
  }

  Widget _button() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: 40.0,
          height: 40.0,
          child: AnimatedRotation(
            duration: 250.milliseconds,
            turns: widget.alliance.teams.length < 3 ? 0.0 : 0.125,
            curve: Curves.easeOut,
            child: IconButton(
              onPressed: () => setState(
                () {
                  if (widget.alliance.teams.length < 3) {
                    _isMenuOpen = true;
                  } else {
                    widget.clearTeams(widget.alliance);
                    Future.delayed(
                      175.milliseconds,
                      () => _colorAnimationController.reverse(),
                    );
                  }
                },
              ),
              iconSize: 40.0,
              padding: EdgeInsets.zero,
              splashRadius: 1.0,
              icon: Icon(
                Icons.add_circle_rounded,
                color: _colorAnimation.value,
              ),
            ),
          ),
        ),
      );

  Widget _addTeamsPopup() {
    final currentTeams = widget.alliance.teamsWith(widget.otherAlliance);
    final teams = db.getTeams().where((team) {
      return !currentTeams.contains(team);
    }).toList();

    final height = math.min(700.0, 11.0 + teams.length * 70);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnalyticsContainer(
        width: 500.0,
        height: height,
        border: Border.all(
          color: AnalyticsTheme.background3,
          width: 2.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) => _addTeamButton(teams[index]),
          ),
        ),
      ),
    );
  }

  Widget _addTeamButton(Team team) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: AnalyticsContainer(
          height: 60.0,
          color: AnalyticsTheme.background1,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const EmptyExpanded(flex: 1),
              Expanded(
                flex: 12,
                child: AnalyticsText.data(
                  team.info.number.toString(),
                  color: widget.alliance.color,
                ),
              ),
              const EmptyExpanded(flex: 1),
              const Expanded(flex: 1, child: AnalyticsDataDivider()),
              const EmptyExpanded(flex: 3),
              Expanded(
                flex: 50,
                child: AnalyticsText.dataTitle(team.info.name.toString()),
              ),
              Expanded(
                flex: 8,
                child: IconButton(
                  icon: const Icon(Icons.add_circle_rounded),
                  iconSize: 28.0,
                  color: widget.alliance.color,
                  onPressed: () => setState(() {
                    widget.addTeam(widget.alliance, team);
                    if (widget.alliance.teams.length == 3) {
                      _isMenuOpen = false;
                      _colorAnimationController.forward();
                    }
                  }),
                ),
              ),
              const EmptyExpanded(flex: 1),
            ],
          ),
        ),
      );
}
