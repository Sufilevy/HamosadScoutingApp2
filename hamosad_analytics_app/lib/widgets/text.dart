import 'package:flutter/material.dart';

import '/theme.dart';

Widget navigationText(String data) => Text(
      data,
      style: AnalyticsTheme.navigationStyle,
    );

Widget dataTitleText(String data) => Text(
      data,
      style: AnalyticsTheme.dataTitleStyle,
    );

Widget dataSubtitleText(String data) => Text(
      data,
      style: AnalyticsTheme.dataSubtitleStyle,
    );

Widget dataBodyText(String data) => Text(
      data,
      style: AnalyticsTheme.dataBodyStyle,
    );

Widget logoText(String data) => Text(
      data,
      style: AnalyticsTheme.logoTextStyle,
    );
