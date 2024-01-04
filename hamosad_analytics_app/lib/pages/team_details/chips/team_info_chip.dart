import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/theme.dart';
import '/widgets/analytics.dart';
import '/widgets/text.dart';

/// Takes 1/2 of a [ChipRow].
class TeamInfoChip extends StatelessWidget {
  const TeamInfoChip(this.info, {super.key, required this.icon});

  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      avatar: FaIcon(
        icon,
        size: 26 * AnalyticsTheme.appSizeRatio,
        color: AnalyticsTheme.primaryVariant,
      ),
      child: dataTitleText(
        info,
        textAlign: TextAlign.left,
      ),
    );
  }
}
