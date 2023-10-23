import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';

class AnalyticsChip extends StatelessWidget {
  const AnalyticsChip({super.key, required this.label, this.avatar, this.height = 54.0});

  final Widget label;
  final Widget? avatar;
  final double height;

  @override
  Widget build(BuildContext context) {
    return padSymmetric(
      horizontal: 8.0,
      Chip(
        label: SizedBox(
          height: height * AnalyticsTheme.appSizeRatio,
          width: double.infinity,
          child: Row(
            children: [
              label.padSymmetric(horizontal: 12.0),
            ],
          ),
        ),
        avatar: avatar,
        labelPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
