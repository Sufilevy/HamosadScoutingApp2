import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/theme.dart';

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

  static Text text(
    String data, {
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    TextAlign textAlign = TextAlign.center,
  }) {
    return Text(
      data,
      style: ScoutingTheme.textStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
