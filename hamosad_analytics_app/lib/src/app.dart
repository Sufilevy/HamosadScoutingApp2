import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';
import 'package:sidebarx/sidebarx.dart';

class AnalyticsApp extends StatefulWidget {
  const AnalyticsApp({super.key});

  @override
  State<AnalyticsApp> createState() => _AnalyticsAppState();
}

class _AnalyticsAppState extends State<AnalyticsApp> {
  Widget pages(int index, {double size = 1.0}) => [
        const TeamDetailsPage(),
        const TeamsPage(),
        const ReportDetailsPage(),
        const ReportsPage(),
        const AlliancesPage()
      ][index];

  final SidebarXController _sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  @override
  void initState() {
    super.initState();
    _sidebarController.addListener((() => setState(() {})));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scouting Analytics',
      themeMode: ThemeMode.dark,
      home: Scaffold(
        backgroundColor: AnalyticsTheme.background1,
        body: Row(
          children: [
            Sidebar(
              _sidebarController,
              onRefreshData: () => setState(() {}),
              items: const [
                SidebarXItem(
                  icon: Icons.people_outline_rounded,
                  label: 'Team Details',
                ),
                SidebarXItem(
                  icon: Icons.groups_outlined,
                  label: 'Teams',
                ),
                SidebarXItem(
                  icon: Icons.assignment_outlined,
                  label: 'Report Details',
                ),
                SidebarXItem(
                  icon: Icons.source_outlined,
                  label: 'Reports',
                ),
                SidebarXItem(
                  icon: Icons.assessment_outlined,
                  label: 'Alliances',
                ),
              ],
            ),
            Expanded(
              child: pages(_sidebarController.selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}

class Sidebar extends StatefulWidget {
  const Sidebar(
    this.sidebarController, {
    Key? key,
    required this.items,
    this.onRefreshData,
  }) : super(key: key);

  final SidebarXController sidebarController;
  final List<SidebarXItem> items;
  final VoidCallback? onRefreshData;

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: widget.sidebarController,
      showToggleButton: false,
      headerBuilder: (context, extended) => _sidebarLogo,
      headerDivider: _headerDivider,
      footerBuilder: (context, extended) => _refreshDataButton,
      theme: _theme,
      extendedTheme: const SidebarXTheme(
        width: 200.0,
        decoration: BoxDecoration(color: AnalyticsTheme.background2),
      ),
      items: widget.items,
    );
  }

  Widget get _sidebarLogo => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 9.0,
              left: 9.0,
              right: 12.0,
            ),
            child: SvgPicture.asset('assets/svg/logo.svg'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 9.0),
            child: Text(
              'Hamosad\nAnalytics',
              style: AnalyticsTheme.logoTextStyle,
            ),
          ),
        ],
      );

  Widget get _headerDivider => Container(
        height: 1.5,
        width: 114,
        foregroundDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.5)),
          color: AnalyticsTheme.secondary,
        ),
        margin: const EdgeInsets.only(left: 34.0, top: 3.0, bottom: 15.0),
      );

  Widget get _refreshDataButton => const Padding(
        padding: EdgeInsets.all(40.0),
        child: RefreshDataButton(),
      );

  SidebarXTheme get _theme => SidebarXTheme(
        width: 68.0,
        decoration: const BoxDecoration(color: AnalyticsTheme.background2),
        hoverColor: AnalyticsTheme.background2,
        textStyle: AnalyticsTheme.navigationTextStyle,
        selectedTextStyle: AnalyticsTheme.navigationTextStyle,
        itemMargin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        selectedItemMargin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 10.0,
        ),
        itemTextPadding: const EdgeInsets.only(left: 7.0),
        selectedItemTextPadding: const EdgeInsets.only(left: 7.0),
        itemDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: AnalyticsTheme.background3,
          // border: const BorderDirectional(
          //   end: BorderSide(
          //     color: AnalyticsTheme.secondaryVariant,
          //     width: 5.0,
          //   ),
          // ),
        ),
        iconTheme: const IconThemeData(
          color: AnalyticsTheme.foreground1,
          size: 28.0,
        ),
        selectedIconTheme: const IconThemeData(
          color: AnalyticsTheme.foreground1,
          size: 28.0,
        ),
      );
}
