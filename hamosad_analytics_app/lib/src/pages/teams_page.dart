import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'TeamsPage',
        style: AnalyticsTheme.dataTitleTextStyle,
      ),
    );
  }
}
