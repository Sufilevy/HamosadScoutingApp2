import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/models/analytics.dart';
import '/theme.dart';
import '/widgets/analytics/analytics_chip.dart';
import '/widgets/analytics/rates_bar.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

class FourRatesChip extends StatelessWidget {
  const FourRatesChip({super.key, required this.titles, required this.rates})
      : assert(titles.length == 4),
        assert(rates.length == 4);

  final List<String> titles;
  final List<double> rates;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      height: 80.0,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ratesAndTitles(),
              RatesBar(rates: rates).padTop(2.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ratesAndTitles() {
    return Row(
      children: titles
          .mapIndexed(
            (index, title) => Expanded(
              flex: 1,
              child: _rateAndTitle(index),
            ),
          )
          .toList(),
    );
  }

  Widget _rateAndTitle(int index) {
    return Column(
      children: [
        dataSubtitleText(titles[index]),
        dataSubtitleText(
          rates[index].toPercent(),
          color: index.isEven ? AnalyticsTheme.primary : AnalyticsTheme.secondary,
        ),
      ],
    );
  }
}
