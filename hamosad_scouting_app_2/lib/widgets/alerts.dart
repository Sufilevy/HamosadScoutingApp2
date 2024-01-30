import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingDialog extends StatelessWidget {
  const ScoutingDialog({
    super.key,
    required this.content,
    this.title = '',
    this.okButton = true,
    this.actions = const [],
    this.iconSize = 54,
    this.titleWidget,
    this.iconColor,
    this.titleIcon,
  });

  final List actions;
  final Color? iconColor;
  final bool okButton;
  final String content, title;
  final IconData? titleIcon;
  final double iconSize;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ScoutingTheme.background2,
      surfaceTintColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (title.isNotEmpty || titleWidget != null) const Spacer(flex: 8),
          if (titleIcon != null)
            Icon(
              titleIcon!,
              size: iconSize * ScoutingTheme.appSizeRatio,
              color: iconColor ?? ScoutingTheme.primary,
            ),
          if (titleWidget != null) ...[
            const Spacer(flex: 1),
            titleWidget!,
            const Spacer(flex: 10),
          ],
          if (title.isNotEmpty) ...[
            const Spacer(flex: 1),
            ScoutingText.title(title),
            const Spacer(flex: 10),
          ],
        ],
      ),
      content: ScoutingText.subtitle(
        content,
        height: 2.35 * ScoutingTheme.appSizeRatio,
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.all(32 * ScoutingTheme.appSizeRatio),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ...actions,
        if (okButton)
          TextButton(
            child: ScoutingText.title(
              'OK',
              color: ScoutingTheme.primary,
              fontWeight: FontWeight.w600,
            ).padAll(8),
            onPressed: () => Navigator.pop(context),
          ),
      ],
    );
  }
}

void showWarningSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: <Widget>[
          Icon(
            Icons.warning_rounded,
            color: ScoutingTheme.warning,
            size: 36 * ScoutingTheme.appSizeRatio,
          ),
          ScoutingText.subtitle(title).padLeft(16),
        ],
      ),
      backgroundColor: ScoutingTheme.background2,
      duration: 2.seconds,
    ),
  );
}
