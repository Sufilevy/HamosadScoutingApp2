import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/paddings.dart';

class ScoutingIconButton extends StatelessWidget {
  const ScoutingIconButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.iconWidget,
    this.tooltip,
    this.color,
    this.disabledColor,
    this.constraints,
    this.iconSize = 24,
    this.isEnabled = true,
  }) : assert(icon == null || iconWidget == null);

  final Color? color, disabledColor;
  final Widget? iconWidget;
  final IconData? icon;
  final double iconSize;
  final VoidCallback onPressed;
  final String? tooltip;
  final BoxConstraints? constraints;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isEnabled ? onPressed : null,
      iconSize: iconSize * ScoutingTheme.appSizeRatio,
      color: color ?? ScoutingTheme.primary,
      disabledColor: disabledColor ?? ScoutingTheme.foreground2,
      tooltip: tooltip,
      constraints: constraints,
      icon: iconWidget ?? Icon(icon, size: iconSize * ScoutingTheme.appSizeRatio),
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.widgetName,
    required this.description,
    required this.child,
    this.buttonPadding,
    this.buttonAlignment = Alignment.centerRight,
  });

  final String widgetName, description;
  final Widget child;
  final Alignment buttonAlignment;
  final EdgeInsets? buttonPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Align(
          alignment: buttonAlignment,
          child: Padding(
            padding: buttonPadding ?? const EdgeInsets.only(right: 64) * ScoutingTheme.appSizeRatio,
            child: _buildInfoButton(context),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoButton(BuildContext context) {
    return ScoutingIconButton(
      color: ScoutingTheme.foreground2,
      icon: Icons.help_outline_rounded,
      iconSize: 64 * ScoutingTheme.appSizeRatio,
      tooltip: 'Widget Description',
      onPressed: () => showDialog(
        context: context,
        builder: _buildAboutDialog,
      ),
    );
  }

  Widget _buildAboutDialog(BuildContext context) {
    return ScoutingDialog(
      content: description,
      titleIcon: Icons.help_outline_rounded,
      iconColor: ScoutingTheme.foreground2,
      iconSize: 40,
      titleWidget: Text(
        widgetName,
        style: ScoutingTheme.titleStyle.copyWith(
          color: Colors.transparent,
          decorationColor: ScoutingTheme.primary,
          decoration: TextDecoration.underline,
          decorationThickness: 5,
          shadows: [
            const Shadow(
              color: ScoutingTheme.foreground1,
              offset: Offset(0, -8),
            ),
          ],
        ),
      ).pad(top: 20, left: 8),
    );
  }
}
