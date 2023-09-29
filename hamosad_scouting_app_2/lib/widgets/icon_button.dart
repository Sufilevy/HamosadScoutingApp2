import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/theme.dart';

class ScoutingIconButton extends StatelessWidget {
  const ScoutingIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 24.0,
    this.tooltip,
    this.color,
  }) : super(key: key);

  final Color? color;
  final IconData icon;
  final double iconSize;
  final VoidCallback onPressed;
  final String? tooltip;

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
