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
    this.isAuto = false,
  }) : super(key: key);

  final double size;
  final Cubit<Dropoffs> cubit;
  final bool isAuto;

  @override
  State<ScoutingDropoffs> createState() => _ScoutingDropoffsState();
}

class _ScoutingDropoffsState extends State<ScoutingDropoffs> {
  int? _row;
  Piece? _piece;
  ActionDuration? _duration;

  void _addDropoff() {
    if (_row == null ||
        _piece == null ||
        (_duration == null && !widget.isAuto)) {
      return;
    }

    widget.cubit.data.dropoffs.add(
      Dropoff(
          piece: _piece!,
          duration: widget.isAuto ? null : _duration!,
          row: _row!),
    );

    _row = null;
    _piece = null;
    _duration = null;
  }

  Widget _buildSelectRow() => Column(
        children: [
          ToggleSwitch(
            cornerRadius: 10.0 * widget.size,
            inactiveBgColor: ScoutingTheme.background2,
            inactiveFgColor: ScoutingTheme.foreground2,
            activeBgColors: const [
              [ScoutingTheme.primaryVariant],
              [ScoutingTheme.primaryVariant],
              [ScoutingTheme.primaryVariant],
            ],
            activeFgColor: ScoutingTheme.foreground1,
            initialLabelIndex: _row,
            totalSwitches: 3,
            labels: const ['Low', 'Mid', 'High'],
            fontSize: 30.0 * widget.size,
            minWidth: 150.0 * widget.size,
            animate: true,
            curve: Curves.easeOutQuint,
            onToggle: (index) => _row = index,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0 * widget.size),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100.0 * widget.size,
                  child: ScoutingText.text(
                    'Pieces: ${widget.cubit.data.countDropoffs(0)}',
                    color: ScoutingTheme.foreground2,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100.0 * widget.size,
                  child: ScoutingText.text(
                    'Pieces: ${widget.cubit.data.countDropoffs(1)}',
                    color: ScoutingTheme.foreground2,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100.0 * widget.size,
                  child: ScoutingText.text(
                    'Pieces: ${widget.cubit.data.countDropoffs(2)}',
                    color: ScoutingTheme.foreground2,
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Widget _buildSelectPiece() => ToggleSwitch(
        cornerRadius: 10.0 * widget.size,
        inactiveBgColor: ScoutingTheme.background2,
        inactiveFgColor: ScoutingTheme.foreground2,
        activeBgColors: const [
          [ScoutingTheme.cones],
          [ScoutingTheme.cubes],
        ],
        activeFgColor: ScoutingTheme.foreground1,
        initialLabelIndex:
            _piece != null ? (_piece! == Piece.cone ? 0 : 1) : null,
        totalSwitches: 2,
        labels: const ['Cone', 'Cube'],
        fontSize: 30.0 * widget.size,
        minWidth: 150.0 * widget.size,
        animate: true,
        curve: Curves.easeOutQuint,
        onToggle: (index) => _piece = Piece.values[index ?? 0],
      );

  Widget _buildAddButton() => CircleAvatar(
        backgroundColor: ScoutingTheme.primary,
        child: IconButton(
          onPressed: () => setState(() {
            _addDropoff();
          }),
          color: ScoutingTheme.background1,
          splashRadius: 45.0 * widget.size,
          iconSize: 32.0 * widget.size,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add_rounded),
        ),
      );

  Widget _buildRemoveButton() => CircleAvatar(
        backgroundColor: ScoutingTheme.error,
        child: IconButton(
          onPressed: () => setState(() {
            widget.cubit.data.dropoffs.removeLast();
          }),
          color: ScoutingTheme.background1,
          splashRadius: 45.0 * widget.size,
          iconSize: 32.0 * widget.size,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.remove_rounded),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ScoutingText.title('Pieces Dropoffs:'),
        ),
        SizedBox(height: 25.0 * widget.size),
        _buildSelectRow(),
        SizedBox(height: 25.0 * widget.size),
        if (!widget.isAuto)
          ScoutingDuration(
            onChanged: (duration) =>
                _duration = ActionDuration.values[duration],
          ),
        SizedBox(height: 25.0 * widget.size),
        _buildSelectPiece(),
        SizedBox(height: 25.0 * widget.size),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildRemoveButton(),
            _buildAddButton(),
          ],
        ),
      ],
    );
  }
}
