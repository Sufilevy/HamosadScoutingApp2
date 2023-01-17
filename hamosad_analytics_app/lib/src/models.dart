export 'models/report.dart';
export 'models/team.dart';

typedef Json = Map<String, dynamic>;

class Cubit<T> {
  T data;
  Cubit(this.data);
}

class Stat<T extends num> {
  final T min, max;
  final double average;

  Stat({
    required this.min,
    required this.max,
    required this.average,
  });

  static Stat<int> zero() => Stat(min: 0, max: 0, average: 0.0);
}
