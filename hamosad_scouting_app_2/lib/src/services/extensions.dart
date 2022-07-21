import 'package:flutter/material.dart';

extension IntToDurations on int {
  Duration get ms => Duration(milliseconds: this);
  Duration get sec => Duration(seconds: this);
  Duration get min => Duration(minutes: this);
}

extension BrightenColor on Color {
  Color lighten() => Color.fromARGB(
        255,
        (red * 1.2).round(),
        (green * 1.2).round(),
        (blue * 1.2).round(),
      );
  Color darken() => Color.fromARGB(
        255,
        (red * 0.8).round(),
        (green * 0.8).round(),
        (blue * 0.8).round(),
      );
}
