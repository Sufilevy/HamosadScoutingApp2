import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/pages/scouting_home_page.dart';
import 'package:hamosad_scouting_app_2/src/reports.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/theme.dart';
import 'package:provider/provider.dart';

class ScoutingApp extends StatefulWidget {
  const ScoutingApp({Key? key}) : super(key: key);

  @override
  State<ScoutingApp> createState() => _ScoutingAppState();
}

class _ScoutingAppState extends State<ScoutingApp> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQueryData.fromView(View.of(context)).size;
    ScoutingTheme.appSizeRatio = screenSize.height / 1350.0;
    return Provider<ReportDataProvider>(
      create: (_) => ReportDataProvider(),
      child: MaterialApp(
        title: 'Scouting App',
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const ScoutingHomePage(
                title: 'Scouting App',
              ),
          '/report': (context) => gameReport(context),
        },
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

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

T debug<T>(T value) {
  debugPrint(value.toString());
  return value;
}
