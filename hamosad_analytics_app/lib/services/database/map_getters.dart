import '/models/analytics.dart';

extension TypedGetters on Json {
  String? getString(String key) {
    try {
      return this[key] as String?;
    } catch (e) {
      return null;
    }
  }
}
