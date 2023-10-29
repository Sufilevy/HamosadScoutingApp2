import 'package:flutter/material.dart';

import '/models/analytics.dart';
import '/theme.dart';
import '/widgets/analytics/analytics_chip.dart';
import '/widgets/analytics/rates_bar.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

/// Takes 2/3 of a [ChipRow].
class SuccessRateChip extends StatelessWidget {
  const SuccessRateChip({
    super.key,
    required this.title,
    required this.successRate,
    required this.failRate,
  });

  final String title;
  final double successRate, failRate;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      children: <Widget>[
        Expanded(flex: 1, child: dataTitleText(title)),
        const VerticalDivider(),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _rates().padBottom(2.0),
              RatesBar(
                rates: [successRate, failRate],
                secondaryColor: AnalyticsTheme.error,
              ).padBottom(2.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _rates() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        dataSubtitleText(
          successRate.toPercent(),
          color: AnalyticsTheme.primary,
        ),
        const DotDivider().padSymmetric(horizontal: 8.0),
        dataSubtitleText(
          failRate.toPercent(),
          color: AnalyticsTheme.error,
        ),
      ],
    );
  }
}
