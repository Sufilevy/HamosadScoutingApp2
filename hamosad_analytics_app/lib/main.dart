import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform;
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;
import 'package:flutter/widgets.dart';

import '/app.dart';
import '/services/database/firebase_options.dart';
import '/widgets/scaffold.dart';

void main() async {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    runApp(AnalyticsApp());
    return;
  }

  runApp(const LoadingScreen());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(AnalyticsApp());
}
