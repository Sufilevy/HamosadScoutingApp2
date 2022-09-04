import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app_2/src/app.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';

void main() async {
  // Initialize Firebase and app database (create a temporary user and connect to database)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScoutingDatabase.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ScoutingApp());

  // Finalize the app database (delete the temporary user)
  await ScoutingDatabase.finalize();
}
