import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/theme.dart';

class ScoutingIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;
  final String? tooltip;
  final Color? color;

  const ScoutingIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 24.0,
    this.tooltip,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: onPressed,
        iconSize: iconSize * ScoutingTheme.appSizeRatio,
        color: color ?? ScoutingTheme.primary,
        tooltip: tooltip,
        splashRadius: iconSize / 1.75 * ScoutingTheme.appSizeRatio,
        icon: Icon(icon),
      ),
    );
  }
}
