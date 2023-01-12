import 'package:flutter/material.dart';

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
              color:
                  iconColor ?? Theme.of(context).textTheme.labelMedium?.color,
            ),
          if (title.isNotEmpty) ...[
            const Spacer(flex: 2),
            Text(
              title,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const Spacer(flex: 3),
          ],
        ],
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        ...actions,
        if (okButton)
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6 * size),
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
      ],
    );
  }
}
