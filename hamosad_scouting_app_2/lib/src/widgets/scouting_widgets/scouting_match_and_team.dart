import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

class ScoutingTeamNumber extends StatefulWidget {
  final Cubit<String?> cubit;
  final double size;
  final List<String> teams;

  const ScoutingTeamNumber({
    Key? key,
    required this.cubit,
    required this.teams,
    this.size = 1,
  })  : assert(teams.length == 6),
        super(key: key);

  @override
  State<ScoutingTeamNumber> createState() => _ScoutingTeamNumberState();
}

class _ScoutingTeamNumberState extends State<ScoutingTeamNumber> {
  final Duration _duration = 400.milliseconds;
  int _currentTeamIndex = -1;
  final double _width = 120.0, _height = 80.0, _radius = 7.5;

  @override
  void initState() {
    if (widget.cubit.data != null) {
      _currentTeamIndex = widget.teams.indexOf(widget.cubit.data!);
    }
    super.initState();
  }

  Widget _buildTeamButton(BuildContext context, int index) {
    final Color teamColor =
        index <= 2 ? ScoutingTheme.redAlliance : ScoutingTheme.blueAlliance;
    final bool isSelected = _currentTeamIndex == index;

    return Padding(
      padding: EdgeInsets.all(12.0 * widget.size),
      child: Container(
        width: _width * widget.size,
        height: _height * widget.size,
        color: ScoutingTheme.background1,
        child: RepaintBoundary(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeOutQuart,
                  width: isSelected ? _width * widget.size : 0.0,
                  height: isSelected ? _height * widget.size : 0.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: teamColor,
                    borderRadius: BorderRadius.circular(_radius),
                  ),
                ),
              ),
              SizedBox(
                width: _width * widget.size,
                height: _height * widget.size,
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
                        width: 2.0 * widget.size,
                      ),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(_radius),
                      ),
                    ),
                  ),
                  child: AnimatedDefaultTextStyle(
                    duration: _duration * 1.5,
                    curve: Curves.decelerate,
                    style: ScoutingTheme.titleStyle.copyWith(
                      fontSize: 30.0 * widget.size,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTeamButton(context, 0),
            _buildTeamButton(context, 3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTeamButton(context, 1),
            _buildTeamButton(context, 4),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTeamButton(context, 2),
            _buildTeamButton(context, 5),
          ],
        ),
      ],
    );
  }
}

class ScoutingMatchAndTeam extends StatefulWidget {
  const ScoutingMatchAndTeam({
    super.key,
    required this.matches,
    required this.team,
    required this.match,
    this.size = 1.0,
  });

  final Map<String, List<String>> matches;
  final Cubit<String?> team, match;
  final double size;

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

  Widget _buildSelectMatch() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScoutingText.title('Match:'),
          SizedBox(width: 50.0 * widget.size),
          DropdownButton<String>(
            value: _match,
            borderRadius: BorderRadius.circular(5.0 * widget.size),
            dropdownColor: ScoutingTheme.background2,
            style: ScoutingTheme.textStyle,
            alignment: Alignment.center,
            items: widget.matches.keys
                .prependElement('Eliminations')
                .map(
                  (match) => DropdownMenuItem<String>(
                    value: match,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ScoutingText.text(
                          match,
                          fontSize: 20.0 * widget.size,
                        ),
                      ),
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

  Widget _buildSelectTeam() => _match == 'Eliminations'
      ? ScoutingTextField(
          cubit: widget.team,
          onlyNumbers: true,
          hint: 'Enter the team\'s number...',
          title: 'Team number',
          errorHint: 'Please enter a team number.',
        )
      : ScoutingTeamNumber(
          size: widget.size,
          cubit: widget.team,
          teams: widget.matches[_match]!,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSelectMatch(),
        SizedBox(height: 25.0 * widget.size),
        if (_match != null) _buildSelectTeam(),
      ],
    );
  }
}
