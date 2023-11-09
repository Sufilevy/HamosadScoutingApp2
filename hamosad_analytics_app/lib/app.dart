import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/pages/compare/compare_page.dart';
import '/pages/team_details/team_details_page.dart';
import '/pages/teams/teams_page.dart';
import '/theme.dart';

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
      ),
    );
  }

  final _router = GoRouter(
    initialLocation: '/compare',
    routes: <GoRoute>[
      GoRoute(
        path: '/team/:teamNumber',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: TeamDetailsPage(state.pathParameters['teamNumber']!),
        ),
      ),
      GoRoute(
        path: '/compare',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: ComparePage(
            selectedTeams: state.uri.queryParameters['teams']?.split(','),
          ),
        ),
      ),
      GoRoute(
        path: '/teams',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TeamsPage(),
        ),
      ),
    ],
  );
}

class RotatePhoneApp extends StatelessWidget {
  const RotatePhoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
