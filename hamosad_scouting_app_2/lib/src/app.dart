import 'package:flutter/material.dart';
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
    size = screenSize.height / 1200;
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
