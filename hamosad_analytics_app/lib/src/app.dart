import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:sidebarx/sidebarx.dart';

class AnalyticsApp extends ConsumerStatefulWidget {
  AnalyticsApp({super.key});

  final SidebarXController sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);
  static double size = 1.0;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnalyticsAppState();
}

class _AnalyticsAppState extends ConsumerState<AnalyticsApp> {
  bool _finishedDialog = false;

  Future<void> initializeDatabase(WidgetRef ref) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await ref.read(analyticsDatabaseProvider).updateFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    AnalyticsApp.size = math.min(
      screenSize.width / 1400.0,
      screenSize.height / 750.0,
    );

    return FutureBuilder(
      future: initializeDatabase(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: AnalyticsTheme.background1,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: AnalyticsTheme.primary,
            ),
          );
        }
        return Portal(
          child: MaterialApp(
            title: 'Scouting Analytics',
            themeMode: ThemeMode.dark,
            home: Scaffold(
              backgroundColor: AnalyticsTheme.background1,
              body: _finishedDialog
                  ? Row(
                      children: [
                        Sidebar(
                          widget.sidebarController,
                          items: const [
                            SidebarXItem(
                              icon: Icons.people_outline_rounded,
                              label: 'Team Details',
                            ),
                            SidebarXItem(
                              icon: Icons.groups_outlined,
                              label: 'Teams',
                            ),
                            // SidebarXItem(
                            //   icon: Icons.assignment_outlined,
                            //   label: 'Report Details',
                            // ),
                            SidebarXItem(
                              icon: Icons.assessment_outlined,
                              label: 'Alliances',
                            ),
                          ],
                        ),
                        Expanded(
                            child: AnalyticsAppBody(
                          sidebarController: widget.sidebarController,
                        )),
                      ],
                    )
                  : _buildSelectDistricts(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectDistricts() {
    final db = ref.read(analyticsDatabaseProvider);
    return MultiSelectDialog(
      backgroundColor: AnalyticsTheme.background2,
      checkColor: AnalyticsTheme.foreground1,
      selectedColor: AnalyticsTheme.primaryVariant,
      unselectedColor: AnalyticsTheme.foreground2,
      itemsTextStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
        color: AnalyticsTheme.foreground2,
      ),
      selectedItemsTextStyle: AnalyticsTheme.dataTitleTextStyle.copyWith(
        color: AnalyticsTheme.foreground2,
      ),
      title: Text(
        'Select districts:',
        textAlign: TextAlign.center,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          fontSize: 26.0,
          color: AnalyticsTheme.foreground2,
        ),
      ),
      cancelText: Text(
        'CANCEL',
        style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
          color: AnalyticsTheme.foreground2,
          fontWeight: FontWeight.w500,
        ),
      ),
      confirmText: Text(
        'CONFIRM',
        style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
          color: AnalyticsTheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
      height: 600.0 * AnalyticsApp.size,
      width: 500.0 * AnalyticsApp.size,
      onConfirm: (selectedDistricts) => setState(() {
        db.setSelectedDistrict(
          selectedDistricts.mapNotNull((e) => e.toString()).toList(),
        );
        _finishedDialog = true;
      }),
      items: db.districts.map((data) => MultiSelectItem(data, data)).toList(),
      initialValue: db.selectedDistricts,
    );
  }
}

class AnalyticsAppBody extends ConsumerStatefulWidget {
  const AnalyticsAppBody({
    super.key,
    required this.sidebarController,
  });

  final SidebarXController sidebarController;

  @override
  ConsumerState<AnalyticsAppBody> createState() => _AnalyticsAppBodyState();
}

class _AnalyticsAppBodyState extends ConsumerState<AnalyticsAppBody> {
  final List<Widget> _pages = [
    const TeamDetailsPage(),
    const TeamsPage(),
    // const ReportDetailsPage(),
    const AlliancesPage()
  ];

  @override
  void initState() {
    super.initState();
    widget.sidebarController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AnalyticsFadeSwitcher(
      child: Container(
        key: ValueKey<int>(widget.sidebarController.selectedIndex),
        child: _pages[widget.sidebarController.selectedIndex],
      ),
    );
  }
}

T debug<T>(T object) {
  debugPrint(object.toString());
  return object;
}
