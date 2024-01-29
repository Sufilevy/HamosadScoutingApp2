import 'package:flutter/material.dart';

import '/theme.dart';

class ScoutingIconButton extends StatelessWidget {
  const ScoutingIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.tooltip,
    this.color,
    this.disabledColor,
    this.iconSize = 24,
    this.isEnabled = true,
  }) : assert(icon == null || iconWidget == null);

  final Color? color, disabledColor;
  final Widget? iconWidget;
  final IconData? icon;
  final double iconSize;
  final VoidCallback onPressed;
  final String? tooltip;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: isEnabled ? onPressed : null,
        iconSize: iconSize,
        padding: EdgeInsets.all(12 * ScoutingTheme.appSizeRatio),
        color: color ?? ScoutingTheme.primary,
        disabledColor: disabledColor ?? ScoutingTheme.foreground2,
        tooltip: tooltip,
        icon: iconWidget ?? Icon(icon),
      ),
    );
  }
}
