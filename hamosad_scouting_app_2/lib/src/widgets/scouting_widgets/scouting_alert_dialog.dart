import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

class ScoutingAlertDialog extends StatelessWidget {
  final String content, title;
  final double size;
  final bool okButton;
  final List actions;
  final IconData? titleIcon;
  final Color? iconColor;

  const ScoutingAlertDialog({
    Key? key,
    required this.content,
    this.title = '',
    this.size = 1.0,
    this.okButton = true,
    this.actions = const [],
    this.titleIcon,
    this.iconColor,
  }) : super(key: key);

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
              size: 42.0 * size,
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
        28.0 * size,
        20.0 * size,
        28.0 * size,
        12.0 * size,
      ),
      content: ScoutingText.text(content, textAlign: TextAlign.center),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ...actions,
        if (okButton)
          TextButton(
            child: Padding(
              padding: EdgeInsets.all(8.0 * size),
              child: ScoutingText.subtitle(
                'OK',
                color: ScoutingTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
      ],
    );
  }
}
