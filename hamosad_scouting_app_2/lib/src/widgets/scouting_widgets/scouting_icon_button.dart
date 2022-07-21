import 'package:flutter/material.dart';
import 'package:xcontext/material.dart';

class ScoutingIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final double iconSize;
  final String? tooltip;
  final Color? color;

  const ScoutingIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.size = 1.0,
    this.iconSize = 24,
    this.tooltip,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          iconSize: iconSize * size,
          color: color ?? context.theme.primaryColor,
          tooltip: tooltip,
          splashRadius: iconSize / 1.75 * size,
          icon: Icon(icon),
        ),
      ),
    );
  }
}
