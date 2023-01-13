import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';

export 'pages/alliances_page.dart';
export 'pages/report_details_page.dart';
export 'pages/reports_page.dart';
export 'pages/team_details_page.dart';
export 'pages/teams_page.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key, required this.title, required this.body})
      : super(key: key);

  final Widget title, body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        children: [
          title,
          const SizedBox(height: 20.0),
          _body(body),
        ],
      ),
    );
  }

  Widget _body(Widget child) => Expanded(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AnalyticsTheme.background2,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: child,
              ),
            ),
          ],
        ),
      );
}
