import 'package:flutter/material.dart';

import '/theme.dart';

abstract class ScoutingText {
  static Widget navigation(
    String data, {
    double? fontSize,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        textAlign: textAlign,
        style: ScoutingTheme.navigationStyle.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  static Widget title(
    String data, {
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        textAlign: textAlign,
        style: ScoutingTheme.titleStyle.copyWith(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  static Widget subtitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    double? height,
    TextAlign textAlign = TextAlign.center,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        textAlign: textAlign,
        style: ScoutingTheme.subtitleStyle.copyWith(
          color: color,
          fontWeight: fontWeight,
          height: height,
        ),
      ),
    );
  }

  static Widget body(
    String data, {
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    TextAlign textAlign = TextAlign.center,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        textAlign: textAlign,
        style: ScoutingTheme.bodyStyle.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
        ),
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
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
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
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            data,
            textAlign: textAlign,
            style: ScoutingTheme.titleStyle.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
              height: height,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}
