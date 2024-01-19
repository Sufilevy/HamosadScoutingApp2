import 'package:flutter/material.dart';

import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

/// Takes 1/3 of a [ChipRow] if [small] is true, otherwise takes 1/2.
class NumberChip extends StatelessWidget {
  const NumberChip(this.title, {super.key, this.data = 0, this.small = false});

  final String title;
  final double data;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      children: <Widget>[
        Expanded(
          flex: small ? 20 : 5,
          child: padSymmetric(
            horizontal: 8,
            small ? dataSubtitleText(title) : dataTitleText(title),
          ),
        ),
        const VerticalDivider(),
        Expanded(
          flex: small ? 11 : 2,
          child: padSymmetric(
            horizontal: 8,
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