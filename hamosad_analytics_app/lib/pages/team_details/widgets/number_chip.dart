import 'package:flutter/material.dart';

import '/widgets/data/analytics_chip.dart';
import '/widgets/text.dart';

/// Expanded: flex 1
class NumberChip extends StatelessWidget {
  const NumberChip(this.title, {super.key, this.data = 0.0, this.isSmall = false});

  final String title;
  final double data;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: AnalyticsChip(
        children: [
          Expanded(
            flex: 5,
            child: isSmall ? dataSubtitleText(title) : dataTitleText(title),
          ),
          const VerticalDivider(),
          Expanded(
            flex: 2,
            child: dataBodyText(_dataAsString),
          ),
        ],
      ),
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
