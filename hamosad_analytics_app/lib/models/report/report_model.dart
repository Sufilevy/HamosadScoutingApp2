import 'dart:math' as math;

class Report {
  static final _random = math.Random();

  static double randomData(double range) {
    return (_random.nextDouble() * range * 10).roundToDouble() / 10;
  }
}
