import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:xcontext/material.dart';

class ScoutingReportPage extends StatelessWidget {
  final String title;
  final List<ScoutingReportTab> tabs;
  final double size;

  const ScoutingReportPage({
    Key? key,
    required this.title,
    required this.tabs,
    this.size = 1.0,
  }) : super(key: key);

  void _onCloseButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              ScoutingIconButton(
                icon: Icons.send_rounded,
                onPressed: () => databaseProvider(context).sendReport(
                  reportDataProvider(context).data,
                ),
              ),
            ],
            leading: CloseButton(
              color: context.theme.textTheme.bodySmall?.color,
              onPressed: () => _onCloseButtonPressed(context),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 24 * size,
                color: context.theme.textTheme.bodySmall?.color,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: 2.5 * size,
              indicatorColor: context.theme.primaryColor,
              labelPadding: EdgeInsets.symmetric(horizontal: 24 * size),
              labelColor: context.theme.textTheme.bodySmall?.color,
              unselectedLabelColor:
                  context.theme.textTheme.labelSmall?.color?.lighten(),
              labelStyle: context.theme.textTheme.bodyLarge,
              tabs: [
                for (final tab in tabs) Tab(text: tab.title),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 16 * size),
            child: TabBarView(
              children: tabs,
            ),
          ),
        ),
      ),
    );
  }
}
