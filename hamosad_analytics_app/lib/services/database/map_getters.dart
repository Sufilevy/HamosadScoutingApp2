import '/models/analytics.dart';

extension TypedGetters on Json {
  String? getString(String key) {
    try {
      return this[key] as String?;
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
}
