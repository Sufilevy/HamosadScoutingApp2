import 'package:flutter/material.dart';

T debug<T>(T value) {
  debugPrint(value.toString());
  return value;
}

extension ScreenSize on BuildContext {
  Size get screenSize => MediaQueryData.fromView(View.of(this)).size;
}

extension ListMinusOperator<T> on List<T> {
  List<T> operator -(List<T> other) {
    removeWhere((element) => other.contains(element));

    return this;
  }
}
