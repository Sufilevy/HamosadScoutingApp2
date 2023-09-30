import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '/theme.dart';

class ScoutingSwitch extends StatelessWidget {
  const ScoutingSwitch({
    Key? key,
    required this.items,
    required this.onChanged,
    this.fontSize = 24.0,
    this.minWidth = 140.0,
    this.customWidths,
  }) : super(key: key);

  final List<double>? customWidths;
  final List<String> items;
  final double fontSize, minWidth;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      cornerRadius: 10.0 * ScoutingTheme.appSizeRatio,
      inactiveBgColor: ScoutingTheme.background2,
      inactiveFgColor: ScoutingTheme.foreground2,
      activeBgColors: List.filled(items.length, [ScoutingTheme.primaryVariant]),
      activeFgColor: ScoutingTheme.foreground1,
      initialLabelIndex: null,
      totalSwitches: items.length,
      labels: items,
      fontSize: fontSize * ScoutingTheme.appSizeRatio,
      minWidth: minWidth * ScoutingTheme.appSizeRatio,
      customWidths: customWidths,
      animate: true,
      curve: Curves.easeOutQuint,
      onToggle: (index) => onChanged(index),
    );
  }
}
