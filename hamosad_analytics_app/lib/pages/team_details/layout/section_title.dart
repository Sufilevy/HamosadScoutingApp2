import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/theme.dart';
import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return padTop(
      10,
      Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 20 * AnalyticsTheme.appSizeRatio),
              Gap(16 * AnalyticsTheme.appSizeRatio),
              navigationTitleText(title),
            ],
          ),
          const SectionDivider(bottomPadding: 10),
        ],
      ),
    );
  }
}
