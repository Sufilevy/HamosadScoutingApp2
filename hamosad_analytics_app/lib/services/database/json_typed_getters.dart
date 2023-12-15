import '/models/analytics.dart';

extension TypedGetters on Json {
  Json? getJson<T>(String key) {
    try {
      return this[key] as Json?;
    } catch (e) {
      return null;
    }
  }

  List<T>? getList<T>(String key) {
    try {
      return this[key] as List<T>?;
    } catch (e) {
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
      return null;
    }
  }

  double? getDouble<T>(String key) {
    try {
      return this[key] as double?;
    } catch (e) {
      return null;
    }
  }

  bool? getBool<T>(String key) {
    try {
      return this[key] as bool?;
    } catch (e) {
      return null;
    }
  }
}
