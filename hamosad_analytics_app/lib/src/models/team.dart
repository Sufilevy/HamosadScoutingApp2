import 'package:hamosad_analytics_app/src/models.dart';

/// All of the team's stats and averages.
class Team {
  final TeamInfo info;
  final TeamAuto auto;
  final TeamTeleop teleop;
  final TeamEndgame endgame;
  final TeamSummary summary;

  Team({
    required this.info,
    required this.auto,
    required this.teleop,
    required this.endgame,
    required this.summary,
  });

  Team.defaults({int number = 1657, String name = 'Hamosad'})
      : info = TeamInfo.defaults(number: number, name: name),
        auto = TeamAuto.defaults(),
        teleop = TeamTeleop.defaults(),
        endgame = TeamEndgame.defaults(),
        summary = TeamSummary.defaults();

  Team.only({
    TeamInfo? info,
    TeamAuto? auto,
    TeamTeleop? teleop,
    TeamEndgame? endgame,
    TeamSummary? summary,
  })  : info = info ?? TeamInfo.defaults(number: 1657, name: 'Hamosad'),
        auto = auto ?? TeamAuto.defaults(),
        teleop = teleop ?? TeamTeleop.defaults(),
        endgame = endgame ?? TeamEndgame.defaults(),
        summary = summary ?? TeamSummary.defaults();

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
}

/// All of the team's general info, stats and averages.
class TeamInfo {
  int number;
  String name, location;
  int rank;

  TeamInfo({
    required this.number,
    required this.name,
    required this.location,
    required this.rank,
  });

  TeamInfo.defaults({required this.number, required this.name})
      : location = '',
        rank = 1;

  TeamInfo.only({
    required this.number,
    required this.name,
    String? location,
    int? rank,
    int? won,
    int? lost,
    Stat? score,
    RobotIndexStat? defenceIndex,
  })  : location = location ?? '',
        rank = rank ?? 1;
}

/// All of the team's autonomous stats and averages.
class TeamAuto {
  Stat score;
  StartPositionStat startPosition;
  Rate leftCommunity;
  PiecesPickupsStat pickups;
  PiecesDropoffsStat dropoffs;
  Stat chargeStationPasses;
  AutoClimbStat climb;
  List<String> notes;

  TeamAuto({
    required this.score,
    required this.startPosition,
    required this.leftCommunity,
    required this.pickups,
    required this.dropoffs,
    required this.chargeStationPasses,
    required this.climb,
    required this.notes,
  });

  /// Uses default values for all fields.
  TeamAuto.defaults()
      : score = Stat(),
        startPosition = StartPositionStat.defaults(),
        leftCommunity = Rate(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        climb = AutoClimbStat.defaults(),
        notes = [];

  TeamAuto.only({
    Stat? score,
    StartPositionStat? startPosition,
    Rate? leftCommunity,
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    Stat? chargeStationPasses,
    AutoClimbStat? climb,
    List<String>? notes,
  })  : score = score ?? Stat(),
        startPosition = startPosition ?? StartPositionStat.defaults(),
        leftCommunity = leftCommunity ?? Rate(),
        pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        climb = climb ?? AutoClimbStat.defaults(),
        notes = notes ?? [];

  void updateWithReport(ReportAuto report) {
    score.updateWithValue(report.score);
    startPosition.updateWithPosition(report.startPosition);
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
    notes.add(report.notes);
  }
}

/// All of the team's teleop stats and averages.
class TeamTeleop {
  Stat score;
  PiecesPickupsStat pickups;
  PiecesDropoffsStat dropoffs;
  Stat chargeStationPasses;
  List<String> notes;

  TeamTeleop({
    required this.score,
    required this.pickups,
    required this.dropoffs,
    required this.chargeStationPasses,
    required this.notes,
  });

