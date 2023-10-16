import 'package:flutter/material.dart';

import '/theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AnalyticsTheme.background1,
      child: const Center(
        child: CircularProgressIndicator(
          color: AnalyticsTheme.primary,
        ),
      ),
    );
  }
}
