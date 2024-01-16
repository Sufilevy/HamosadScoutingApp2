import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/models/analytics.dart';
import '/theme.dart';
import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'rates_bar.dart';

/// Takes and entire [ChipRow].
class RatesChip extends StatelessWidget {
  const RatesChip({super.key, required this.titles, required this.rates})
      : assert(titles.length == rates.length);

  final List<String> titles;
  final List<double> rates;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      height: 80,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _ratesAndTitles(),
              Gap(4 * AnalyticsTheme.appSizeRatio),
              RatesBar(rates: rates).padBottom(2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ratesAndTitles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: titles.mapIndexed((index, title) => _rateAndTitle(index)).toList(),
    );
  }

  Widget _rateAndTitle(int index) {
    return Column(
      children: <Widget>[
        dataSubtitleText(titles[index]),
        dataSubtitleText(
          rates[index].toPercent(),
          color: index.isEven ? AnalyticsTheme.primary : AnalyticsTheme.secondary,
        ),
      ],
    );
  }
}
