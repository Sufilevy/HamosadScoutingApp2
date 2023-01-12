import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/constants.dart';
import 'package:hamosad_analytics_app/pages/team_details_page.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Analytics',
      theme: _theme(),
      home: const TeamDetailsPage(),
    );
  }

  ThemeData _theme() => ThemeData(
        fontFamily: Consts.defaultFontFamily,
        scaffoldBackgroundColor: Consts.backgroundColor,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Consts.backgroundColor,
          iconTheme: IconThemeData(color: Consts.secondaryDisplayColor),
          titleTextStyle: TextStyle(
            fontFamily: Consts.defaultFontFamily,
            color: Consts.secondaryDisplayColor,
            fontSize: 32,
          ),
        ),
      );
}
