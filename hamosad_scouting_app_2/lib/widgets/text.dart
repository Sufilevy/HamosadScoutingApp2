import 'package:flutter/material.dart';

import '/theme.dart';

class ScoutingText {
  static Text navigation(
    String data, {
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return Text(
      data,
      style: ScoutingTheme.navigationStyle.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static Text title(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      data,
      style: ScoutingTheme.titleStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static Text subtitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      data,
      style: ScoutingTheme.subtitleStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static Text body(
    String data, {
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      data,
      style: ScoutingTheme.bodyStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
