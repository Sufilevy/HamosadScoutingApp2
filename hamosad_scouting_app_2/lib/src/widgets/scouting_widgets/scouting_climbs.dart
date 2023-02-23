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
      initialLabelIndex: 0,
      totalSwitches: 4,
      labels: const ['None', 'Docked', 'Docked by Other', 'Engaged'],
      fontSize: 24.0 * size,
      customWidths: [160.0 * size, 170.0 * size, 210.0 * size, 170.0 * size],
      animate: true,
      curve: Curves.easeOutQuint,
      onToggle: (index) => onChanged(index ?? 0),
    );
  }
}

class ScoutingAutoClimb extends StatelessWidget {
  const ScoutingAutoClimb({
    Key? key,
    required this.cubit,
    this.size = 1.0,
  }) : super(key: key);

  final Cubit<AutoClimb> cubit;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScoutingClimbState(
          onChanged: (state) => cubit.data.state = ClimbState.values[state],
        ),
        SizedBox(height: 30.0 * size),
        ScoutingDuration(
          onChanged: (duration) =>
              cubit.data.duration = ActionDuration.values[duration],
        ),
      ],
    );
  }
}

class ScoutingEndgameClimb extends StatelessWidget {
  const ScoutingEndgameClimb({
    Key? key,
    required this.cubit,
    this.size = 1.0,
  }) : super(key: key);

  final Cubit<EndgameClimb> cubit;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScoutingClimbState(
          onChanged: (state) => cubit.data.state = ClimbState.values[state],
        ),
        SizedBox(height: 30.0 * size),
        ScoutingDuration(
          onChanged: (duration) =>
              cubit.data.duration = ActionDuration.values[duration],
        ),
        SizedBox(height: 30.0 * size),
        ScoutingRobotIndex(
          onChanged: (index) => cubit.data.index = RobotIndex.values[index],
        ),
      ],
    );
  }
}
