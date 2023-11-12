import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/pages/home_page.dart';
import '/pages/reports/game_report_page.dart';
import '/theme.dart';

class ScoutingApp extends StatefulWidget {
  const ScoutingApp({super.key});

  @override
  State<ScoutingApp> createState() => _ScoutingAppState();
}

class _ScoutingAppState extends State<ScoutingApp> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQueryData.fromView(View.of(context)).size;
    ScoutingTheme.appSizeRatio = screenSize.height / 1350;

    return ProviderScope(
      child: MaterialApp(
        title: 'Scouting App',
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (_) => const ScoutingHomePage(),
          '/game-report': (_) => const GameReportPage(),
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScoutingTheme.background1,
      child: const Center(
        child: CircularProgressIndicator(
          color: ScoutingTheme.primary,
        ),
      ),
    );
  }
}
