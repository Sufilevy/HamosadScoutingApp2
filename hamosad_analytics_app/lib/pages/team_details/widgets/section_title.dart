import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return padTop(
      10.0,
      Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 28.0 * AnalyticsTheme.appSizeRatio),
              navigationTitleText(title).padLeft(8.0),
            ],
          ),
          const SectionDivider(bottomPadding: 10.0),
        ],
      ),
    );
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key, this.bottomPadding = 15.0});

  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return pad(
      top: 5.0,
      bottom: bottomPadding,
      _addShadow(
        const Divider(
          thickness: 2.5,
          indent: 0.0,
          endIndent: 0.0,
        ),
      ),
    );
  }

  Widget _addShadow(Widget child) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [AnalyticsTheme.defaultShadow],
      ),
      child: child,
    );
  }
}
