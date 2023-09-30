import 'package:flutter/material.dart';

import '/theme.dart';
import 'paddings.dart' as paddings;

Widget padLeft(double padding, Widget child) => Padding(
      padding: EdgeInsets.only(left: padding * ScoutingTheme.appSizeRatio),
      child: child,
    );
Widget padTop(double padding, Widget child) => Padding(
      padding: EdgeInsets.only(top: padding * ScoutingTheme.appSizeRatio),
      child: child,
    );
Widget padRight(double padding, Widget child) => Padding(
      padding: EdgeInsets.only(right: padding * ScoutingTheme.appSizeRatio),
      child: child,
    );
Widget padBottom(double padding, Widget child) => Padding(
      padding: EdgeInsets.only(bottom: padding * ScoutingTheme.appSizeRatio),
      child: child,
    );

Widget pad(
  Widget child, {
  double left = 0.0,
  double top = 0.0,
  double right = 0.0,
  double bottom = 0.0,
}) =>
    Padding(
      padding: EdgeInsets.fromLTRB(
        left * ScoutingTheme.appSizeRatio,
        top * ScoutingTheme.appSizeRatio,
        right * ScoutingTheme.appSizeRatio,
        bottom * ScoutingTheme.appSizeRatio,
      ),
      child: child,
    );

Widget padSymmetric(
  Widget child, {
  double horizontal = 0.0,
  double vertical = 0.0,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal * ScoutingTheme.appSizeRatio,
        vertical: vertical * ScoutingTheme.appSizeRatio,
      ),
      child: child,
    );

Widget padLTRB(
  double left,
  double top,
  double right,
  double bottom,
  Widget child,
) =>
    Padding(
      padding: EdgeInsets.fromLTRB(
        left * ScoutingTheme.appSizeRatio,
        top * ScoutingTheme.appSizeRatio,
        right * ScoutingTheme.appSizeRatio,
        bottom * ScoutingTheme.appSizeRatio,
      ),
      child: child,
    );

Widget padAll(double padding, Widget child) => Padding(
      padding: EdgeInsets.all(padding * ScoutingTheme.appSizeRatio),
      child: child,
    );

extension Paddings on Widget {
  Widget padLeft(double padding) => paddings.padLeft(padding, this);
  Widget padTop(double padding) => paddings.padTop(padding, this);
  Widget padRight(double padding) => paddings.padRight(padding, this);
  Widget padBottom(double padding) => paddings.padBottom(padding, this);

  Widget pad({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      paddings.pad(left: left, top: top, right: right, bottom: bottom, this);

  Widget padSymmetric({
    double horizontal = 0.0,
    double vertical = 0.0,
  }) =>
      paddings.padSymmetric(horizontal: horizontal, vertical: vertical, this);

  Widget padLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) =>
      paddings.padLTRB(left, top, right, bottom, this);

  Widget padAll(double padding) => paddings.padAll(padding, this);
}
