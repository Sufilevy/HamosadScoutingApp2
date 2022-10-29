import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:xcontext/material.dart';

class ScoutingTeamNumber extends StatefulWidget {
  final Cubit<String> cubit;
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
  final Duration _duration = 400.ms;
  int _currentTeamIndex = -1;
  final double _width = 120, _height = 90, _radius = 7.5;

  Widget _teamButton(BuildContext context, int index) {
    final Color teamColor =
        index <= 2 ? const Color(0xFFC62828) : const Color(0xFF1E88E5);
    final bool isSelected = _currentTeamIndex == index;

    return Padding(
      padding: EdgeInsets.all(12 * widget.size),
      child: Container(
        width: _width * widget.size,
        height: _height * widget.size,
        color: context.theme.backgroundColor,
        child: RepaintBoundary(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: _duration,
                  curve: Curves.easeOutQuart,
                  width: isSelected ? _width * widget.size : 0,
                  height: isSelected ? _height * widget.size : 0,
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
                      if (isSelected) {
                        _currentTeamIndex = -1;
                        widget.cubit.data = '';
                      } else {
                        _currentTeamIndex = index;
                        widget.cubit.data = widget.teams[index];
                      }
                    });
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      BorderSide(
                        color: teamColor,
                        width: 2 * widget.size,
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
                    style: TextStyle(
                      fontSize: 28 * widget.size,
                      color: isSelected
                          ? context.theme.backgroundColor
                          : teamColor,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _teamButton(context, 0),
            _teamButton(context, 3),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _teamButton(context, 1),
            _teamButton(context, 4),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _teamButton(context, 2),
            _teamButton(context, 5),
          ],
        ),
      ],
    );
  }
}
