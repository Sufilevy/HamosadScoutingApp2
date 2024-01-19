import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '/pages/compare/compare_page.dart';
import '/pages/team_details/team_details_page.dart';
import '/theme.dart';
import '/widgets/text.dart';

class AnalyticsApp extends StatelessWidget {
  AnalyticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsTheme.setAppSizeRatio(context);

    return ProviderScope(
      child: MaterialApp.router(
        title: AnalyticsTheme.appTitle,
        themeMode: ThemeMode.dark,
        darkTheme: AnalyticsTheme.darkTheme,
        routerConfig: _router,
        builder: (context, child) {
          AnalyticsTheme.setAppSizeRatio(context);
          return AnalyticsTheme.isDesktop ||
                  MediaQuery.of(context).orientation == Orientation.portrait
              ? child!
              : const RotatePhoneApp();
        },
      ),
    );
  }

  final _router = GoRouter(
    initialLocation: '/compare',
    routes: <GoRoute>[
      GoRoute(
        path: '/team',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: TeamDetailsPage(),
        ),
      ),
      GoRoute(
        path: '/team/:teamNumber',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: TeamDetailsPage(teamNumber: state.pathParameters['teamNumber']!),
        ),
      ),
      GoRoute(
        path: '/compare',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ComparePage(),
        ),
      ),
    ],
  );
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
            const Icon(Icons.screen_rotation_rounded, size: 70),
            const Gap(25),
            navigationText('Please rotate the device.', fontSize: 50),
          ],
        ),
      ),
    );
  }
}
