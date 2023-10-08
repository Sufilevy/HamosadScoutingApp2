import 'package:flutter/material.dart';

class ScoutingTheme {
  static late double appSizeRatio;

  static const appTitle = 'Scouting App';

  static const background1 = Color(0xFF1F1E24);
  static const background2 = Color(0xFF29272F);
  static const background3 = Color(0xFF363442);
  static const foreground1 = Color(0xFFFFFFFF);
  static const foreground2 = Color(0xFFADADB1);
  static const primary = Color(0xFF0DBF78);
  static const primaryVariant = Color(0xFF075F3C);
  static const secondary = Color(0xFF3F51B5);
  static const warning = Color(0xFFF5C400);
  static const error = Color(0xFFD4353A);
  static const blueAlliance = Color(0xFF1E88E5);
  static const redAlliance = Color(0xFFC62828);
  static const hamosad = Color(0xFF165700);

  static get navigationStyle => TextStyle(
        fontFamily: 'Varela Round',
        fontWeight: FontWeight.normal,
        fontSize: 27.0 * appSizeRatio,
        color: foreground1,
      );

  static get titleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w600,
        fontSize: 27.0 * appSizeRatio,
        color: foreground1,
      );

  static get subtitleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.normal,
        fontSize: 25.0 * appSizeRatio,
        color: foreground1,
      );

  static get bodyStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w400,
        fontSize: 23.0 * appSizeRatio,
        color: foreground1,
      );
}
