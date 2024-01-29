import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/pages/home_page.dart';
import '/pages/reports/game_report_page.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingApp extends StatefulWidget {
  const ScoutingApp({super.key});

  @override
  State<ScoutingApp> createState() => _ScoutingAppState();
}

class _ScoutingAppState extends State<ScoutingApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        title: 'Scouting App',
        themeMode: ThemeMode.dark,
        routerConfig: _router,
        builder: (context, child) {
          final screenSize = MediaQueryData.fromView(View.of(context)).size;
          ScoutingTheme.appSizeRatio = screenSize.height / 1350;

          return ScoutingTheme.isDesktop ||
                  MediaQuery.of(context).orientation == Orientation.portrait
              ? child!
              : const RotatePhoneApp();
        },
      ),
    );
  }

  final _router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: '/game-report',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const GameReportPage(),
        ),
      ),
    ],
  );
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

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

class RotatePhoneApp extends StatelessWidget {
  const RotatePhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.screen_rotation_rounded, size: 70).padBottom(25),
            ScoutingText.navigation('Please rotate the device.', fontSize: 50),
          ],
        ),
      ),
    );
  }
}
