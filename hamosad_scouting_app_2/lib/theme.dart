import 'package:flutter/material.dart';

class ScoutingTheme {
  static late double appSizeRatio;

  static const String appTitle = 'Scouting App';

  static const Color background1 = Color(0xFF1F1E24);
  static const Color background2 = Color(0xFF29272F);
  static const Color background3 = Color(0xFF363442);
  static const Color foreground1 = Color(0xFFFFFFFF);
  static const Color foreground2 = Color(0xFFADADB1);
  static const Color primary = Color(0xFF0DBF78);
  static const Color primaryVariant = Color(0xFF075F3C);
  static const Color secondary = Color(0xFF3F51B5);
  static const Color warning = Color(0xFFF5C400);
  static const Color error = Color(0xFFD4353A);
  static const Color blueAlliance = Color(0xFF1E88E5);
  static const Color redAlliance = Color(0xFFC62828);
  static const Color hamosad = Color(0xFF165700);

  static TextStyle get navigationStyle => TextStyle(
        fontFamily: 'Varela Round',
        fontWeight: FontWeight.normal,
        fontSize: 27.0 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get titleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w600,
        fontSize: 27.0 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get subtitleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.normal,
        fontSize: 25.0 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get bodyStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w400,
        fontSize: 23.0 * appSizeRatio,
        color: foreground1,
      );
}
