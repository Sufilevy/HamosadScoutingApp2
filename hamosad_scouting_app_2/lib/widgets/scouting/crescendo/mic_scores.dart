import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/models/cubit.dart';
import '/widgets/buttons.dart';
import '/widgets/paddings.dart';
import '/widgets/scouting/number/counter.dart';
import '/widgets/scouting/toggle/toggle_button.dart';

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
        InfoButton(
          widgetName: 'שחקן אנושי',
          description:
              "האם השחקן האנושי שקולע את חלקי המשחק למיקרופונים הוא מהקבוצה שעליה אתם עושים את הדוח.\n\n"
              "אם כן, תסמנו כמה חלקי משחק הוא קלע (אחרי שתסמנו את התיבה הזאת).",
          child: ScoutingToggleButton(
            cubit: widget.humanPlayerCubit,
            title: 'Human Player is from this team',
            onPressed: () => setState(() {}),
          ),
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
