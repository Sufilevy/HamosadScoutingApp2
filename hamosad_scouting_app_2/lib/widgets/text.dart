import 'package:flutter/material.dart';

import '/theme.dart';

abstract class ScoutingText {
  static Text navigation(
    String data, {
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      data,
      textAlign: textAlign,
      style: ScoutingTheme.navigationStyle.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static Text title(
    String data, {
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      data,
      textAlign: textAlign,
      style: ScoutingTheme.titleStyle.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  static Text subtitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    double? height,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      data,
      textAlign: textAlign,
      style: ScoutingTheme.subtitleStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  static Text body(
    String data, {
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      data,
      textAlign: textAlign,
      style: ScoutingTheme.bodyStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  static Widget titleStroke(
    String data, {
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double strokeWidth = 2,
    Color strokeColor = Colors.black,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Stack(
      children: [
        Text(
          data,
          textAlign: textAlign,
          style: ScoutingTheme.titleStyle.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          data,
          textAlign: textAlign,
          style: ScoutingTheme.titleStyle.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            color: color,
          ),
        ),
      ],
    );
  }
}
