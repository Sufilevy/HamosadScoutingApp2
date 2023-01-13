import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ReportsPage',
        style: AnalyticsTheme.dataTitleTextStyle,
      ),
    );
  }
}
