import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/theme.dart';
import 'package:hamosad_scouting_app_2/widgets/paddings.dart';
import 'package:hamosad_scouting_app_2/widgets/text.dart';

class ScoutingDialog extends StatelessWidget {
  const ScoutingDialog({
    Key? key,
    required this.content,
    this.title = '',
    this.okButton = true,
    this.actions = const [],
    this.titleIcon,
    this.iconColor,
  }) : super(key: key);

  final List actions;
  final Color? iconColor;
  final bool okButton;
  final String content, title;
  final IconData? titleIcon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ScoutingTheme.background2,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (titleIcon != null)
            Icon(
              titleIcon!,
              size: 42.0 * ScoutingTheme.appSizeRatio,
              color: iconColor ?? ScoutingTheme.primary,
            ),
          if (title.isNotEmpty) ...[
            const Spacer(flex: 2),
            ScoutingText.title(title),
            const Spacer(flex: 3),
          ],
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(
        28.0 * ScoutingTheme.appSizeRatio,
        20.0 * ScoutingTheme.appSizeRatio,
        28.0 * ScoutingTheme.appSizeRatio,
        12.0 * ScoutingTheme.appSizeRatio,
      ),
      content: ScoutingText.text(content, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ...actions,
        if (okButton)
          TextButton(
            child: ScoutingText.subtitle(
              'OK',
              color: ScoutingTheme.primary,
              fontWeight: FontWeight.w600,
            ).padAll(8.0),
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
        children: [
          Icon(
            Icons.warning_rounded,
            color: ScoutingTheme.warning,
            size: 36.0 * ScoutingTheme.appSizeRatio,
          ),
          ScoutingText.subtitle(title).padLeft(16.0),
        ],
      ),
      backgroundColor: ScoutingTheme.background2,
      duration: 2.seconds,
    ),
  );
}
