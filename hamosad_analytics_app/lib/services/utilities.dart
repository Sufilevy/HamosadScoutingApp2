import 'package:flutter/material.dart';

T debug<T>(T value) {
  debugPrint(value.toString());
  return value;
}

Size getScreenSize(BuildContext context) => MediaQueryData.fromView(View.of(context)).size;
