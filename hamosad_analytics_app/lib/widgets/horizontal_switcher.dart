import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '/theme.dart';

class HorizontalSwitcher extends StatelessWidget {
  const HorizontalSwitcher({
    super.key,
    required this.data,
    required this.reverseAnimation,
    required this.child,
  });

  final dynamic data;
  final bool reverseAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: reverseAnimation,
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: AnalyticsTheme.background2,
          child: child,
        );
      },
      child: Container(
        key: ValueKey(data),
        child: child,
      ),
    );
  }
}
