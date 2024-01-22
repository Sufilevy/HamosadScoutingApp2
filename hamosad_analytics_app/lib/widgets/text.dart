import 'package:flutter/material.dart';

import '/theme.dart';

Widget navigationText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
  Color color = AnalyticsTheme.foreground1,
  double? fontSize,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.navigationStyle.copyWith(
        fontSize: fontSize != null ? fontSize * AnalyticsTheme.appSizeRatio : null,
        color: color,
      ),
    ),
  );
}

Widget navigationTitleText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
  Color color = AnalyticsTheme.foreground1,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.navigationTitleStyle.copyWith(
        color: color,
      ),
    ),
  );
}

Widget dataTitleText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.dataTitleStyle.copyWith(
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget dataSubtitleText(
  dynamic data, {
  TextAlign textAlign = TextAlign.center,
  Color color = AnalyticsTheme.foreground1,
  double? fontSize,
}) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      data.toString(),
      textAlign: textAlign,
      style: AnalyticsTheme.dataSubtitleStyle.copyWith(
        color: color,
        fontSize: fontSize != null ? fontSize * AnalyticsTheme.appSizeRatio : null,
      ),
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
