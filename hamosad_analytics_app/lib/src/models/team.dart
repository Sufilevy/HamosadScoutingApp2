import 'package:dartx/dartx.dart' hide SortedList;
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:sorted_list/sorted_list.dart';

/// All of the team's stats and averages.
class Team {
  final TeamInfo info;
  final TeamAuto auto;
  final TeamTeleop teleop;
  final TeamEndgame endgame;
  final TeamSummary summary;
  final SortedList<Report> reports;

  Team.defaults({int? number, String? name})
      : info = TeamInfo(number: number, name: name),
        auto = TeamAuto.defaults(),
        teleop = TeamTeleop.defaults(),
        endgame = TeamEndgame.defaults(),
        summary = TeamSummary.defaults(),
        reports = SortedList(Report.compare);

  Team({
    int? number,
    String? name,
    String? location,
  })  : info = TeamInfo(
          number: number,
          name: name,
          location: location,
        ),
        auto = TeamAuto.defaults(),
        teleop = TeamTeleop.defaults(),
        endgame = TeamEndgame.defaults(),
        summary = TeamSummary.defaults(),
        reports = SortedList(Report.compare);

  @override
  bool operator ==(Object other) {
    if (other is Team) {
      return info.number == other.info.number;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => info.number.hashCode;

  Trendline calculateTrendlineWith(int Function(Report) getData) {
    final n = reports.length;
    final x = List.generate(reports.length, (index) => index + 1.0);
    final y = reports.map(getData).toList();
    final sumX = x.sum();
    final sumY = y.sum();

    final slopeNumerator = n * x.zip(y, (x, y) => x * y).sum() - sumX * sumY;
    final slopeDenominator = n * x.map((x) => x * x).sum() - sumX * sumX;
    final slope = slopeNumerator / slopeDenominator;

    final offsetNumerator = sumY - slope * sumX;
    final offset = offsetNumerator / n;

    return Trendline(slope, offset);
  }
}

/// All of the team's general info, stats and averages.
class TeamInfo {
  int number;
  String name, location;

  TeamInfo({
    int? number,
    String? name,
    String? location,
  })  : number = number ?? 1657,
        name = name ?? 'Hamosad',
        location = location ?? 'Israel';
}

/// All of the team's autonomous stats and averages.
class TeamAuto {
  Stat score;
  Rate leftCommunity;
  PiecesPickupsStat pickups;
  PiecesDropoffsStat dropoffs;
  Stat chargeStationPasses;
  AutoClimbStat climb;
  List<String> notes;

  /// Uses default values for all fields.
  TeamAuto.defaults()
      : score = Stat(),
        leftCommunity = Rate(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        climb = AutoClimbStat.defaults(),
        notes = [];

  void updateWithReport(ReportAuto report, String matchAndScouter) {
    score.updateWithValue(report.score);
    leftCommunity.updateWithValue(report.leftCommunity);

    pickups.updateRatesWithPickups(report.pickups);
    pickups.updateAveragesWithPieces(
      numCones: report.pickups.numCones,
      numCubes: report.pickups.numCubes,
    );

    dropoffs.updateRatesWithDropoffs(report.dropoffs);
    dropoffs.updateAveragesWithPieces(
      numCones: report.dropoffs.numCones,
      numCubes: report.dropoffs.numCubes,
    );

    chargeStationPasses.updateWithValue(report.chargeStationPasses);
    climb.updateWithClimb(report.climb);

    if (report.notes.isNotEmpty) {
      notes.add(matchAndScouter + report.notes);
    }
  }
}

/// All of the team's teleop stats and averages.
class TeamTeleop {
  Stat score;
  PiecesPickupsStat pickups;
  PiecesDropoffsStat dropoffs;
  Stat chargeStationPasses;
  List<String> notes;

  /// Uses default values for all fields.
  TeamTeleop.defaults()
      : score = Stat(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        notes = [];

  void updateWithReport(ReportTeleop report, String matchAndScouter) {
    score.updateWithValue(report.score);

    pickups.updateRatesWithPickups(report.pickups);
    pickups.updateAveragesWithPieces(
      numCones: report.pickups.numCones,
      numCubes: report.pickups.numCubes,
    );

    dropoffs.updateRatesWithDropoffs(report.dropoffs);
    dropoffs.updateAveragesWithPieces(
      numCones: report.dropoffs.numCones,
      numCubes: report.dropoffs.numCubes,
    );

    chargeStationPasses.updateWithValue(report.chargeStationPasses);

    if (report.notes.isNotEmpty) {
      notes.add(matchAndScouter + report.notes);
    }
  }
}

/// All of the team's endgame stats and averages.
class TeamEndgame {
  Stat score;
  PiecesPickupsStat pickups;
  PiecesDropoffsStat dropoffs;
  Stat chargeStationPasses;
  EndgameClimbStat climb;
  List<String> notes;

  /// Uses default values for all fields.
  TeamEndgame.defaults()
      : score = Stat(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        climb = EndgameClimbStat.defaults(),
        notes = [];

  void updateWithReport(ReportEndgame report, String matchAndScouter) {
    score.updateWithValue(report.score);

    pickups.updateRatesWithPickups(report.pickups);
    pickups.updateAveragesWithPieces(
      numCones: report.pickups.numCones,
      numCubes: report.pickups.numCubes,
    );

    dropoffs.updateRatesWithDropoffs(report.dropoffs);
    dropoffs.updateAveragesWithPieces(
      numCones: report.dropoffs.numCones,
      numCubes: report.dropoffs.numCubes,
    );

    chargeStationPasses.updateWithValue(report.chargeStationPasses);
    climb.updateWithClimb(report.climb);

    if (report.notes.isNotEmpty) {
      notes.add(matchAndScouter + report.notes);
    }
  }
}

class TeamSummary {
  Stat score;
  DefenceIndexStat defenceIndex;
  PiecesPickupsStat pickups;
  PiecesDropoffsStat dropoffs;
  Stat teleopAndEndgameDropoffs;
  Stat chargeStationPasses;
  List<String> notes, fouls, defenceNotes;

  /// Uses default values for all fields.
  TeamSummary.defaults()
      : score = Stat(),
        defenceIndex = DefenceIndexStat.defaults(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        teleopAndEndgameDropoffs = Stat(),
        chargeStationPasses = Stat(),
        notes = [],
        fouls = [],
        defenceNotes = [];

  void updateWithReport(Report report) {
    score.updateWithValue(report.score);
    defenceIndex.updateWithIndex(report.summary.defenceIndex);

    pickups.updateRatesWithPickups(
      report.teleop.pickups + report.endgame.pickups,
    );
    pickups.updateAveragesWithPieces(
      numCones: report.auto.pickups.numCones +
          report.teleop.pickups.numCones +
          report.endgame.pickups.numCones,
      numCubes: report.auto.pickups.numCubes +
          report.teleop.pickups.numCubes +
          report.endgame.pickups.numCubes,
    );

    dropoffs.updateRatesWithDropoffs(
      report.auto.dropoffs + report.teleop.dropoffs + report.endgame.dropoffs,
    );
    dropoffs.updateAveragesWithPieces(
      numCones: report.auto.dropoffs.numCones +
          report.teleop.dropoffs.numCones +
          report.endgame.dropoffs.numCones,
      numCubes: report.auto.dropoffs.numCubes +
          report.teleop.dropoffs.numCubes +
          report.endgame.dropoffs.numCubes,
    );

    teleopAndEndgameDropoffs.updateWithValue(
      report.teleop.dropoffs.length + report.endgame.dropoffs.length,
    );

    chargeStationPasses.updateWithValue(
      report.auto.chargeStationPasses +
          report.teleop.chargeStationPasses +
          report.endgame.chargeStationPasses,
    );

    if (report.summary.notes.isNotEmpty) {
      notes.add(report.matchAndScouter + report.summary.notes);
    }
    if (report.summary.fouls.isNotEmpty) {
      fouls.add(report.matchAndScouter + report.summary.fouls);
    }
    if (report.summary.defenceNotes.isNotEmpty) {
      defenceNotes.add(report.matchAndScouter + report.summary.defenceNotes);
    }
  }
}

/// Rates of different durations (0-2, 2-5, 5+).
class ActionDurationStat {
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
  ActionDurationStat.defaults()
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
        break;
      case ActionDuration.twoToFive:
        _twoToFiveCount++;
        break;
      case ActionDuration.fivePlus:
        _fivePlusCount++;
        break;
    }

    final count = _zeroToTwoCount + _twoToFiveCount + _fivePlusCount;
    zeroToTwoRate = _zeroToTwoCount / count;
    twoToFiveRate = _twoToFiveCount / count;
    fivePlusRate = _fivePlusCount / count;
  }
}

/// Rates of cones and cubes for a specific action.
class PiecesStat {
  /// The rate of this action performed with cones.
  ///
  /// Together with [cubesRate] represents 100% of the piece actions.
  double conesRate;

  /// The rate of this action performed with cubes.
  ///
  /// Together with [conesRate] represents 100% of the piece actions.
  double cubesRate;

  /// Per-game average.
  Stat cones, cubes, pieces;

  int _conesCount, _cubesCount;

  /// Uses default values for all fields.
  PiecesStat.defaults()
      : conesRate = 0.0,
        cubesRate = 0.0,
        cones = Stat(),
        cubes = Stat(),
        pieces = Stat(),
        _conesCount = 0,
        _cubesCount = 0;

  void updateRatesWithPiece(Piece piece) {
    switch (piece) {
      case Piece.cone:
        _conesCount++;
        break;
      case Piece.cube:
        _cubesCount++;
        break;
    }

    final count = _conesCount + _cubesCount;
    conesRate = _conesCount / count;
    cubesRate = _cubesCount / count;
  }

  void updateAveragesWithPieces({
    required int numCones,
    required int numCubes,
  }) {
    cones.updateWithValue(numCones);
    cubes.updateWithValue(numCubes);
    pieces.updateWithValue(numCones + numCubes);
  }
}

/// Pickups from all positions.
class PiecesPickupsStat {
  /// Per position averages and rates.
  PiecesStat loadingZone, floor;

  /// All positions averages and rates.
  PiecesStat pieces;

  /// Rates of differnet pickups locations
  double loadingZoneRate, floorRate;
  int _loadingZoneCount, _floorCount;

  /// Rates of different pickup durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  PiecesPickupsStat.defaults()
      : loadingZone = PiecesStat.defaults(),
        floor = PiecesStat.defaults(),
        pieces = PiecesStat.defaults(),
        loadingZoneRate = 0.0,
        floorRate = 0.0,
        _loadingZoneCount = 0,
        _floorCount = 0,
        duration = ActionDurationStat.defaults();

  void updateRatesWithPickup(PiecePickup pickup) {
    switch (pickup.position) {
      case PiecePickupPosition.loadingZone:
        _loadingZoneCount++;
        loadingZone.updateRatesWithPiece(pickup.piece);
        break;
      case PiecePickupPosition.floor:
        _floorCount++;
        floor.updateRatesWithPiece(pickup.piece);
        break;
    }

    pieces.updateRatesWithPiece(pickup.piece);
    duration.updateWithDuration(pickup.duration);

    final count = _loadingZoneCount + _floorCount;
    loadingZoneRate = _loadingZoneCount / count;
    floorRate = _floorCount / count;
  }

  void updateRatesWithPickups(List<PiecePickup> pickups) {
    for (final pickup in pickups) {
      updateRatesWithPickup(pickup);
    }
  }

  void updateAveragesWithPieces({
    required int numCones,
    required int numCubes,
  }) {
    pieces.updateAveragesWithPieces(numCones: numCones, numCubes: numCubes);
  }
}

/// Dropoffs made on all nodes in a grid.
class GridDropoffsStat {
  /// A list of rows of cubes and cones dropoffs rates, representing all of the nodes in this grid.
  List<PiecesStat> dropoffs;

  /// Stats for dropoffs in each row.
  List<Stat> rows;

  /// Rates of different dropoffs durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  GridDropoffsStat.defaults()
      : dropoffs = List.generate(
          3,
          (_) => PiecesStat.defaults(),
          growable: false,
        ),
        rows = List.generate(3, (_) => Stat()),
        duration = ActionDurationStat.defaults();

  void updateWithDropoff(PieceDropoff dropoff) {
    dropoffs[dropoff.row].updateRatesWithPiece(dropoff.piece);
    duration.updateWithDuration(dropoff.duration);
  }

  void updateRowsWithDropoffs(List<PieceDropoff> dropoffs) {
    var rowsCount = [0, 0, 0];
    for (final dropoff in dropoffs) {
      rowsCount[dropoff.row]++;
    }

    for (int row = 0; row < 3; row++) {
      rows[row].updateWithValue(rowsCount[row]);
    }
  }
}

/// Dropoffs made in all grids.
class PiecesDropoffsStat {
  /// Dropoffs made in all grids.
  GridDropoffsStat grids;

  /// Pieces dropoffs rates.
  PiecesStat pieces;

  /// Rates of dropoffs durations.
  ActionDurationStat duration;

  /// Game pieces stat
  Stat totalDropoffs;

  /// Uses default values for all fields.
  PiecesDropoffsStat.defaults()
      : grids = GridDropoffsStat.defaults(),
        pieces = PiecesStat.defaults(),
        duration = ActionDurationStat.defaults(),
        totalDropoffs = Stat();

  void updateRatesWithDropoff(PieceDropoff dropoff) {
    grids.updateWithDropoff(dropoff);
    pieces.updateRatesWithPiece(dropoff.piece);
    duration.updateWithDuration(dropoff.duration);
  }

  void updateRatesWithDropoffs(List<PieceDropoff> dropoffs) {
    for (final dropoff in dropoffs) {
      updateRatesWithDropoff(dropoff);
    }
    totalDropoffs.updateWithValue(dropoffs.length);
    grids.updateRowsWithDropoffs(dropoffs);
  }

  void updateAveragesWithPieces({
    required int numCones,
    required int numCubes,
  }) {
    pieces.updateAveragesWithPieces(numCones: numCones, numCubes: numCubes);
  }
}

/// Climbings states (not climbed, docked, docked by another robot or engaged).
class ClimbingStateStat {
  /// Rate of not climbed.
  ///
  /// Together with [failedRate], [dockedRate] and [engagedRate] represents 100% of all climbing states.
  double noAttemptRate;

  /// Rate of the robot being docked by another robot.
  ///
  /// Together with [noAttemptRate], [dockedRate] and [engagedRate] represents 100% of all climbing states.
  double failedRate;

  /// Rate of the robot being docked by himself.
  ///
  /// Together with [noAttemptRate], [failedRate] and [engagedRate] represents 100% of all climbing states.
  double dockedRate;

  /// Rate of the robot being engaged.
  ///
  /// Together with [noAttemptRate], [failedRate] and [dockedRate] represents 100% of all climbing states.
  double engagedRate;

  int _noAttemptCount, _failedCount, _dockedCount, _engagedCount;

  /// Uses default values for all fields.
  ClimbingStateStat.defaults()
      : noAttemptRate = 0.0,
        dockedRate = 0.0,
        failedRate = 0.0,
        engagedRate = 0.0,
        _noAttemptCount = 0,
        _dockedCount = 0,
        _failedCount = 0,
        _engagedCount = 0;

  void updateWithState(ClimbingState? value) {
    switch (value) {
      case null:
      case ClimbingState.noAttempt:
        _noAttemptCount++;
        break;
      case ClimbingState.failed:
        _failedCount++;
        break;
      case ClimbingState.docked:
        _dockedCount++;
        break;
      case ClimbingState.engaged:
        _engagedCount++;
        break;
    }

    final count = _noAttemptCount + _dockedCount + _failedCount + _engagedCount;
    noAttemptRate = _noAttemptCount / count;
    failedRate = _failedCount / count;
    dockedRate = _dockedCount / count;
    engagedRate = _engagedCount / count;
  }
}

/// Autonomous climbings.
class AutoClimbStat {
  /// Rates of climbing states.
  ClimbingStateStat states;

  /// Rates of climbing durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  AutoClimbStat.defaults()
      : states = ClimbingStateStat.defaults(),
        duration = ActionDurationStat.defaults();

  void updateWithClimb(AutoClimb? climb) {
    states.updateWithState(climb?.state);
    duration.updateWithDuration(climb?.duration);
  }
}

class DefenceIndexStat {
  /// The robot climbed first.
  ///
  /// Together with [halfRate] and [noneRate] represents 100% of the climbing indexes.
  double almostAllRate;

  /// The robot climbed second.
  ///
  /// Together with [almostAllRate] and [noneRate] represents 100% of the climbing indexes.
  double halfRate;

  /// The robot climbed third.
  ///
  /// Together with [almostAllRate] and [halfRate] represents 100% of the climbing indexes.
  double noneRate;

  int _almostAllCount, _halfCount, _noneCount;

  /// Uses default values for all fields.
  DefenceIndexStat.defaults()
      : almostAllRate = 0.0,
        halfRate = 0.0,
        noneRate = 0.0,
        _almostAllCount = 0,
        _halfCount = 0,
        _noneCount = 0;

  void updateWithIndex(DefenceRobotIndex value) {
    if (value == DefenceRobotIndex.almostAll) {
      _almostAllCount++;
    } else if (value == DefenceRobotIndex.half) {
      _halfCount++;
    } else if (value == DefenceRobotIndex.none) {
      _noneCount++;
    }

    final count = _almostAllCount + _halfCount + _noneCount;
    almostAllRate = _almostAllCount / count;
    halfRate = _halfCount / count;
    noneRate = _noneCount / count;
  }
}

/// Autonomous climbings.
class EndgameClimbStat {
  /// Rates of climbing states.
  ClimbingStateStat states;

  /// Rates of climbing durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  EndgameClimbStat.defaults()
      : states = ClimbingStateStat.defaults(),
        duration = ActionDurationStat.defaults();

  void updateWithClimb(EndgameClimb? climb) {
    if (climb == null) return;

    states.updateWithState(climb.state);
    duration.updateWithDuration(climb.duration);
  }
}

extension TeamsListToTeamNumbersList on List<Team> {
  List<String> toTeamNumbers() {
    return map((team) {
      return '${team.info.number} ${team.info.name}';
    }).toList();
  }
}
