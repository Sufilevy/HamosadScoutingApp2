import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/padding.dart';

class RatesBar extends StatelessWidget {
  const RatesBar({
    super.key,
    required this.rates,
    this.secondaryColor = AnalyticsTheme.secondary,
  });

  final List<double> rates;
  final Color secondaryColor;

  bool get hasOnlyOneRate => rates.any((rate) => rate == 1);

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 12,
      Row(
        children: rates.mapIndexed(
          (index, rate) {
            if (rate == 0) {
              return const SizedBox.shrink();
            }

            return Expanded(
              flex: _rateToFlex(rate),
              child: _bar(index),
            );
          },
        ).toList(),
      ),
    );
  }

  int _rateToFlex(double rate) => (rate * 10).toInt();

  Widget _bar(int index) {
    return SizedBox(
      height: 8 * AnalyticsTheme.appSizeRatio,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 3,
              decoration: BoxDecoration(
                color: index.isEven ? AnalyticsTheme.primary : secondaryColor,
                borderRadius: _barBorderRadius(index),
              ),
            ),
          ),
          if (index != rates.length - 1 && !hasOnlyOneRate) _separator(),
        ],
      ),
    );
  }

  BorderRadius _barBorderRadius(int index) {
    const rounding = Radius.circular(2);
    var borderRadius = BorderRadius.circular(0);

    if (index == 0 || rates[index - 1] == 0) {
      borderRadius = borderRadius.copyWith(topLeft: rounding, bottomLeft: rounding);
    }

    if (index == rates.length - 1 || rates[index + 1] == 0) {
      borderRadius = borderRadius.copyWith(topRight: rounding, bottomRight: rounding);
    }

    return borderRadius;
  }

  Widget _separator() {
    return Container(
      height: 8 * AnalyticsTheme.appSizeRatio,
      width: 2,
      decoration: const BoxDecoration(
        color: AnalyticsTheme.foreground2,
      ),
    );
  }
}
