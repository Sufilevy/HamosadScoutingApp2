import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app_2/models/report.dart';
import 'package:hamosad_scouting_app_2/pages/home_page.dart';
import 'package:hamosad_scouting_app_2/pages/reports/game_report.dart';
import 'package:hamosad_scouting_app_2/services/app_lifecycle_observer.dart';
import 'package:hamosad_scouting_app_2/services/database.dart';
import 'package:hamosad_scouting_app_2/services/firebase_options.dart';
import 'package:hamosad_scouting_app_2/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  // Run a loading screen app until the scouting app itself finishes initializing
  runApp(const LoadingScreen());

  // Initialize Firebase and app database (create a temporary user and connect to database)
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScoutingDatabase.initialize();

  // Register an observer to finalize the app database (delete the temporary user)
  // when the app is detached, and re-initialize when the app is resumed.
  WidgetsBinding.instance.addObserver(AppLifecycleObserver(
    resumedCallback: ScoutingDatabase.initialize,
    detachedCallback: ScoutingDatabase.finalize,
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ScoutingApp());
}

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

    return Provider<GameReport>(
      create: (_) => GameReport(),
      child: MaterialApp(
        title: 'Scouting App',
        themeMode: ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => const ScoutingHomePage(),
          '/game-report': gameReportPage,
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
