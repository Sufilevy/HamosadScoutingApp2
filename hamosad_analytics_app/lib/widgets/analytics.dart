import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/scaffold.dart';
import '/widgets/text.dart';

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

extension Builders<T> on AsyncSnapshot<T> {
  Widget whenData(Widget Function(T) builder) {
    if (hasError) {
      return navigationText(error.toString());
    }

    if (!hasData) {
      return const LoadingScreen();
    }

    return builder(data as T);
  }

  Widget when({
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
    bool skipError = false,
    required Widget Function(T data) data,
    required Widget Function(Object error, StackTrace stackTrace) error,
    required Widget Function() loading,
  }) {
    if (hasError) {
      return error(this.error!, stackTrace!);
    }

    if (!hasData) {
      return loading();
    }

    return data(data as T);
  }
}
