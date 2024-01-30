import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/models/cubit.dart';
import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingCenterLinePickups extends StatefulWidget {
  const ScoutingCenterLinePickups({
    super.key,
    required this.cubit,
  });

  final Cubit<List<int>> cubit;

  @override
  State<ScoutingCenterLinePickups> createState() => _ScoutingCenterLinePickupsState();
}

class _ScoutingCenterLinePickupsState extends State<ScoutingCenterLinePickups> {
  final List<bool> _isSelected = List.filled(5, false);

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 56,
      Container(
        decoration: BoxDecoration(
          color: ScoutingTheme.fieldCarpet,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _allianceWall(context, ScoutingTheme.redAlliance, 'Red'),
            _buildToggles(),
            _allianceWall(context, ScoutingTheme.blueAlliance, 'Blue'),
          ],
        ),
      ),
    );
  }

  Widget _allianceWall(BuildContext context, Color color, String name) {
    return padSymmetric(
      horizontal: 32,
      vertical: 16,
      Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ScoutingTheme.background3,
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        alignment: Alignment.center,
        width: (context.screenSize.width / 8).coerceAtMost(100),
        height: 350 * ScoutingTheme.appSizeRatio,
        child: RotatedBox(
          quarterTurns: 1,
          child: ScoutingText.titleStroke('$name Alliance'),
        ),
      ),
    );
  }

  Widget _buildToggles() {
    return ToggleButtons(
      isSelected: _isSelected,
      onPressed: (index) => setState(() {
        final noteIndex = 5 - index;
        if (widget.cubit.data.contains(noteIndex)) {
          widget.cubit.data.remove(noteIndex);
        } else {
          widget.cubit.data.add(noteIndex);
          widget.cubit.data.sort();
        }
      }),
      direction: Axis.vertical,
      borderColor: Colors.transparent,
      children: List.generate(
        5,
        (index) {
          final isSelected = widget.cubit.data.contains(5 - index);
          return Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: ScoutingTheme.note,
                size: 64 * ScoutingTheme.appSizeRatio,
              ),
              if (!isSelected) ScoutingText.subtitle('${5 - index}'),
            ],
          );
        },
      ),
    );
  }
}
