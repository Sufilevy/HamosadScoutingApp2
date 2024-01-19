import 'package:flutter/material.dart';

T debug<T>(T value) {
  debugPrint(value.toString());
  return value;
}

extension ScreenSize on BuildContext {
  Size get screenSize => MediaQueryData.fromView(View.of(this)).size;
}

extension IsNullOrEmpty on Map? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension PushString on String {
  String push(String other) => this + other;
}
