import 'package:flutter/material.dart';

typedef FutureVoidCallback = Future<void> Function();

class AppLifecycleObserver extends WidgetsBindingObserver {
  final FutureVoidCallback? detachedCallback, resumedCallback;

  AppLifecycleObserver({this.detachedCallback, this.resumedCallback});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.detached) {
      await detachedCallback?.call();
    } else if (state == AppLifecycleState.resumed) {
      await resumedCallback?.call();
    }
  }
}
