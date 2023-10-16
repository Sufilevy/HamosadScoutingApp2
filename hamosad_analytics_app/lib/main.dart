import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '/app.dart';
import '/services/database/firebase_options.dart';
import '/widgets/loading_screen.dart';

void main() async {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    runApp(AnalyticsApp());
    return;
  }

  // Run a loading screen app until the scouting app itself finishes initializing
  runApp(const LoadingScreen());

  // Initialize Firebase and app database (create a temporary user and connect to database)
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(AnalyticsApp());
}
