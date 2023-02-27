import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/reports.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:provider/provider.dart';

class ScoutingApp extends StatefulWidget {
  const ScoutingApp({Key? key}) : super(key: key);

  @override
  State<ScoutingApp> createState() => _ScoutingAppState();
}

class _ScoutingAppState extends State<ScoutingApp> {
  late double size;

  Widget _buildHomePage(BuildContext context) {
    return ScoutingHomePage(
      size: size,
      title: 'Scouting App',
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    size = screenSize.height / 1200.0;
    ScoutingTheme.size = size;
    return Provider<ReportDataProvider>(
      create: (_) => ReportDataProvider(),
      child: MaterialApp(
        title: 'Scouting App',
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': _buildHomePage,
          '/game-report': (context) => gameReport(context, size),
          '/pit-report': (context) => pitReport(context, size),
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

// TODO: Remove at production
T debug<T>(T value) {
  debugPrint(value.toString());
  return value;
}
