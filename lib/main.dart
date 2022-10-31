import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/pages/team_details_page.dart';
import 'components/nav_drawer.dart';
import 'constants.dart';

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
      theme: theme(),
      home: const TeamDetailsPage(),
    );
  }

  ThemeData theme() => ThemeData(
    fontFamily: 'Assistant',
    scaffoldBackgroundColor: Consts.backgroundColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Consts.backgroundColor, 
      titleTextStyle: TextStyle(
        fontFamily: 'Assistant',
        color: Consts.secondaryDisplayColor,
        fontSize: 32,
      )
    ),
  );
}
