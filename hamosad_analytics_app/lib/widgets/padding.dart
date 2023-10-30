import 'package:flutter/material.dart';

import '/theme.dart';
import 'padding.dart' as paddings;

Widget padLeft(double padding, Widget child) {
  return Padding(
    padding: EdgeInsets.only(left: padding * AnalyticsTheme.appSizeRatio),
    child: child,
  );
}

Widget padTop(double padding, Widget child) {
  return Padding(
    padding: EdgeInsets.only(top: padding * AnalyticsTheme.appSizeRatio),
    child: child,
  );
}

Widget padRight(double padding, Widget child) {
  return Padding(
    padding: EdgeInsets.only(right: padding * AnalyticsTheme.appSizeRatio),
    child: child,
  );
}

Widget padBottom(double padding, Widget child) {
  return Padding(
    padding: EdgeInsets.only(bottom: padding * AnalyticsTheme.appSizeRatio),
    child: child,
  );
}

Widget pad(
  Widget child, {
  double left = 0,
  double top = 0,
  double right = 0,
  double bottom = 0,
}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(left, top, right, bottom) * AnalyticsTheme.appSizeRatio,
    child: child,
  );
}

Widget padSymmetric(
  Widget child, {
  double horizontal = 0,
  double vertical = 0,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical) *
        AnalyticsTheme.appSizeRatio,
    child: child,
  );
}

Widget padLTRB(
  double left,
  double top,
  double right,
  double bottom,
  Widget child,
) {
  return Padding(
    padding: EdgeInsets.fromLTRB(left, top, right, bottom) * AnalyticsTheme.appSizeRatio,
    child: child,
  );
}

Widget padAll(double padding, Widget child) {
  return Padding(
    padding: EdgeInsets.all(padding * AnalyticsTheme.appSizeRatio),
    child: child,
  );
}

extension Paddings on Widget {
  Widget padLeft(double padding) => paddings.padLeft(padding, this);
  Widget padTop(double padding) => paddings.padTop(padding, this);
  Widget padRight(double padding) => paddings.padRight(padding, this);
  Widget padBottom(double padding) => paddings.padBottom(padding, this);

  Widget pad({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return paddings.pad(left: left, top: top, right: right, bottom: bottom, this);
  }

  Widget padSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return paddings.padSymmetric(horizontal: horizontal, vertical: vertical, this);
  }

  Widget padLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return paddings.padLTRB(left, top, right, bottom, this);
  }

  Widget padAll(double padding) => paddings.padAll(padding, this);
}
