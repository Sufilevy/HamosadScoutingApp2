import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/reports.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:provider/provider.dart';

class ScoutingApp extends StatefulWidget {
  final Color? textColor, lightTextColor;

  const ScoutingApp({
    Key? key,
    this.textColor,
    this.lightTextColor,
  }) : super(key: key);

  @override
  State<ScoutingApp> createState() => _ScoutingAppState();
}

class _ScoutingAppState extends State<ScoutingApp> {
  Widget _homePage(BuildContext context) {
    return ScoutingHomePage(
      size: size,
      title: 'Scouting App',
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    size = screenSize.height / 1200;
    return Provider<ReportDataProvider>(
      create: (_) => ReportDataProvider(),
      child: MaterialApp(
        title: 'Scouting App',
        darkTheme: _themeData(),
        color: const Color(0xFFA9CEF4),
        initialRoute: '/',
        routes: {
          '/': _homePage,
          '/game-report': (context) => gameReport(context, size),
        },
      ),
    );
  }

  Color? textColor, lightTextColor;
  late double size;

  @override
  void initState() {
    textColor = widget.textColor ?? const Color(0xFFADADB1);
    lightTextColor = widget.lightTextColor ?? const Color(0xFFFFFFFF);
    super.initState();
  }

  TextTheme _textTheme() => TextTheme(
        bodySmall: TextStyle(fontSize: 12 * size, color: lightTextColor),
        bodyMedium: TextStyle(fontSize: 16 * size, color: lightTextColor),
        bodyLarge: TextStyle(fontSize: 20 * size, color: lightTextColor),
        labelSmall: TextStyle(fontSize: 24 * size, color: textColor),
        labelMedium: TextStyle(fontSize: 30 * size, color: textColor),
        labelLarge: TextStyle(fontSize: 36 * size, color: textColor),
      );

  TooltipThemeData _tooltipTheme() => TooltipThemeData(
        decoration: const BoxDecoration(
          color: Color(0xFF1F1E24),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        textStyle: TextStyle(
          fontSize: 22 * size,
          color: textColor?.lighten(),
        ),
        padding: const EdgeInsets.all(8.0),
      );

  ThemeData _themeData() => ThemeData(
        brightness: Brightness.dark,
        textTheme: _textTheme(),
        backgroundColor: const Color(0xFF1F1E24),
        scaffoldBackgroundColor: const Color(0xFF24232A),
        toggleableActiveColor: const Color(0xFF0DBF78),
        primaryColor: const Color(0xFF3591DA),
        tooltipTheme: _tooltipTheme(),
      );
}
