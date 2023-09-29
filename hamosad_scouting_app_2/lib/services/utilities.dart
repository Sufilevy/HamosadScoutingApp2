import 'package:flutter/material.dart';

T debug<T>(T value) {
  debugPrint(value.toString());
  return value;
}

extension MapToStrings<T> on List<T> {
  List<String> mapToStrings() => map((e) => e.toString()).toList();
}
