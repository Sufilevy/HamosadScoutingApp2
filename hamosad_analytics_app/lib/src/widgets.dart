import 'package:flutter/material.dart';

export 'widgets/analytics.dart';
export 'widgets/search_bar.dart';
export 'widgets/sidebar.dart';
export 'widgets/tab_selector.dart';

class AnalyticsFadeSwitcher extends StatelessWidget {
  const AnalyticsFadeSwitcher({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
  }
}
