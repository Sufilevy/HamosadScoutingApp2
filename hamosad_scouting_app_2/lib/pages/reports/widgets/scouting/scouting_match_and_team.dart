import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/pages/reports/widgets/scouting/toggle/toggle_button.dart';

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'text/text_field.dart';

class ScoutingMatchAndTeam extends StatefulWidget {
  const ScoutingMatchAndTeam({
    super.key,
    required this.team,
    required this.match,
    required this.isRematch,
    required this.matches,
  });

  final Cubit<String?> team, match;
  final Cubit<bool> isRematch;
  final Map<String, List<String>> matches;

  @override
  State<ScoutingMatchAndTeam> createState() => _ScoutingMatchAndTeamState();
}

class _ScoutingMatchAndTeamState extends State<ScoutingMatchAndTeam> {
  String? _match;

  @override
  void initState() {
    _match = widget.match.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSelectMatch().padBottom(25),
        if (_match != null)
          ScoutingToggleButton(cubit: widget.isRematch, title: 'Is Rematch?').padBottom(25),
        if (_match != null) _buildSelectTeam(),
      ],
    );
  }

  Widget _buildSelectMatch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ScoutingText.title('Match:').padRight(50),
        DropdownButton<String>(
          value: _match,
          borderRadius: BorderRadius.circular(5 * ScoutingTheme.appSizeRatio),
          dropdownColor: ScoutingTheme.background2,
          style: ScoutingTheme.bodyStyle,
          alignment: Alignment.center,
          items: [
            'Eliminations (Round 1)',
            'Eliminations (Round 2)',
            'Eliminations (Round 3)',
            'Eliminations (Round 4)',
            'Eliminations (Round 5)',
            'Eliminations (Finals)',
            ...widget.matches.keys,
          ]
              .map(
                (match) => DropdownMenuItem<String>(
                  value: match,
                  child: Center(
                    child: ScoutingText.body(
                      match,
                      fontSize: 20 * ScoutingTheme.appSizeRatio,
                    ).padAll(8),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) => setState(() {
            if (value != null) {
              _match = value;
              widget.match.data = value;
            }
          }),
        ),
      ],
    );
  }

  Widget _buildSelectTeam() {
    return _match!.contains('Eliminations')
        ? ScoutingTextField(
            cubit: widget.team,
            onlyNumbers: true,
            hint: "Enter the team's number...",
            title: 'Team number',
            errorHint: 'Please enter a team number.',
          )
        : ScoutingTeamNumber(
            cubit: widget.team,
            teams: widget.matches[_match]!,
          );
  }
}

class ScoutingTeamNumber extends StatefulWidget {
  const ScoutingTeamNumber({
    super.key,
    required this.cubit,
    required this.teams,
  }) : assert(teams.length == 6);

  final Cubit<String?> cubit;
  final List<String> teams;

  @override
  State<ScoutingTeamNumber> createState() => _ScoutingTeamNumberState();
}

class _ScoutingTeamNumberState extends State<ScoutingTeamNumber> {
  var _currentTeamIndex = -1;

  @override
  void initState() {
    if (widget.cubit.data != null) {
      _currentTeamIndex = widget.teams.indexOf(widget.cubit.data!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTeamButton(context, 0),
            _buildTeamButton(context, 3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTeamButton(context, 1),
            _buildTeamButton(context, 4),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTeamButton(context, 2),
            _buildTeamButton(context, 5),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamButton(BuildContext context, int index) {
    const width = 120, height = 80, radius = 7.5;
    final duration = 400.milliseconds;
    final teamColor = index <= 2 ? ScoutingTheme.redAlliance : ScoutingTheme.blueAlliance;
    final isSelected = _currentTeamIndex == index;

    return padAll(
      12,
      Container(
        width: width * ScoutingTheme.appSizeRatio,
        height: height * ScoutingTheme.appSizeRatio,
        color: ScoutingTheme.background1,
        child: RepaintBoundary(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: duration,
                  curve: Curves.easeOutQuart,
                  width: isSelected ? width * ScoutingTheme.appSizeRatio : 0,
                  height: isSelected ? height * ScoutingTheme.appSizeRatio : 0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: teamColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
              ),
              SizedBox(
                width: width * ScoutingTheme.appSizeRatio,
                height: height * ScoutingTheme.appSizeRatio,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (!isSelected) {
                        _currentTeamIndex = index;
                        widget.cubit.data = widget.teams[index];
                      }
                    });
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: teamColor,
                        width: 2 * ScoutingTheme.appSizeRatio,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius),
                      ),
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: duration * 1.5,
                    curve: Curves.decelerate,
                    style: ScoutingTheme.titleStyle.copyWith(
                      fontSize: 30 * ScoutingTheme.appSizeRatio,
                      color: isSelected ? ScoutingTheme.background1 : teamColor,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Text(widget.teams[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
