import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/padding.dart';

class AnalyticsChip extends StatelessWidget {
  const AnalyticsChip({super.key, this.label, this.avatar, this.children, this.height = 54.0})
      : assert((label != null) ^ (children != null));

  final Widget? label, avatar;
  final List<Widget>? children;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: SizedBox(
        height: height * AnalyticsTheme.appSizeRatio,
        width: double.infinity,
        child: (label != null)
            ? Row(children: [label!.padSymmetric(horizontal: 6.0)])
            : Row(children: children!),
      ),
      avatar: avatar,
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
    );
  }
}

class DotDivider extends StatelessWidget {
  const DotDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4.0,
      height: 4.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AnalyticsTheme.background3,
        boxShadow: [
          AnalyticsTheme.defaultShadow,
        ],
      ),
    );
  }
}
