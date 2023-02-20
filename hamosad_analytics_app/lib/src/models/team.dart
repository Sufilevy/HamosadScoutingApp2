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
  final int number;
  final String name, location;
  final int rank;
  final int won, lost;
  final Stat score, focus;
  final RobotIndexStat defenceIndex;
  final List<String> notes, fouls;

  TeamInfo({
    required this.number,
    required this.name,
    required this.location,
    required this.rank,
    required this.won,
    required this.lost,
    required this.score,
    required this.focus,
    required this.defenceIndex,
    required this.notes,
    required this.fouls,
  });

  TeamInfo.defaults({required this.number, required this.name})
      : location = '',
        rank = 1,
        won = 0,
        lost = 0,
        score = Stat(),
        focus = Stat(),
        defenceIndex = RobotIndexStat.defaults(),
        notes = [],
        fouls = [];

  TeamInfo.only({
    required this.number,
    required this.name,
    String? location,
    int? rank,
    int? won,
    int? lost,
    Stat? score,
    Stat? focus,
    RobotIndexStat? defenceIndex,
    List<String>? notes,
    List<String>? fouls,
  })  : location = location ?? '',
        rank = rank ?? 1,
        won = won ?? 0,
        lost = lost ?? 0,
        score = score ?? Stat(),
        focus = focus ?? Stat(),
        defenceIndex = defenceIndex ?? RobotIndexStat.defaults(),
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
}

/// All of the team's autonomous stats and averages.
class TeamAuto {
  final Stat score;
  final StartPositionStat startPosition;
  final double leftCommunityRate;
  final PiecesPickupsStat pickups;
  final PiecesDropoffsStat dropoffs;
  final CommunityPassesStat communityPasses;
  final ChargeStationPassesStat chargeStationPasses;
  final AutoClimbStat climb;
  final List<String> notes;

  TeamAuto({
    required this.score,
    required this.startPosition,
    required this.leftCommunityRate,
    required this.pickups,
    required this.dropoffs,
    required this.communityPasses,
    required this.chargeStationPasses,
    required this.climb,
    required this.notes,
  });

  /// Uses default values for all fields.
  TeamAuto.defaults()
      : score = Stat(),
        startPosition = StartPositionStat.defaults(),
        leftCommunityRate = 0.0,
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        communityPasses = CommunityPassesStat.defaults(),
        chargeStationPasses = ChargeStationPassesStat.defaults(),
        climb = AutoClimbStat.defaults(),
        notes = [];

  TeamAuto.only({
    Stat? score,
    StartPositionStat? startPosition,
    double? leftCommunityRate,
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    CommunityPassesStat? communityPasses,
    ChargeStationPassesStat? chargeStationPasses,
    AutoClimbStat? climb,
    List<String>? notes,
  })  : score = score ?? Stat(),
        startPosition = startPosition ?? StartPositionStat.defaults(),
        leftCommunityRate = leftCommunityRate ?? 0.0,
        pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        communityPasses = communityPasses ?? CommunityPassesStat.defaults(),
        chargeStationPasses = ChargeStationPassesStat.defaults(),
        climb = climb ?? AutoClimbStat.defaults(),
        notes = notes ?? [];
}

/// All of the team's teleop stats and averages.
class TeamTeleop {
  final Stat score;
  final PiecesPickupsStat pickups;
  final PiecesDropoffsStat dropoffs;
  final CommunityPassesStat communityPasses;
  final ChargeStationPassesStat chargeStationPasses;
  final LoadingZonePassesStat loadingZonePasses;
  final List<String> notes;

  TeamTeleop({
    required this.score,
    required this.pickups,
    required this.dropoffs,
    required this.communityPasses,
    required this.chargeStationPasses,
    required this.loadingZonePasses,
    required this.notes,
  });

  /// Uses default values for all fields.
  TeamTeleop.defaults()
      : score = Stat(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        communityPasses = CommunityPassesStat.defaults(),
        chargeStationPasses = ChargeStationPassesStat.defaults(),
        loadingZonePasses = LoadingZonePassesStat.defaults(),
        notes = [];

  TeamTeleop.only({
    Stat? score,
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    CommunityPassesStat? communityPasses,
    ChargeStationPassesStat? chargeStationPasses,
    LoadingZonePassesStat? loadingZonePasses,
    List<String>? notes,
  })  : score = score ?? Stat(),
        pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        communityPasses = communityPasses ?? CommunityPassesStat.defaults(),
        chargeStationPasses =
            chargeStationPasses ?? ChargeStationPassesStat.defaults(),
        loadingZonePasses =
            loadingZonePasses ?? LoadingZonePassesStat.defaults(),
        notes = notes ?? [];
}

/// All of the team's endgame stats and averages.
class TeamEndgame {
  final Stat score;
  final PiecesPickupsStat pickups;
  final PiecesDropoffsStat dropoffs;
  final CommunityPassesStat communityPasses;
  final ChargeStationPassesStat chargeStationPasses;
  final LoadingZonePassesStat loadingZonePassesStat;
  final EndgameClimbStat climb;
  final List<String> notes;

