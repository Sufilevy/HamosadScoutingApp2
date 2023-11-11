import 'dart:math' as math;

class Report {
  static final _random = math.Random();

  static double randomData(double range) {
    return (_random.nextDouble() * range).floorToDouble();
  }

  const Report(this.range);

  final double range;

  double data() {
    return randomData(range);
  }
}
