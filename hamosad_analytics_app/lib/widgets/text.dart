import 'package:flutter/material.dart';

import '/theme.dart';

Widget navigationText(dynamic data) => Text(
      data.toString(),
      style: AnalyticsTheme.navigationStyle,
    );

Widget navigationTitleText(dynamic data) => Text(
      data.toString(),
      style: AnalyticsTheme.navigationTitleStyle,
    );

Widget dataTitleText(dynamic data, {TextAlign textAlign = TextAlign.center}) => Text(
      data.toString(),
      style: AnalyticsTheme.dataTitleStyle,
      textAlign: textAlign,
    );

Widget dataSubtitleText(dynamic data, {TextAlign textAlign = TextAlign.center}) => Text(
      data.toString(),
      style: AnalyticsTheme.dataSubtitleStyle,
      textAlign: textAlign,
    );

Widget dataBodyText(dynamic data, {TextAlign textAlign = TextAlign.center}) => Text(
      data.toString(),
      style: AnalyticsTheme.dataBodyStyle,
      textAlign: textAlign,
    );

Widget logoText(dynamic data) => Text(
      data.toString(),
      style: AnalyticsTheme.logoTextStyle,
    );
