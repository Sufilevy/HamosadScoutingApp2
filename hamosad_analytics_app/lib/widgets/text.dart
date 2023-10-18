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

Widget dataTitleText(dynamic data) => Text(
      data.toString(),
      style: AnalyticsTheme.dataTitleStyle,
    );

Widget dataSubtitleText(dynamic data) => Text(
      data.toString(),
      style: AnalyticsTheme.dataSubtitleStyle,
    );

Widget dataBodyText(dynamic data) => Text(
      data.toString(),
      style: AnalyticsTheme.dataBodyStyle,
    );

Widget logoText(dynamic data) => Text(
      data.toString(),
      style: AnalyticsTheme.logoTextStyle,
    );
