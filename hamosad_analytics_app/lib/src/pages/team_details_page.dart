import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';

class TeamDetailsPage extends StatelessWidget {
  const TeamDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'TeamDetailsPage',
        style: AnalyticsTheme.dataTitleTextStyle,
      ),
    );
  }
}
