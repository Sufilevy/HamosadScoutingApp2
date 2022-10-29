import 'package:flutter/material.dart';
import 'package:xcontext/material.dart';

class ScoutingAlertDialog extends StatelessWidget {
  final String content, title;
  final double size;
  final bool okButton;
  final List<Widget> actions;
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (titleIcon != null)
            Icon(
              titleIcon!,
              size: 48 * size,
              color: iconColor ?? context.theme.textTheme.labelMedium?.color,
            ),
          if (title.isNotEmpty) ...[
            const Spacer(flex: 2),
            Text(
              title,
              style: context.theme.textTheme.labelMedium?.copyWith(
                color: context.theme.textTheme.bodySmall?.color,
              ),
            ),
            const Spacer(flex: 3),
          ],
        ],
      ),
      content: Text(
        content,
        style: context.theme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        ...actions,
        if (okButton)
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                context.theme.primaryColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6 * size),
              child: Text(
                'OK',
                style: context.theme.textTheme.labelSmall?.copyWith(
                  color: context.theme.textTheme.bodySmall?.color,
                ),
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
      ],
    );
  }
}
