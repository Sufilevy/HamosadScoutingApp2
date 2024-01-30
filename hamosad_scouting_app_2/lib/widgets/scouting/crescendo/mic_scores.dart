import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '../number/counter.dart';
import '../toggle/toggle_button.dart';
import '/models/cubit.dart';
import '/widgets/paddings.dart';

class ScoutingMicScores extends StatefulWidget {
  const ScoutingMicScores({
    super.key,
    required this.cubit,
    required this.humanPlayerCubit,
  });

  final Cubit<int> cubit;
  final Cubit<bool> humanPlayerCubit;

  @override
  State<ScoutingMicScores> createState() => _ScoutingMicScoresState();
}

class _ScoutingMicScoresState extends State<ScoutingMicScores> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScoutingToggleButton(
          cubit: widget.humanPlayerCubit,
          title: 'Human player is from this team',
          onPressed: () => setState(() {}),
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
          child: widget.humanPlayerCubit.data
              ? ScoutingCounter(cubit: widget.cubit, title: 'Mic Scores', max: 3).padTop(24)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
