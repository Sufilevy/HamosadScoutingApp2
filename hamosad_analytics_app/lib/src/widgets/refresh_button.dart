import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RefreshDataButton extends StatefulWidget {
  const RefreshDataButton({Key? key}) : super(key: key);

  @override
  State<RefreshDataButton> createState() => _RefreshDataButtonState();
}

class _RefreshDataButtonState extends State<RefreshDataButton>
    with SingleTickerProviderStateMixin {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeInQuad,
      switchOutCurve: Curves.easeOutQuad,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        alignment: Alignment.center,
        child: child,
      ),
      child: Container(
        key: ValueKey<bool>(_loading),
        alignment: Alignment.center,
        child: _loading ? _loadingIndicator : _refreshButton,
      ),
    );
  }

  Widget get _loadingIndicator => Padding(
        padding: const EdgeInsets.all(8.0),
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AnalyticsTheme.primary,
          size: 70.0,
        ),
      );

  Widget get _refreshButton => IconButton(
        iconSize: 70.0,
        icon: const Icon(
          Icons.refresh_rounded,
          color: AnalyticsTheme.primary,
          size: 70.0,
        ),
        onPressed: () async {
          setState(() {});
          _loading = true;
          await Future.wait([
            Future.delayed(const Duration(milliseconds: 1000)),
            getData(),
          ]);
          _loading = false;
          setState(() {});
        },
      );
}
