import 'package:flutter/material.dart';
import 'package:xcontext/material.dart';

class ScoutingText extends StatelessWidget {
  final double size;
  final String text;
  final double fontSize;

  const ScoutingText({
    Key? key,
    required this.text,
    this.size = 1,
    this.fontSize = 24,
  }) : super(key: key);

  static ScoutingText fromJSON({
    required Map<String, dynamic> json,
  }) {
    assert(json.containsKey('text'));

    return ScoutingText(
      text: json['text'],
      fontSize: json['size'] ?? 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * size),
      child: Text(
        text,
        style: TextStyle(
          color: context.theme.textTheme.labelSmall?.color ?? Colors.black,
          fontFamily: context.theme.textTheme.bodyLarge?.fontFamily ?? 'Roboto',
          fontSize: fontSize * size,
        ),
      ),
    );
  }
}
