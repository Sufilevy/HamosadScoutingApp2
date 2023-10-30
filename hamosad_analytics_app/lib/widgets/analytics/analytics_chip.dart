import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/padding.dart';

class AnalyticsChip extends StatelessWidget {
  const AnalyticsChip({super.key, this.child, this.avatar, this.children, this.height = 54.0})
      : assert((child != null) ^ (children != null));

  final Widget? child, avatar;
  final List<Widget>? children;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: SizedBox(
        height: height * AnalyticsTheme.appSizeRatio,
        width: double.infinity,
        child: (child != null)
            ? Row(children: [child!.padSymmetric(horizontal: 6.0)])
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
        color: AnalyticsTheme.foreground2,
        boxShadow: [
          BoxShadow(
            offset: Offset(1.0, 1.0),
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 2.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
    );
  }
}
