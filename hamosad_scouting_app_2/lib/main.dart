import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamosad_scouting_app_2/src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ScoutingApp());
}