  TeamEndgame({
    required this.score,
    required this.pickups,
    required this.dropoffs,
    required this.communityPasses,
    required this.chargeStationPasses,
    required this.loadingZonePassesStat,
    required this.climb,
    required this.notes,
  });

  /// Uses default values for all fields.
  TeamEndgame.defaults()
      : score = Stat(),
        pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        communityPasses = CommunityPassesStat.defaults(),
        chargeStationPasses = ChargeStationPassesStat.defaults(),
        loadingZonePassesStat = LoadingZonePassesStat.defaults(),
        climb = EndgameClimbStat.defaults(),
        notes = [];

  TeamEndgame.only({
    Stat? score,
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    CommunityPassesStat? communityPasses,
    ChargeStationPassesStat? chargeStationPasses,
    LoadingZonePassesStat? loadingZonePasses,
    EndgameClimbStat? climb,
    List<String>? notes,
  })  : score = score ?? Stat(),
        pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        communityPasses = communityPasses ?? CommunityPassesStat.defaults(),
        chargeStationPasses =
            chargeStationPasses ?? ChargeStationPassesStat.defaults(),
        loadingZonePassesStat =
            loadingZonePasses ?? LoadingZonePassesStat.defaults(),
        climb = climb ?? EndgameClimbStat.defaults(),
        notes = notes ?? [];
}

class TeamSummary {
  final PiecesPickupsStat pickups;
  final PiecesDropoffsStat dropoffs;
  final CommunityPassesStat communityPasses;
  final ChargeStationPassesStat chargeStationPasses;
  final LoadingZonePassesStat loadingZonePassesStat;

  TeamSummary({
    required this.pickups,
    required this.dropoffs,
    required this.communityPasses,
    required this.chargeStationPasses,
    required this.loadingZonePassesStat,
  });

  /// Uses default values for all fields.
  TeamSummary.defaults()
      : pickups = PiecesPickupsStat.defaults(),
        dropoffs = PiecesDropoffsStat.defaults(),
        communityPasses = CommunityPassesStat.defaults(),
        chargeStationPasses = ChargeStationPassesStat.defaults(),
        loadingZonePassesStat = LoadingZonePassesStat.defaults();

  TeamSummary.only({
    PiecesPickupsStat? pickups,
    PiecesDropoffsStat? dropoffs,
    CommunityPassesStat? communityPasses,
    ChargeStationPassesStat? chargeStationPasses,
    LoadingZonePassesStat? loadingZonePasses,
  })  : pickups = pickups ?? PiecesPickupsStat.defaults(),
        dropoffs = dropoffs ?? PiecesDropoffsStat.defaults(),
        communityPasses = communityPasses ?? CommunityPassesStat.defaults(),
        chargeStationPasses =
            chargeStationPasses ?? ChargeStationPassesStat.defaults(),
        loadingZonePassesStat =
            loadingZonePasses ?? LoadingZonePassesStat.defaults();
}

/// Rates of the robot's starting positions.
class StartPositionStat {
  StartPositionStat({
    required this.arenaWallRate,
    required this.middleRate,
    required this.loadingZoneRate,
  });

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

  /// Uses default values for all fields.
  StartPositionStat.defaults()
      : arenaWallRate = 0.0,
        middleRate = 0.0,
        loadingZoneRate = 0.0;
}

/// Rates of different durations (0-2, 2-5, 5+).
class ActionDurationStat {
  ActionDurationStat({
    required this.zeroToTwoRate,
    required this.twoToFiveRate,
    required this.fivePlusRate,
  });

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

  /// Uses default values for all fields.
  ActionDurationStat.defaults()
      : zeroToTwoRate = 0.0,
        twoToFiveRate = 0.0,
        fivePlusRate = 0.0;
}

/// Rates of cones and cubes for a specific action.
class PiecesStat {
  PiecesStat({
    required this.conesRate,
    required this.cubesRate,
    required this.cones,
    required this.cubes,
  });

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

  /// Uses default values for all fields.
  PiecesStat.defaults()
      : conesRate = 0.0,
        cubesRate = 0.0,
        cones = Stat(),
        cubes = Stat();
}

/// Pickups from the single or double substations.
class SubstationsPiecePickupsStat {
  SubstationsPiecePickupsStat({
    required this.doubleLeftShelfAverage,
    required this.doubleRightShelfAverage,
    required this.doubleLeftFloorAverage,
    required this.doubleRightFloorAverage,
    required this.singleAverage,
    required this.duration,
  });

  /// Per-game average.
  PiecesStat doubleLeftShelfAverage,
      doubleRightShelfAverage,
      doubleLeftFloorAverage,
      doubleRightFloorAverage,
      singleAverage;

