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
    this.size = 1.0,
  }) : super(key: key);

  final Cubit<Pickups> cubit;
  final double size;

  @override
  State<ScoutingPickups> createState() => _ScoutingPickupsState();
}

class _ScoutingPickupsState extends State<ScoutingPickups> {
  ActionDuration _duration = ActionDuration.twoToFive;
  PickupPosition _position = PickupPosition.floor;
  Piece _piece = Piece.cone;

  Widget _buildSelectPosition() => ToggleSwitch(
        cornerRadius: 10.0 * widget.size,
        inactiveBgColor: ScoutingTheme.background2,
        inactiveFgColor: ScoutingTheme.foreground2,
        activeBgColors: const [
          [ScoutingTheme.primaryVariant],
          [ScoutingTheme.primaryVariant],
          [ScoutingTheme.primaryVariant],
          [ScoutingTheme.primaryVariant],
        ],
        activeFgColor: ScoutingTheme.foreground1,
        initialLabelIndex: 0,
        totalSwitches: 4,
        labels: const ['Floor', 'Single', 'D. Floor', 'D. Shelf'],
        fontSize: 25.0 * widget.size,
        minWidth: 170.0 * widget.size,
        animate: true,
        curve: Curves.easeOutQuint,
        onToggle: (index) => _position = PickupPosition.values[index ?? 0],
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
        initialLabelIndex: 0,
        totalSwitches: 2,
        labels: const ['Cone', 'Cube'],
        fontSize: 30.0 * widget.size,
        minWidth: 150.0 * widget.size,
        animate: true,
        curve: Curves.easeOutQuint,
        onToggle: (index) => _piece = Piece.values[index ?? 0],
      );

  Widget _buildAddButton() => IconButton(
        onPressed: () {
          final interaction = PieceInteraction(
            duration: _duration,
            cone: _piece == Piece.cone,
            cube: _piece == Piece.cube,
          );
          switch (_position) {
            case PickupPosition.floor:
              widget.cubit.data.floor.add(interaction);
              break;
            case PickupPosition.single:
              widget.cubit.data.single.add(interaction);
              break;
            case PickupPosition.doubleFloor:
              widget.cubit.data.doubleFloor.add(interaction);
              break;
            case PickupPosition.doubleShelf:
              widget.cubit.data.doubleShelf.add(interaction);
              break;
          }
        },
        color: ScoutingTheme.primary,
        iconSize: 28.0 * widget.size,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.add_rounded),
      );

  Widget _buildRemoveButton() => IconButton(
        onPressed: () {
          switch (_position) {
            case PickupPosition.floor:
              widget.cubit.data.floor.removeLast();
              break;
            case PickupPosition.single:
              widget.cubit.data.single.removeLast();
              break;
            case PickupPosition.doubleFloor:
              widget.cubit.data.doubleFloor.removeLast();
              break;
            case PickupPosition.doubleShelf:
              widget.cubit.data.doubleShelf.removeLast();
              break;
          }
        },
        color: ScoutingTheme.error,
        iconSize: 28.0 * widget.size,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.remove_rounded),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSelectPosition(),
        SizedBox(height: 30.0 * widget.size),
        _buildSelectPiece(),
        SizedBox(height: 30.0 * widget.size),
        ScoutingDuration(
          onChanged: (duration) => _duration = ActionDuration.values[duration],
        ),
        SizedBox(height: 30.0 * widget.size),
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
