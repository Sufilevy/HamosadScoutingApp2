import 'package:flutter/material.dart';

import '/models/analytics.dart';

extension TypedGetters on Json {
  Json? getJson<T>(String key) {
    try {
      return this[key] as Json?;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  List<T>? getList<T>(String key) {
    try {
      return (this[key] as List?)?.map((e) => e as T).toList();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  String? getString(String key) {
    try {
      return this[key] as String?;
    } catch (e) {
      return null;
    }
  }

  int? getInt<T>(String key) {
    try {
      return this[key] as int?;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  double? getDouble<T>(String key) {
    try {
      return this[key] as double?;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  bool? getBool<T>(String key) {
    try {
      return this[key] as bool?;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
