import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/app.dart';
import '/services/app_lifecycle_observer.dart';
import '/services/database.dart';
import '/services/firebase_options.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.windows) {
    runApp(const ScoutingApp());
    return;
  }

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
