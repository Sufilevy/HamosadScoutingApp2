import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '/theme.dart';

class ScoutingSwitch extends StatelessWidget {
  const ScoutingSwitch({
    super.key,
    required this.items,
    required this.onChanged,
    this.fontSize = 24.0,
    this.minWidth = 140.0,
    this.customWidths,
  });

  final List<double>? customWidths;
  final List<String> items;
  final double fontSize, minWidth;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      customWidths: customWidths?.map((w) => w * ScoutingTheme.appSizeRatio).toList(),
      minWidth: minWidth * ScoutingTheme.appSizeRatio,
      cornerRadius: 10.0 * ScoutingTheme.appSizeRatio,
      fontSize: fontSize * ScoutingTheme.appSizeRatio,
      activeBgColors: List.filled(items.length, [ScoutingTheme.primaryVariant]),
      activeFgColor: ScoutingTheme.foreground1,
      inactiveBgColor: ScoutingTheme.background2,
      inactiveFgColor: ScoutingTheme.foreground2,
      animate: true,
      curve: Curves.easeOutQuint,
      totalSwitches: items.length,
      labels: items,
      initialLabelIndex: null,
      onToggle: (index) => onChanged(index),
    );
  }
}
