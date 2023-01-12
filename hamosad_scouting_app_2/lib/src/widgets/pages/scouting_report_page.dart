import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

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

  void _onCloseButtonPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ScoutingAlertDialog(
        content:
            'Closing the report will delete all of the information entered.',
        title: 'Warning!',
        titleIcon: Icons.dangerous_rounded,
        iconColor: const Color(0xFFC62828),
        okButton: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: ScoutingText(
                  text: 'Delete',
                  color: Color(0xFFC62828),
                  bold: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: ScoutingText(text: 'Cancel'),
              ),
            ),
          ),
        ],
        size: size,
      ),
    );
  }

  void _onSendButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ScoutingAlertDialog(
        content:
            'Sending the report will upload it to the database and bring you back to the home screen.',
        title: 'Send Report?',
        titleIcon: Icons.send_rounded,
        iconColor: const Color(0xFF1E88E5),
        okButton: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: ScoutingText(text: 'Cancel'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                ScoutingDatabase.sendReport(
                  reportDataProvider(context).data,
                );
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: ScoutingText(
                  text: 'Send',
                  color: Color(0xFF1E88E5),
                  bold: true,
                ),
              ),
            ),
          ),
        ],
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              ScoutingIconButton(
                icon: Icons.send_rounded,
                onPressed: () => _onSendButtonPressed(context),
              ),
            ],
            leading: CloseButton(
              color: Theme.of(context).textTheme.bodySmall?.color,
              onPressed: () => _onCloseButtonPressed(context),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 24 * size,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: 2.5 * size,
              indicatorColor: Theme.of(context).primaryColor,
              labelPadding: EdgeInsets.symmetric(horizontal: 24 * size),
              labelColor: Theme.of(context).textTheme.bodySmall?.color,
              unselectedLabelColor:
                  Theme.of(context).textTheme.labelSmall?.color?.lighten(),
              labelStyle: Theme.of(context).textTheme.bodyLarge,
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
