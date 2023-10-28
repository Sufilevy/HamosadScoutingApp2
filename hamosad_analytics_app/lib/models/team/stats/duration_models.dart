enum ActionDuration {
  /// The action was performed in less than two seconds.
  zeroToTwo,

  /// The action was performed in two to five seconds.
  twoToFive,

  /// The action was performed more thank five seconds.
  fivePlus;

  @override
  String toString() {
    return switch (this) {
      zeroToTwo => '0-2',
      twoToFive => '2-5',
      fivePlus => '5+',
    };
  }

  static ActionDuration? fromString(String? value) {
    return switch (value) {
      '0-2' => zeroToTwo,
      '2-5' => twoToFive,
      '5+' => fivePlus,
      _ => null,
    };
  }
}

/// Rates of different durations (0-2, 2-5, 5+).
class ActionDurationsStat {
  /// The action was performed in less than two seconds.
  ///
  /// Together with [twoToFiveRate] and [fivePlusRate] represents 100% of the durations.
  double zeroToTwoRate;

  /// The action was performed in two to five seconds.
  ///
  /// Together with [zeroToTwoRate] and [fivePlusRate] represents 100% of the durations.
  double twoToFiveRate;

  /// The action was performed more thank five seconds.
  ///
  /// Together with [zeroToTwoRate] and [twoToFiveRate] represents 100% of the durations.
  double fivePlusRate;

  int _zeroToTwoCount, _twoToFiveCount, _fivePlusCount;

  /// Uses default values for all fields.
  ActionDurationsStat.defaults()
      : zeroToTwoRate = 0.0,
        twoToFiveRate = 0.0,
        fivePlusRate = 0.0,
        _zeroToTwoCount = 0,
        _twoToFiveCount = 0,
        _fivePlusCount = 0;

  void updateWithDuration(ActionDuration? duration) {
    if (duration == null) return;

    switch (duration) {
      case ActionDuration.zeroToTwo:
        _zeroToTwoCount++;
      case ActionDuration.twoToFive:
        _twoToFiveCount++;
      case ActionDuration.fivePlus:
        _fivePlusCount++;
    }

    final count = _zeroToTwoCount + _twoToFiveCount + _fivePlusCount;
    zeroToTwoRate = _zeroToTwoCount / count;
    twoToFiveRate = _twoToFiveCount / count;
    fivePlusRate = _fivePlusCount / count;
  }
}
