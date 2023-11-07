import 'package:flutter/material.dart';

import '/theme.dart';

Widget navigationText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
  double? fontSize,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.navigationStyle.copyWith(
        fontSize: fontSize != null ? fontSize * AnalyticsTheme.appSizeRatio : null,
      ),
    ),
  );
}

Widget navigationTitleText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.navigationTitleStyle,
    ),
  );
}

Widget dataTitleText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.dataTitleStyle,
    ),
  );
}

Widget dataSubtitleText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
  Color color = AnalyticsTheme.foreground1,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.dataSubtitleStyle.copyWith(color: color),
    ),
  );
}

Widget dataBodyText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.dataBodyStyle,
    ),
  );
}

Widget logoText(dynamic data) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      style: AnalyticsTheme.logoTextStyle,
    ),
  );
}
