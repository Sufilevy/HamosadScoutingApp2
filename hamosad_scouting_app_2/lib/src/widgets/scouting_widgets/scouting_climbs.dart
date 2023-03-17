import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScoutingClimbState extends StatelessWidget {
  const ScoutingClimbState({
    Key? key,
    required this.onChanged,
    this.size = 1.0,
  }) : super(key: key);

  final void Function(int) onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      cornerRadius: 10.0 * size,
      inactiveBgColor: ScoutingTheme.background2,
      inactiveFgColor: ScoutingTheme.foreground2,
      activeBgColors: const [
        [ScoutingTheme.primaryVariant],
        [ScoutingTheme.primaryVariant],
        [ScoutingTheme.primaryVariant],
        [ScoutingTheme.primaryVariant],
      ],
      activeFgColor: ScoutingTheme.foreground1,
      initialLabelIndex: null,
      totalSwitches: 4,
      labels: const [
        'No Attempt',
        'Failed',
        'Docked',
        'Engaged',
      ],
      fontSize: 24.0 * size,
      customWidths: [
        180.0 * size,
        110.0 * size,
        120.0 * size,
        140.0 * size,
      ],
      animate: true,
      curve: Curves.easeOutQuint,
      onToggle: (index) => onChanged(index ?? 0),
    );
  }
}

class ScoutingClimb extends StatelessWidget {
  const ScoutingClimb({
    Key? key,
    required this.cubit,
    this.includeDuration = true,
    this.size = 1.0,
  }) : super(key: key);

  final Cubit<Climb> cubit;
  final bool includeDuration;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0) * size,
            child: ScoutingText.title('Climb:'),
          ),
        ),
        ScoutingClimbState(
          size: size,
          onChanged: (state) => cubit.data.state = ClimbState.values[state],
        ),
        if (includeDuration) ...[
          SizedBox(height: 30.0 * size),
          ScoutingDuration(
            size: size,
            onChanged: (duration) =>
                cubit.data.duration = ActionDuration.values[duration],
          ),
        ],
      ],
    );
  }
}
