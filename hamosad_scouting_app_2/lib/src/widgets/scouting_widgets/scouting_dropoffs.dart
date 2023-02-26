import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScoutingDropoffs extends StatefulWidget {
  const ScoutingDropoffs({
    Key? key,
    required this.cubit,
    this.size = 1.0,
  }) : super(key: key);

  final double size;
  final Cubit<Dropoffs> cubit;

  @override
  State<ScoutingDropoffs> createState() => _ScoutingDropoffsState();
}

class _ScoutingDropoffsState extends State<ScoutingDropoffs> {
  int _column = 0, _row = 0;
  Grid _grid = Grid.arenaWall;
  Piece _piece = Piece.cone;
  ActionDuration _duration = ActionDuration.twoToFive;

  Widget _buildSelectGrid() => ToggleSwitch(
        cornerRadius: 10.0 * widget.size,
        inactiveBgColor: ScoutingTheme.background2,
        inactiveFgColor: ScoutingTheme.foreground2,
        activeBgColors: const [
          [ScoutingTheme.primaryVariant],
          [ScoutingTheme.primaryVariant],
          [ScoutingTheme.primaryVariant],
        ],
        activeFgColor: ScoutingTheme.foreground1,
        initialLabelIndex: _grid.index,
        totalSwitches: 3,
        labels: const ['Arena Wall', 'Co-Op', 'Loading Zone'],
        fontSize: 26.0 * widget.size,
        customWidths: [
          190.0 * widget.size,
          160.0 * widget.size,
          210.0 * widget.size,
        ],
        animate: true,
        curve: Curves.easeOutQuint,
        onToggle: (index) => setState(() {
          _grid = Grid.values[index ?? 0];
        }),
      );

  Piece? _getNodePiece(int row, int column) {
    final node = widget.cubit.data.grids[_grid.index].dropoffs[row][column];
    if (node.cone) {
      return Piece.cone;
    } else if (node.cube) {
      return Piece.cube;
    }
    return null;
  }

