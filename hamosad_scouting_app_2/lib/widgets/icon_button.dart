import 'package:flutter/material.dart';

import '/theme.dart';

class ScoutingIconButton extends StatelessWidget {
  const ScoutingIconButton({
    Key? key,
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.tooltip,
    this.color,
    this.disabledColor,
    this.splashRadius,
    this.iconSize = 24.0,
    this.isEnabled = true,
  })  : assert(icon == null || iconWidget == null),
        super(key: key);

  final Color? color, disabledColor;
  final Widget? iconWidget;
  final IconData? icon;
  final double iconSize;
  final double? splashRadius;
  final VoidCallback onPressed;
  final String? tooltip;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: isEnabled ? onPressed : null,
        iconSize: iconSize,
        padding: EdgeInsets.all(12.0 * ScoutingTheme.appSizeRatio),
        color: color ?? ScoutingTheme.primary,
        disabledColor: disabledColor ?? ScoutingTheme.foreground2,
        tooltip: tooltip,
        splashRadius: splashRadius ?? iconSize / 2.0,
        icon: iconWidget ?? Icon(icon),
      ),
    );
  }
}
