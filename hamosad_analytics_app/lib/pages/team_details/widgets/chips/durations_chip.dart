import 'package:flutter/material.dart';

import '/models/analytics.dart';
import '/models/team/stats/duration_models.dart';
import '/theme.dart';
import '/widgets/analytics/analytics_chip.dart';
import '/widgets/analytics/rates_bar.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

class DurationsChip extends StatelessWidget {
  const DurationsChip({super.key, required this.title, required this.durations});

  final String title;
  final ActionDurationsStat durations;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      children: [
        Expanded(flex: 1, child: dataTitleText(title)),
        const VerticalDivider(),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _durationsTitles().padBottom(2.0),
              _durationsBar().padBottom(2.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _durationsTitles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _durationTitle('0-2', durations.zeroToTwoRate).padRight(16.0),
        _durationTitle('2-5', durations.twoToFiveRate, secondaryColor: true).padRight(16.0),
        _durationTitle('5+', durations.fivePlusRate),
      ],
    );
  }

  Widget _durationTitle(String duration, double rate, {bool secondaryColor = false}) {
    return Row(
      children: <Widget>[
        dataSubtitleText(duration),
        const DotDivider().padSymmetric(horizontal: 6.0),
        dataSubtitleText(
          rate.toPercent(),
          color: secondaryColor ? AnalyticsTheme.secondary : AnalyticsTheme.primary,
        ),
      ],
    );
  }

  Widget _durationsBar() {
    return RatesBar(
      rates: [
        durations.zeroToTwoRate,
        durations.twoToFiveRate,
        durations.fivePlusRate,
      ],
    );
  }
}
