typedef Json = Map<String, dynamic>;

class Cubit<T> {
  T data;
  Cubit(this.data);
}

class Stat<T> {
  final T min;
  final T max;
  final double average;

  Stat({
    required this.min,
    required this.max,
    required this.average,
  });
}
