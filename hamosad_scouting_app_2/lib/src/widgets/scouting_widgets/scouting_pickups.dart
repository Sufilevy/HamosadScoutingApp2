import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScoutingPickups extends StatefulWidget {
  const ScoutingPickups({
    Key? key,
    required this.cubit,
    this.onlyFloor = false,
    this.size = 1.0,
  }) : super(key: key);

  final Cubit<Pickups> cubit;
  final bool onlyFloor;
  final double size;

  @override
  State<ScoutingPickups> createState() => _ScoutingPickupsState();
}

class _ScoutingPickupsState extends State<ScoutingPickups> {
  ActionDuration? _duration;
  PickupPosition? _position;
  Piece? _piece;

  Widget _buildSelectPosition() => Column(
        children: [
          ToggleSwitch(
            cornerRadius: 10.0 * widget.size,
            inactiveBgColor: ScoutingTheme.background2,
            inactiveFgColor: ScoutingTheme.foreground2,
            activeBgColors: const [
              [ScoutingTheme.primaryVariant],
              [ScoutingTheme.primaryVariant],
            ],
            activeFgColor: ScoutingTheme.foreground1,
            totalSwitches: 2,
            labels: const ['Floor', 'Loading Zone'],
            fontSize: 24.0 * widget.size,
            customWidths: [
              150.0 * widget.size,
              220.0 * widget.size,
            ],
            initialLabelIndex: null,
            animate: true,
            curve: Curves.easeOutQuint,
            onToggle: (index) => _position = PickupPosition.values[index ?? 0],
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
                    'Pieces: ${widget.cubit.data.countPickups(PickupPosition.floor)}',
                    color: ScoutingTheme.foreground2,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 100.0 * widget.size,
                  child: ScoutingText.text(
                    'Pieces: ${widget.cubit.data.countPickups(PickupPosition.loadingZone)}',
                    color: ScoutingTheme.foreground2,
                  ),
                ),
              ],
            ),
          ),
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
        totalSwitches: 2,
        labels: const ['Cone', 'Cube'],
        initialLabelIndex: null,
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
            if (_duration == null ||
                _piece == null ||
                (_position == null && !widget.onlyFloor)) {
              showWarningSnackBar(
                context,
                widget.size,
                'Please enter all pickup info.',
              );
              _duration = null;
              _piece = null;
              _position = null;
              return;
            }

            widget.cubit.data.pickups.add(
              Pickup(
                duration: _duration!,
                piece: _piece!,
                position: widget.onlyFloor ? PickupPosition.floor : _position!,
              ),
            );

            _duration = null;
            _piece = null;
            _position = null;
          }),
          color: ScoutingTheme.background1,
          splashRadius: 45.0 * widget.size,
          iconSize: 32.0 * widget.size,
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add_rounded),
        ),
      );

  Widget _buildPieceCount() => ScoutingText.navigation(
        'Pieces:  ${widget.cubit.data.countPickups(PickupPosition.floor)}',
        fontSize: 34.0 * widget.size,
      );

  Widget _buildRemoveButton() => CircleAvatar(
        backgroundColor: ScoutingTheme.error,
        child: IconButton(
          onPressed: () => setState(() {
            if (_position == null && !widget.onlyFloor) {
              showWarningSnackBar(
                context,
                widget.size,
                'Please choose a position to remove a pickup.',
              );
              _position = null;
              return;
            }

            widget.cubit.data.pickups.removeLast();

            _position = null;
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
          child: ScoutingText.title('Pieces Pickups:'),
        ),
        SizedBox(height: 25.0 * widget.size),
        if (!widget.onlyFloor) ...[
          _buildSelectPosition(),
          SizedBox(height: 25.0 * widget.size),
        ],
        _buildSelectPiece(),
        SizedBox(height: 25.0 * widget.size),
        ScoutingDuration(
          onChanged: (duration) => _duration = ActionDuration.values[duration],
        ),
        SizedBox(height: 25.0 * widget.size),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildRemoveButton(),
            if (widget.onlyFloor) _buildPieceCount(),
            _buildAddButton(),
          ],
        ),
      ],
    );
  }
}
