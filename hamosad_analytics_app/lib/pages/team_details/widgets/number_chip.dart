import 'package:flutter/material.dart';

import '/widgets/analytics/analytics_chip.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

class NumberChip extends StatelessWidget {
  const NumberChip(this.title, {super.key, this.data = 0.0, this.small = false});

  final String title;
  final double data;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      children: [
        Expanded(
          flex: small ? 20 : 5,
          child: padSymmetric(
            horizontal: 8.0,
            small ? dataSubtitleText(title) : dataTitleText(title),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: small ? 11 : 2,
          child: padSymmetric(
            horizontal: 8.0,
            dataBodyText(_dataAsString),
          ),
        ),
      ],
    );
  }

  String get _dataAsString {
    var string = data.toStringAsPrecision(3);

    if (data.floorToDouble() != data && string.endsWith('0') || string.endsWith('00')) {
      return string.substring(0, string.length - 1);
    }

    return string;
  }
}
