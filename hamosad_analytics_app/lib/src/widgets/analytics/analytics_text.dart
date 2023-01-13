import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';

class AnalyticsText {
  static Text navigation(String data) {
    return Text(
      data,
      style: AnalyticsTheme.navigationTextStyle,
    );
  }

  static Text dataTitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      data,
      style: AnalyticsTheme.dataTitleTextStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static Text dataSubtitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return Text(
      data,
      style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }

  static Text data(String data,
      {Color? color, TextAlign textAlign = TextAlign.center}) {
    return Text(
      data,
      style: AnalyticsTheme.dataTextStyle.copyWith(color: color),
      textAlign: textAlign,
    );
  }
}
