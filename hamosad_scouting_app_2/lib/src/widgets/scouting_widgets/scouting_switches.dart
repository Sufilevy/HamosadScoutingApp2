import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/widgets/scouting_widgets/scouting_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScoutingDuration extends StatelessWidget {
  const ScoutingDuration({
    Key? key,
    required this.onChanged,
    this.size = 1.0,
  }) : super(key: key);

  final double size;
  final void Function(int) onChanged;

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
      ],
      activeFgColor: ScoutingTheme.foreground1,
      initialLabelIndex: null,
      totalSwitches: 3,
      labels: const ['0-2', '2-5', '5+'],
      fontSize: 24.0 * size,
      minWidth: 140.0 * size,
      animate: true,
      curve: Curves.easeOutQuint,
      onToggle: (index) => onChanged(index ?? 1),
    );
  }
}

class ScoutingStartPosition extends StatelessWidget {
  const ScoutingStartPosition({
    Key? key,
    required this.onChanged,
    this.size = 1.0,
  }) : super(key: key);

  final double size;
  final void Function(int) onChanged;

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
        ToggleSwitch(
          cornerRadius: 10.0 * size,
          inactiveBgColor: ScoutingTheme.background2,
          inactiveFgColor: ScoutingTheme.foreground2,
          activeBgColors: const [
            [ScoutingTheme.primaryVariant],
            [ScoutingTheme.primaryVariant],
            [ScoutingTheme.primaryVariant],
          ],
          activeFgColor: ScoutingTheme.foreground1,
          initialLabelIndex: null,
          totalSwitches: 3,
          labels: const ['Arena Wall', 'Middle', 'Loading Zone'],
          customWidths: [
            180.0 * size,
            150.0 * size,
            210.0 * size,
          ],
          fontSize: 26.0 * size,
          animate: true,
          curve: Curves.easeOutQuint,
          onToggle: (index) => onChanged(index ?? 1),
        ),
      ],
    );
  }
}

class ScoutingRobotIndex extends StatelessWidget {
  const ScoutingRobotIndex({
    Key? key,
    required this.onChanged,
    this.title,
    this.size = 1.0,
  }) : super(key: key);

  final double size;
  final void Function(int) onChanged;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) ...[
          ScoutingText.subtitle(title!),
          SizedBox(
            height: 20.0 * size,
          ),
        ],
        ToggleSwitch(
          cornerRadius: 10.0 * size,
          inactiveBgColor: ScoutingTheme.background2,
          inactiveFgColor: ScoutingTheme.foreground2,
          activeBgColors: const [
            [ScoutingTheme.primaryVariant],
            [ScoutingTheme.primaryVariant],
            [ScoutingTheme.primaryVariant],
          ],
          activeFgColor: ScoutingTheme.foreground1,
          initialLabelIndex: null,
          totalSwitches: 3,
          labels: const ['First', 'Second', 'Third'],
          fontSize: 26.0 * size,
          minWidth: 160.0 * size,
          animate: true,
          curve: Curves.easeOutQuint,
          onToggle: (index) => onChanged(index ?? 1),
        ),
      ],
    );
  }
}

class ScoutingDefenceFocus extends StatelessWidget {
  const ScoutingDefenceFocus({
    Key? key,
    required this.onChanged,
    this.size = 1.0,
  }) : super(key: key);

  final double size;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScoutingText.subtitle(
          'How much did the robot focus on defence?',
        ),
        SizedBox(
          height: 20.0 * size,
        ),
        ToggleSwitch(
          cornerRadius: 10.0 * size,
          inactiveBgColor: ScoutingTheme.background2,
          inactiveFgColor: ScoutingTheme.foreground2,
          activeBgColors: const [
            [ScoutingTheme.primaryVariant],
            [ScoutingTheme.primaryVariant],
            [ScoutingTheme.primaryVariant],
          ],
          activeFgColor: ScoutingTheme.foreground1,
          initialLabelIndex: null,
          totalSwitches: 3,
          customWidths: [
            200.0 * size,
            150.0 * size,
            150.0 * size,
          ],
          labels: const ['Almost only', 'Half', 'None'],
          fontSize: 26.0 * size,
          animate: true,
          curve: Curves.easeOutQuint,
          onToggle: (index) => onChanged(index ?? 1),
        ),
      ],
    );
  }
}