  /// Uses default values for all fields.
  TeamTeleop.defaults()
      : score = Stat(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        notes = [];

  TeamTeleop.only({
    Stat? score,
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    Stat? chargeStationPasses,
    List<String>? notes,
  })  : score = score ?? Stat(),
        pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        chargeStationPasses = chargeStationPasses ?? Stat(),
        notes = notes ?? [];

  void updateWithReport(ReportTeleop report) {
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
    notes.add(report.notes);
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

  TeamEndgame({
    required this.score,
    required this.pickups,
    required this.dropoffs,
    required this.chargeStationPasses,
    required this.climb,
    required this.notes,
  });

  /// Uses default values for all fields.
  TeamEndgame.defaults()
      : score = Stat(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        climb = EndgameClimbStat.defaults(),
        notes = [];

  TeamEndgame.only({
    Stat? score,
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    Stat? chargeStationPasses,
    EndgameClimbStat? climb,
    List<String>? notes,
  })  : score = score ?? Stat(),
        pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        chargeStationPasses = chargeStationPasses ?? Stat(),
        climb = climb ?? EndgameClimbStat.defaults(),
        notes = notes ?? [];

  void updateWithReport(ReportEndgame report) {
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
    notes.add(report.notes);
  }
}

class TeamSummary {
  Stat score;
  int won, lost;
  RobotIndexStat defenceIndex;
  PiecesPickupsStat pickups;
  PiecesDropoffsStat dropoffs;
  Stat chargeStationPasses;
  List<String> notes, fouls;

  TeamSummary({
    required this.score,
    required this.won,
    required this.lost,
    required this.defenceIndex,
    required this.pickups,
    required this.dropoffs,
    required this.chargeStationPasses,
    required this.notes,
    required this.fouls,
  });

  /// Uses default values for all fields.
  TeamSummary.defaults()
      : score = Stat(),
        won = 0,
        lost = 0,
        defenceIndex = RobotIndexStat.defaults(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        chargeStationPasses = Stat(),
        notes = [],
        fouls = [];

  TeamSummary.only({
    Stat? score,
    int? won,
    int? lost,
    RobotIndexStat? defenceIndex,
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    Stat? chargeStationPasses,
    List<String>? notes,
    List<String>? fouls,
  })  : score = score ?? Stat(),
        won = won ?? 0,
        lost = lost ?? 0,
        defenceIndex = defenceIndex ?? RobotIndexStat.defaults(),
        pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        chargeStationPasses = chargeStationPasses ?? Stat(),
        notes = notes ?? [],
        fouls = fouls ?? [];

  double get winRate {
    if (won == 0) {
      return 0;
    } else if (lost == 0) {
      return 1;
    }

    return won / lost;
  }

  void updateWithReport(Report report) {
    if (report.summary.won) {
      won += 1;
    } else {
      lost += 1;
    }

    score.updateWithValue(report.score);
    defenceIndex.updateWithIndex(report.summary.defenceIndex);

    pickups.updateRatesWithPickups(report.auto.pickups);
    pickups.updateRatesWithPickups(report.teleop.pickups);
    pickups.updateRatesWithPickups(report.endgame.pickups);

    pickups.updateAveragesWithPieces(
      numCones: report.auto.pickups.numCones,
      numCubes: report.auto.pickups.numCubes,
    );
    pickups.updateAveragesWithPieces(
      numCones: report.teleop.pickups.numCones,
      numCubes: report.teleop.pickups.numCubes,
    );
    pickups.updateAveragesWithPieces(
      numCones: report.endgame.pickups.numCones,
      numCubes: report.endgame.pickups.numCubes,
    );

    dropoffs.updateRatesWithDropoffs(report.auto.dropoffs);
    dropoffs.updateRatesWithDropoffs(report.teleop.dropoffs);
    dropoffs.updateRatesWithDropoffs(report.endgame.dropoffs);
    dropoffs.updateAveragesWithPieces(
      numCones: report.auto.dropoffs.numCones,
      numCubes: report.auto.dropoffs.numCubes,
    );
    dropoffs.updateAveragesWithPieces(
      numCones: report.teleop.dropoffs.numCones,
      numCubes: report.teleop.dropoffs.numCubes,
    );
    dropoffs.updateAveragesWithPieces(
      numCones: report.endgame.dropoffs.numCones,
      numCubes: report.endgame.dropoffs.numCubes,
    );

    chargeStationPasses.updateWithValue(report.auto.chargeStationPasses);
    chargeStationPasses.updateWithValue(report.teleop.chargeStationPasses);
    chargeStationPasses.updateWithValue(report.endgame.chargeStationPasses);

    notes.add(report.summary.notes);
    fouls.add(report.summary.fouls);
  }
}

/// Rates of the robot's starting positions.
class StartPositionStat {
  StartPositionStat({
    required this.arenaWallRate,
    required this.middleRate,
    required this.loadingZoneRate,
  })  : _arenaWallCount = 0,
        _middleCount = 0,
        _loadingZoneCount = 0;

  /// The robot is the closest to the arena wall out of the 3 robots in his alliance.
  ///
  /// Together with [middleRate] and [loadingZoneRate] represents 100% of the starting positions.
  double arenaWallRate;

  /// The robot is in the middle out of the 3 robots in his alliance.
  ///
  /// Together with [arenaWallRate] and [loadingZoneRate] represents 100% of the starting positions.
  double middleRate;

  /// The robot is the closest to the loading zone out of the 3 robots in his alliance.
  ///
  /// Together with [arenaWallRate] and [middleRate] represents 100% of the starting positions.
  double loadingZoneRate;

  int _arenaWallCount, _middleCount, _loadingZoneCount;

  /// Uses default values for all fields.
  StartPositionStat.defaults()
      : arenaWallRate = 0.0,
        middleRate = 0.0,
        loadingZoneRate = 0.0,
        _arenaWallCount = 0,
        _middleCount = 0,
        _loadingZoneCount = 0;

  void updateWithPosition(StartPosition position) {
    switch (position) {
      case StartPosition.arenaWall:
        _arenaWallCount++;
        break;
      case StartPosition.middle:
        _middleCount++;
        break;
      case StartPosition.loadingZone:
        _loadingZoneCount++;
        break;
    }

    final count = _arenaWallCount + _middleCount + _loadingZoneCount;
    arenaWallRate = _arenaWallCount / count;
    middleRate = _middleCount / count;
    loadingZoneRate = _loadingZoneCount / count;
  }
}

/// Rates of different durations (0-2, 2-5, 5+).
class ActionDurationStat {
  ActionDurationStat({
    required this.zeroToTwoRate,
    required this.twoToFiveRate,
    required this.fivePlusRate,
  })  : _zeroToTwoCount = 0,
        _twoToFiveCount = 0,
        _fivePlusCount = 0;

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

  void updateWithDuration(ActionDuration duration) {
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
  PiecesStat({
    required this.conesRate,
    required this.cubesRate,
    required this.cones,
    required this.cubes,
  })  : _conesCount = 0,
        _cubesCount = 0;

  /// The rate of this action performed with cones.
  ///
  /// Together with [cubesRate] represents 100% of the piece actions.
  double conesRate;

  /// The rate of this action performed with cubes.
  ///
  /// Together with [conesRate] represents 100% of the piece actions.
  double cubesRate;

  /// Per-game average.
  Stat cones, cubes;

  int _conesCount, _cubesCount;

  /// Uses default values for all fields.
  PiecesStat.defaults()
      : conesRate = 0.0,
        cubesRate = 0.0,
        cones = Stat(),
        cubes = Stat(),
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
  }
}

/// Pickups from all positions.
class PiecesPickupsStat {
  PiecesPickupsStat({
    required this.doubleShelf,
    required this.doubleFloor,
    required this.single,
    required this.floor,
    required this.pieces,
    required this.duration,
  });

  /// Per position averages and rates.
  PiecesStat doubleShelf, doubleFloor, single, floor;

  /// All positions averages and rates.
  PiecesStat pieces;

  /// Rates of different pickup durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  PiecesPickupsStat.defaults()
      : doubleShelf = PiecesStat.defaults(),
        doubleFloor = PiecesStat.defaults(),
        single = PiecesStat.defaults(),
        floor = PiecesStat.defaults(),
        pieces = PiecesStat.defaults(),
        duration = ActionDurationStat.defaults();

  void updateRatesWithPickup(PiecePickup pickup) {
    switch (pickup.position) {
      case PiecePickupPosition.doubleShelf:
        doubleShelf.updateRatesWithPiece(pickup.piece);
        break;
      case PiecePickupPosition.doubleFloor:
        doubleFloor.updateRatesWithPiece(pickup.piece);
        break;
      case PiecePickupPosition.single:
        single.updateRatesWithPiece(pickup.piece);
        break;
      case PiecePickupPosition.floor:
        floor.updateRatesWithPiece(pickup.piece);
        break;
    }

    pieces.updateRatesWithPiece(pickup.piece);
    duration.updateWithDuration(pickup.duration);
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
  GridDropoffsStat({
    required this.dropoffs,
    required this.gridRate,
    required this.duration,
  });

  /// A 3x3 grid of cubes and cones dropoffs rates, representing all of the nodes in this grid.
  List<List<PiecesStat>> dropoffs;

  /// Rate of game pieces dropoffs in this grid.
  ///
  /// Together with the [gridRate] of the two other grids represents 100% of all pieces dropoffs.
  double gridRate;

  /// Rates of different dropoffs durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  GridDropoffsStat.defaults()
      : dropoffs = List.filled(
          3,
          List.filled(
            3,
            PiecesStat.defaults(),
            growable: false,
          ),
          growable: false,
        ),
        gridRate = 0.0,
        duration = ActionDurationStat.defaults();

  void updateWithDropoff(PieceDropoff dropoff) {
    dropoffs[dropoff.row][dropoff.column].updateRatesWithPiece(dropoff.piece);
    duration.updateWithDuration(dropoff.duration);
  }

  void updateGridRate(double newGridRate) {
    gridRate = newGridRate;
  }
}

/// Dropoffs made in all grids.
class PiecesDropoffsStat {
  PiecesDropoffsStat({
    required this.arenaWallGrid,
    required this.coopGrid,
    required this.loadingZoneGrid,
    required this.pieces,
    required this.duration,
  })  : _arenaWallGridCount = 0,
        _coopGridCount = 0,
        _loadingZoneGridCount = 0;

  /// Dropoffs made in the grid closest to the arena wall.
  GridDropoffsStat arenaWallGrid;
  int _arenaWallGridCount;

  /// Dropoffs made in the middle grid (aka the coopertition / co-op grid).
  GridDropoffsStat coopGrid;
  int _coopGridCount;

  /// Dropoffs made in the grid closest to the loading zone.
  GridDropoffsStat loadingZoneGrid;
  int _loadingZoneGridCount;

  /// Pieces dropoffs rates.
  PiecesStat pieces;

  /// Rates of dropoffs durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  PiecesDropoffsStat.defaults()
      : arenaWallGrid = GridDropoffsStat.defaults(),
        coopGrid = GridDropoffsStat.defaults(),
        loadingZoneGrid = GridDropoffsStat.defaults(),
        pieces = PiecesStat.defaults(),
        duration = ActionDurationStat.defaults(),
        _arenaWallGridCount = 0,
        _coopGridCount = 0,
        _loadingZoneGridCount = 0;

  void updateRatesWithDropoff(PieceDropoff dropoff) {
    switch (dropoff.grid) {
      case Grid.arenaWall:
        arenaWallGrid.updateWithDropoff(dropoff);
        _arenaWallGridCount++;
        break;
      case Grid.coop:
        coopGrid.updateWithDropoff(dropoff);
        _coopGridCount++;
        break;
      case Grid.loadingZone:
        loadingZoneGrid.updateWithDropoff(dropoff);
        _loadingZoneGridCount++;
        break;
    }

    int count = _arenaWallGridCount + _coopGridCount + _loadingZoneGridCount;
    arenaWallGrid.updateGridRate(_arenaWallGridCount / count);
    coopGrid.updateGridRate(_coopGridCount / count);
    loadingZoneGrid.updateGridRate(_loadingZoneGridCount / count);

    pieces.updateRatesWithPiece(dropoff.piece);
    duration.updateWithDuration(dropoff.duration);
  }

  void updateRatesWithDropoffs(List<PieceDropoff> dropoffs) {
    for (final dropoff in dropoffs) {
      updateRatesWithDropoff(dropoff);
    }
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
  ClimbingStateStat({
    required this.noneRate,
    required this.dockedRate,
    required this.dockedByOtherRate,
    required this.engagedRate,
  })  : _noneCount = 0,
        _dockedCount = 0,
        _dockedByOtherCount = 0,
        _engagedCount = 0;

  /// Rate of not climbed.
  ///
  /// Together with [dockedRate], [dockedByOtherRate] and [engagedRate] represents 100% of all climbing states.
  double noneRate;

  /// Rate of the robot being docked by himself.
  ///
  /// Together with [noneRate], [dockedByOtherRate] and [engagedRate] represents 100% of all climbing states.
  double dockedRate;

  /// Rate of the robot being docked by another robot.
  ///
  /// Together with [noneRate], [dockedRate] and [engagedRate] represents 100% of all climbing states.
  double dockedByOtherRate;

  /// Rate of the robot being engaged.
  ///
  /// Together with [noneRate], [dockedRate] and [dockedByOtherRate] represents 100% of all climbing states.
  double engagedRate;

  int _noneCount, _dockedCount, _dockedByOtherCount, _engagedCount;

  /// Uses default values for all fields.
  ClimbingStateStat.defaults()
      : noneRate = 0.0,
        dockedRate = 0.0,
        dockedByOtherRate = 0.0,
        engagedRate = 0.0,
        _noneCount = 0,
        _dockedCount = 0,
        _dockedByOtherCount = 0,
        _engagedCount = 0;

  void updateWithState(ClimbingState value) {
    switch (value) {
      case ClimbingState.none:
        _noneCount++;
        break;
      case ClimbingState.docked:
        _dockedCount++;
        break;
      case ClimbingState.dockedByOther:
        _dockedByOtherCount++;
        break;
      case ClimbingState.engaged:
        _engagedCount++;
        break;
    }

    final count = _noneCount + _dockedCount + _dockedByOtherCount;
    noneRate = _noneCount / count;
    dockedRate = _dockedCount / count;
    dockedByOtherRate = _dockedByOtherCount / count;
    engagedRate = _engagedCount / count;
  }
}

/// Autonomous climbings.
class AutoClimbStat {
  AutoClimbStat({
    required this.states,
    required this.duration,
  });

  /// Rates of climbing states.
  ClimbingStateStat states;

  /// Rates of climbing durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  AutoClimbStat.defaults()
      : states = ClimbingStateStat.defaults(),
        duration = ActionDurationStat.defaults();

  void updateWithClimb(AutoClimb climb) {
    states.updateWithState(climb.state);
    duration.updateWithDuration(climb.duration);
  }
}

class RobotIndexStat {
  RobotIndexStat({
    required this.firstRate,
    required this.secondRate,
    required this.thirdRate,
  })  : _firstCount = 0,
        _secondCount = 0,
        _thirdCount = 0;

  /// The robot climbed first.
  ///
  /// Together with [secondRate] and [thirdRate] represents 100% of the climbing indexes.
  double firstRate;

  /// The robot climbed second.
  ///
  /// Together with [firstRate] and [thirdRate] represents 100% of the climbing indexes.
  double secondRate;

  /// The robot climbed third.
  ///
  /// Together with [firstRate] and [secondRate] represents 100% of the climbing indexes.
  double thirdRate;

  int _firstCount, _secondCount, _thirdCount;

  /// Uses default values for all fields.
  RobotIndexStat.defaults()
      : firstRate = 0.0,
        secondRate = 0.0,
        thirdRate = 0.0,
        _firstCount = 0,
        _secondCount = 0,
        _thirdCount = 0;

  void updateWithIndex(RobotIndex value) {
    if (value == RobotIndex.first) {
      _firstCount++;
    } else if (value == RobotIndex.second) {
      _secondCount++;
    } else if (value == RobotIndex.third) {
      _thirdCount++;
    }

    final count = _firstCount + _secondCount + _thirdCount;
    firstRate = _firstCount / count;
    secondRate = _secondCount / count;
    thirdRate = _thirdCount / count;
  }
}

/// Autonomous climbings.
class EndgameClimbStat {
  EndgameClimbStat({
    required this.states,
    required this.indexes,
    required this.duration,
  });

  /// Rates of climbing states.
  ClimbingStateStat states;

  /// Rates of climbing indexes.
  RobotIndexStat indexes;

  /// Rates of climbing durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  EndgameClimbStat.defaults()
      : states = ClimbingStateStat.defaults(),
        indexes = RobotIndexStat.defaults(),
        duration = ActionDurationStat.defaults();

  void updateWithClimb(EndgameClimb climb) {
    states.updateWithState(climb.state);
    indexes.updateWithIndex(climb.robotIndex);
    duration.updateWithDuration(climb.duration);
  }
}

extension TeamsListToTeamNumbersList on List<Team> {
  List<String> toTeamNumbers() {
    return map((team) => '${team.info.number.toString()} ${team.info.name}')
        .toList();
  }
}
