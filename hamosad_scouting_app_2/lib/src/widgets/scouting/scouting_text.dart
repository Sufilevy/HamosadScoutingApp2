import 'package:flutter/material.dart';
import 'package:xcontext/material.dart';

class ScoutingText extends StatelessWidget {
  final double size;
  final String text;
  final double fontSize;

  const ScoutingText({
    Key? key,
    required this.text,
    this.size = 1.0,
    this.fontSize = 24.0,
  }) : super(key: key);

  static ScoutingText fromJSON({
    required Map<String, dynamic> json,
  }) {
    assert(json.containsKey('text'));

    return ScoutingText(
      text: json['text'],
      size: json['size'] ?? 24.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0 * size),
      child: Text(
        text,
        style: TextStyle(
          color: context.theme.textTheme.bodyLarge?.color ?? Colors.black,
          fontFamily: context.theme.textTheme.bodyLarge?.fontFamily ?? 'Roboto',
          fontSize: fontSize * size,
        ),
      ),
    );
  }
}
