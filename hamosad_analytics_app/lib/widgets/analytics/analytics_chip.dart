import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';

class AnalyticsChip extends StatelessWidget {
  const AnalyticsChip({super.key, this.child, this.avatar, this.children, this.height = 54})
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
            ? Row(children: <Widget>[child!.padSymmetric(horizontal: 6)])
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
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AnalyticsTheme.foreground2,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Color.fromRGBO(0, 0, 0, 0.3),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
