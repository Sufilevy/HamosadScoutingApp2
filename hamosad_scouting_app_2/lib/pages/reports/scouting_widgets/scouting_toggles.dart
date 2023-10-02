import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '/models/cubit.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

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

class ScoutingToggleButton extends StatefulWidget {
  const ScoutingToggleButton({
    Key? key,
    required this.cubit,
    required this.title,
  }) : super(key: key);

  final Cubit<bool> cubit;
  final String title;

  @override
  State<ScoutingToggleButton> createState() => _ScoutingToggleButtonState();
}

class _ScoutingToggleButtonState extends State<ScoutingToggleButton> {
  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 54.0,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 1.75 * ScoutingTheme.appSizeRatio,
            child: Checkbox(
              activeColor: ScoutingTheme.primary,
              checkColor: ScoutingTheme.background1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
              side: const BorderSide(color: ScoutingTheme.foreground2, width: 2.0),
              value: widget.cubit.data,
              onChanged: (value) => setState(() {
                widget.cubit.data = value ?? !widget.cubit.data;
              }),
            ),
          ),
          Flexible(
            child: TextButton(
              onPressed: () => setState(() {
                widget.cubit.data = !widget.cubit.data;
              }),
              child: ScoutingText.subtitle(
                widget.title,
                textAlign: TextAlign.center,
              ).padSymmetric(horizontal: 2.0, vertical: 4.0),
            ),
          ),
        ],
      ),
    );
  }
}
