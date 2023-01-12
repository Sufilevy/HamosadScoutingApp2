import 'package:flutter/material.dart';

class Constants {}

class AnalyticsTheme {
  static const Color background1 = Color(0xFF1F1E24);
  static const Color background2 = Color(0xFF29272F);
  static const Color background3 = Color(0xFF333238);
  static const Color foreground1 = Color(0xFFFFFFFF);
  static const Color foreground2 = Color(0xFFADADB1);
  static const Color primary = Color(0xFF3591DA);
  static const Color primaryVariant = Color(0xFF004985);
  static const Color secondary = Color(0xFF0DBF78);
  static const Color secondaryVariant = Color(0xFF096942);
  static const Color error = Color(0xFFD4353A);
  static const Color warning = Color(0xFFF5C400);
  static const Color hamosad = Color(0xFF165700);

  static const TextStyle logoTextStyle = TextStyle(
    fontFamily: 'Fira Code',
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: secondary,
  );
  static const TextStyle navigationTextStyle = TextStyle(
    fontFamily: 'Varela Round',
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    color: foreground1,
  );
  static const TextStyle dataTitleTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
    color: foreground1,
  );
  static const TextStyle dataSubtitleTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    color: foreground1,
  );
  static const TextStyle dataTextStyle = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: secondary,
  );
}