  Widget _buildNodeButton(
    int row,
    int column, {
    bool cone = false,
    bool cube = false,
  }) =>
      ElevatedButton(
        onPressed: () => setState(() {
          _row = row;
          _column = column;
        }),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            (_row == row && _column == column)
                ? ScoutingTheme.background2
                : ScoutingTheme.background1,
          ),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateProperty.all(
            BorderSide(
              color: _getNodePiece(row, column)?.color ?? Colors.transparent,
              width: 1.5,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0 * widget.size),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (cone)
                AnimatedDefaultTextStyle(
                  style: (_row == row && _column == column)
                      ? ScoutingTheme.textStyle.copyWith(
                          color: ScoutingTheme.cones,
                          fontWeight: FontWeight.w600,
                          fontSize: 31.0 * widget.size,
                        )
                      : ScoutingTheme.textStyle.copyWith(
                          color: ScoutingTheme.foreground2,
                          fontWeight: FontWeight.w400,
                          fontSize: 28.0 * widget.size,
                        ),
                  duration: 200.milliseconds,
                  child: const Text('Cone'),
                ),
              if (cone && cube) SizedBox(height: 10.0 * widget.size),
              if (cube)
                AnimatedDefaultTextStyle(
                  style: (_row == row && _column == column)
                      ? ScoutingTheme.textStyle.copyWith(
                          color: ScoutingTheme.cubes,
                          fontWeight: FontWeight.w600,
                          fontSize: 31.0 * widget.size,
                        )
                      : ScoutingTheme.textStyle.copyWith(
                          color: ScoutingTheme.foreground2,
                          fontWeight: FontWeight.w400,
                          fontSize: 28.0 * widget.size,
                        ),
                  duration: 200.milliseconds,
                  child: const Text('Cube'),
                ),
            ],
          ),
        ),
      );

  Widget _buildSelectNode() => Container(
        width: 500.0 * widget.size,
        height: 500.0 * widget.size,
        decoration: BoxDecoration(
          color: ScoutingTheme.background2,
          borderRadius: BorderRadius.circular(2.0),
          border: Border.all(
            color: ScoutingTheme.background2,
            width: 3.0,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildNodeButton(0, 0, cone: true),
            _buildNodeButton(0, 1, cube: true),
            _buildNodeButton(0, 2, cone: true),
            _buildNodeButton(1, 0, cone: true),
            _buildNodeButton(1, 1, cube: true),
            _buildNodeButton(1, 2, cone: true),
            _buildNodeButton(2, 0, cone: true, cube: true),
            _buildNodeButton(2, 1, cone: true, cube: true),
            _buildNodeButton(2, 2, cone: true, cube: true),
          ],
        ),
      );

  Piece _getCurrentPiece() {
    if (_row == 2) return _piece;
    if (_column == 1) return Piece.cube;
    return Piece.cone;
  }

  Widget _buildSelectPiece() => ToggleSwitch(
        cornerRadius: 10.0 * widget.size,
        inactiveBgColor: ScoutingTheme.background2,
        inactiveFgColor:
            (_row == 2) ? ScoutingTheme.foreground2 : ScoutingTheme.background2,
        activeBgColors: const [
          [ScoutingTheme.cones],
          [ScoutingTheme.cubes],
        ],
        activeFgColor: ScoutingTheme.foreground1,
        initialLabelIndex: _getCurrentPiece().index,
        totalSwitches: 2,
        labels: const ['Cone', 'Cube'],
        fontSize: 30.0 * widget.size,
        minWidth: 150.0 * widget.size,
        animate: true,
        curve: Curves.easeOutQuint,
        onToggle: (index) => setState(() {
          _piece = Piece.values[index ?? 0];
        }),
      );

  void _setCurrentNodeTaken(bool value) {
    final node = widget.cubit.data.grids[_grid.index].dropoffs[_row][_column];
    _getCurrentPiece() == Piece.cone ? node.cone = value : node.cube = value;
  }

  void _setCurrentNodeDuration() {
    final node = widget.cubit.data.grids[_grid.index].dropoffs[_row][_column];
    node.duration = _duration;
  }

  bool _getCurrentNodeTaken() {
    final node = widget.cubit.data.grids[_grid.index].dropoffs[_row][_column];
    return node.cone || node.cube;
  }

  Widget _buildCheckbox() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.0 * widget.size),
            child: TextButton(
              onPressed: () => setState(() {
                _setCurrentNodeTaken(!_getCurrentNodeTaken());
                _setCurrentNodeDuration();
              }),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4.0 * widget.size,
                  horizontal: 2.0 * widget.size,
                ),
                child: ScoutingText.text('Piece placed:',
                    color: ScoutingTheme.foreground2),
              ),
            ),
          ),
          Transform.scale(
            scale: 1.75 * widget.size,
            child: Checkbox(
              value: _getCurrentNodeTaken(),
              onChanged: (value) => setState(() {
                _setCurrentNodeTaken(value ?? false);
                _setCurrentNodeDuration();
              }),
              side: const BorderSide(
                color: ScoutingTheme.foreground2,
                width: 2.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              activeColor: ScoutingTheme.primary,
              checkColor: ScoutingTheme.background1,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ScoutingText.subtitle('Pieces Dropoffs:'),
        ),
        SizedBox(height: 25.0 * widget.size),
        _buildSelectGrid(),
        SizedBox(height: 25.0 * widget.size),
        _buildSelectNode(),
        SizedBox(height: 25.0 * widget.size),
        ScoutingDuration(
          onChanged: (duration) {
            _duration = ActionDuration.values[duration];
            _setCurrentNodeDuration();
          },
        ),
        SizedBox(height: 25.0 * widget.size),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSelectPiece(),
            _buildCheckbox(),
          ],
        )
      ],
    );
  }
}
