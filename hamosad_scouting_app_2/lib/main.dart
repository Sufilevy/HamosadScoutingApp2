import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app_2/src/app.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and app database (create a temporary user and connect to database)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScoutingDatabase.initialize();

  // Register an observer to finalize the app database (delete the temporary user)
  // when the app is detached, and re-initialize when the app is resumed.
  WidgetsBinding.instance.addObserver(AppLifecycleObserver(
    detachedCallback: ScoutingDatabase.finalize,
    resumedCallback: ScoutingDatabase.initialize,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ScoutingApp());
}