  /// Rates of different pickup durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  SubstationsPiecePickupsStat.defaults()
      : doubleLeftShelfAverage = PiecesStat.defaults(),
        doubleRightShelfAverage = PiecesStat.defaults(),
        doubleLeftFloorAverage = PiecesStat.defaults(),
        doubleRightFloorAverage = PiecesStat.defaults(),
        singleAverage = PiecesStat.defaults(),
        duration = ActionDurationStat.defaults();
}

/// Pickups from the floor, either laying or standing.
class FloorPiecePickupsStat {
  FloorPiecePickupsStat({
    required this.standingAverage,
    required this.layingAverage,
    required this.duration,
  });

  /// Per-game average.
  PiecesStat standingAverage, layingAverage;

  /// Rates of different pickup durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  FloorPiecePickupsStat.defaults()
      : standingAverage = PiecesStat.defaults(),
        layingAverage = PiecesStat.defaults(),
        duration = ActionDurationStat.defaults();
}

/// Pickups from all positions.
class PiecesPickupsStat {
  PiecesPickupsStat({
    required this.substationsPickups,
    required this.floorPickups,
    required this.pieces,
    required this.duration,
  });

  /// Pickups from the single or double substations.
  SubstationsPiecePickupsStat substationsPickups;

  /// Pickups from the floor.
  FloorPiecePickupsStat floorPickups;

  /// Rates of cones and cubes being picked up.
  PiecesStat pieces;

  /// Rates of different pickup durations.
  ActionDurationStat duration;

  /// Uses default values for all fields.
  PiecesPickupsStat.defaults()
      : substationsPickups = SubstationsPiecePickupsStat.defaults(),
        floorPickups = FloorPiecePickupsStat.defaults(),
        pieces = PiecesStat.defaults(),
        duration = ActionDurationStat.defaults();
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
}

/// Dropoffs made in all grids.
class PiecesDropoffsStat {
  PiecesDropoffsStat({
    required this.arenaWallGrid,
    required this.coopGrid,
    required this.loadingZoneGrid,
    required this.pieces,
    required this.duration,
  });

  /// Dropoffs made in the grid closest to the arena wall.
  GridDropoffsStat arenaWallGrid;

  /// Dropoffs made in the middle grid (aka the coopertition / co-op grid).
  GridDropoffsStat coopGrid;

  /// Dropoffs made in the grid closest to the loading zone.
  GridDropoffsStat loadingZoneGrid;

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
        duration = ActionDurationStat.defaults();
}

/// Passes in the alliance's community (closest to the arena wall or loading zone).
class CommunityPassesStat {
  CommunityPassesStat({
    required this.arenaWallRate,
    required this.loadingZoneRate,
  });

  /// Rate of passes closest to the arena wall.
  ///
  /// Together with [loadingZoneRate] represents 100% of all community passes.
  double arenaWallRate;

  /// Rate of passes closest to the loading zone.
  ///
  /// Together with [arenaWallRate] represents 100% of all community passes.
  double loadingZoneRate;

  /// Uses default values for all fields.
  CommunityPassesStat.defaults()
      : arenaWallRate = 0.0,
        loadingZoneRate = 0.0;
}

/// Passes in the alliance's loading zone (start or end of the zone).
class LoadingZonePassesStat {
  LoadingZonePassesStat({
    required this.startRate,
    required this.endRate,
  });

  /// Rate of passes at the start of the loading zone.
  ///
  /// Together with [endRate] represents 100% of all community passes.
  double startRate;

  /// Rate of passes at the end of the loading zone.
  ///
  /// Together with [startRate] represents 100% of all community passes.
  double endRate;

  /// Uses default values for all fields.
  LoadingZonePassesStat.defaults()
      : startRate = 0.0,
        endRate = 0.0;
}

/// Passes in the alliance's charge station (entering or exiting the community).
class ChargeStationPassesStat {
  ChargeStationPassesStat({
    required this.enteredCommunityRate,
    required this.exitedCommunityRate,
  });

  /// Rate of passes on the charge station to enter the community.
  ///
  /// Together with [exitedCommunityRate] represents 100% of all community passes.
  double enteredCommunityRate;

  /// Rate of passes on the charge station to exit the community.
  ///
  /// Together with [enteredCommunityRate] represents 100% of all community passes.
  double exitedCommunityRate;

  /// Uses default values for all fields.
  ChargeStationPassesStat.defaults()
      : enteredCommunityRate = 0.0,
        exitedCommunityRate = 0.0;
}

/// Climbings states (not climbed, docked, docked by another robot or engaged).
class ClimbingStateStat {
  ClimbingStateStat({
    required this.noneRate,
    required this.dockedRate,
    required this.dockedByOtherRate,
    required this.engagedRate,
  });

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

  /// Uses default values for all fields.
  ClimbingStateStat.defaults()
      : noneRate = 0.0,
        dockedRate = 0.0,
        dockedByOtherRate = 0.0,
        engagedRate = 0.0;
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
}

class RobotIndexStat {
  RobotIndexStat({
    required this.firstRate,
    required this.secondRate,
    required this.thirdRate,
  });

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

  /// Uses default values for all fields.
  RobotIndexStat.defaults()
      : firstRate = 0.0,
        secondRate = 0.0,
        thirdRate = 0.0;
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
}
