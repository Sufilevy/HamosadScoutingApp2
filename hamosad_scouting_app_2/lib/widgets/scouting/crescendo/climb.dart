import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/models/cubit.dart';
import '/widgets/buttons.dart';
import '/widgets/paddings.dart';
import '/widgets/scouting/toggle/toggle_button.dart';

class ScoutingClimb extends StatefulWidget {
  const ScoutingClimb({
    super.key,
    required this.cubit,
    required this.harmonyCubit,
  });

  final Cubit<bool> cubit, harmonyCubit;

  @override
  State<ScoutingClimb> createState() => _ScoutingClimbState();
}

class _ScoutingClimbState extends State<ScoutingClimb> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScoutingToggleButton(
          cubit: widget.cubit,
          title: 'Robot climbed',
          onPressed: () => setState(() {
            if (!widget.cubit.data) {
              widget.harmonyCubit.data = false;
            }
          }),
        ),
        AnimatedSwitcher(
          duration: 200.milliseconds,
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            alignment: Alignment.topCenter,
            child: child,
          ),
          child: widget.cubit.data ? _buildHarmonyToggle() : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildHarmonyToggle() {
    return InfoButton(
      widgetName: 'הרמוניה',
      description: "האם הרובוט טיפס יחד עם עוד רובוט (או שניים) על אותה שרשרת.",
      topPadding: 24,
      child: ScoutingToggleButton(cubit: widget.harmonyCubit, title: 'Robot achieved HARMONY')
          .padTop(24),
    );
  }
}
