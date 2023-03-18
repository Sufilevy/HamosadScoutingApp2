import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/app.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

export 'pages/alliances_page.dart';
export 'pages/compare_page.dart';
export 'pages/team_details_page.dart';
export 'pages/teams_page.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({
    Key? key,
    required this.title,
    required this.body,
    this.spacing,
    this.verticalPadding,
  }) : super(key: key);

  final Widget title, body;
  final double? spacing, verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: (verticalPadding ?? 30.0),
          ) *
          AnalyticsApp.size,
      child: Column(
        children: [
          title,
          SizedBox(height: (spacing ?? 20.0) * AnalyticsApp.size),
          _buildBody(body),
        ],
      ),
    );
  }

  Widget _buildBody(Widget child) => Expanded(
        child: Row(
          children: [
            Expanded(
              child: AnalyticsContainer(
                child: child,
              ),
            ),
          ],
        ),
      );
}
