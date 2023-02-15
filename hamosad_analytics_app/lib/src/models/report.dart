import 'package:dartx/dartx.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:intl/intl.dart';

class Report {
  final int teamNumber, scouterTeamNumber;
  final String match, scouter;
  final DateTime time;
  final ReportAuto auto;
  final ReportTeleop teleop;
  final ReportEndgame endgame;
  final ReportSummary summary;

  Report.fromJson(Json json)
      : teamNumber = json['info']['teamNumber'],
        scouterTeamNumber = json['info']['scouterTeamNumber'],
        match = json['info']['match'],
        scouter = json['info']['scouter'],
        time = DateFormat('dd/MM HH:mm:ss').parse(json['info']['time']),
        auto = ReportAuto.fromJson(json['auto']),
        teleop = ReportTeleop.fromJson(json['teleop']),
        endgame = ReportEndgame.fromJson(json['endgame']),
        summary = ReportSummary.fromJson(json['summary']);
}

class ReportAuto {
  StartPosition? startPosition;
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  List<CommunityPass> communityPasses;
  List<ChargeStationPass> chargeStationPasses;
  AutoClimb? climb;
  String notes;

  ReportAuto.fromJson(Json json)
      : startPosition = StartPosition.fromString(json['startPosition']),
        pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        communityPasses = CommunityPass.list(json['communityPasses']),
        chargeStationPasses =
            ChargeStationPass.list(json['chargeStationPasses']),
        climb = AutoClimb.fromJson(json['climb']),
        notes = json['notes'];
}

class ReportTeleop {
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  List<CommunityPass> communityPasses;
  List<ChargeStationPass> chargeStationPasses;
  List<LoadingZonePass> loadingZonePasses;
  String notes;

  ReportTeleop.fromJson(Json json)
      : pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        communityPasses = CommunityPass.list(json['communityPasses']),
        chargeStationPasses =
            ChargeStationPass.list(json['chargeStationPasses']),
        loadingZonePasses = LoadingZonePass.list(json['loadingZonePasses']),
        notes = json['notes'];
}

class ReportEndgame {
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  List<CommunityPass> communityPasses;
  List<ChargeStationPass> chargeStationPasses;
  List<LoadingZonePass> loadingZonePasses;
  EndgameClimb? climb;
  String notes;

  ReportEndgame.fromJson(Json json)
      : pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        communityPasses = CommunityPass.list(json['communityPasses']),
        chargeStationPasses =
            ChargeStationPass.list(json['chargeStationPasses']),
        climb = EndgameClimb.fromJson(json['climb']),
        loadingZonePasses = LoadingZonePass.list(json['loadingZonePasses']),
        notes = json['notes'];
}

class ReportSummary {
  bool won;
  RobotIndex? defenceRobotIndex;
  String fouls, notes;
  int autoDropoffsCount, teleopDropoffsCount, endgameDropoffsCount;

  ReportSummary.fromJson(Json json)
      : won = json['won'],
        defenceRobotIndex = RobotIndex.fromString(json['defenceRobotIndex']),
        fouls = json['fouls'],
        notes = json['notes'],
        autoDropoffsCount = json['autoDropoffsCount'],
        teleopDropoffsCount = json['teleopDropoffsCount'],
        endgameDropoffsCount = json['endgameDropoffsCount'];
}

enum ActionDuration {
  zeroToTwo,
  twoToFive,
  fivePlus;

  @override
  String toString() {
    switch (this) {
      case zeroToTwo:
        return '0-2';
      case twoToFive:
        return '2-5';
      case fivePlus:
        return '5+';
    }
  }

  static ActionDuration? fromString(String value) {
    switch (value) {
      case '0-2':
        return zeroToTwo;
      case '2-5':
        return twoToFive;
      case '5+':
        return fivePlus;
    }
    return null;
  }
}

enum Piece {
  cone,
  cube;

  static Piece? fromString(String value) {
    switch (value) {
      case 'cone':
        return cone;
      case 'cube':
        return cube;
    }
    return null;
  }
}

enum Grid {
  arenaWall,
  coop,
  loadingZone;

  static Grid? fromString(String value) {
    switch (value) {
      case 'arenaWall':
        return arenaWall;
      case 'coop':
        return coop;
      case 'loadingZone':
        return loadingZone;
    }
    return null;
  }
}

enum RobotIndex {
  first,
  second,
  third;

  static RobotIndex? fromString(String value) {
    switch (value) {
      case 'first':
        return first;
      case 'second':
        return second;
      case 'third':
        return third;
    }
    return null;
  }
}

enum StartPosition {
  arenaWall,
  middle,
  loadingZone;

  static StartPosition? fromString(String value) {
    switch (value) {
      case 'arenaWall':
        return arenaWall;
      case 'middle':
        return middle;
      case 'loadingZone':
        return loadingZone;
    }
    return null;
  }
}

enum PiecePickupPosition {
  doubleLeftShelf,
  doubleRightShelf,
  doubleLeftFloor,
  doubleRightFloor,
  single,
  floorStanding,
  floorLaying;

  static PiecePickupPosition? fromString(String value) {
    switch (value) {
      case 'doubleLeftShelf':
        return doubleLeftShelf;
      case 'doubleRightShelf':
        return doubleRightShelf;
      case 'doubleLeftFloor':
        return doubleLeftFloor;
      case 'doubleRightFloor':
        return doubleRightFloor;
      case 'single':
        return single;
      case 'floorStanding':
        return floorStanding;
      case 'floorLaying':
        return floorLaying;
    }
    return null;
  }
}

class PiecePickup {
  const PiecePickup({
    required this.duration,
    required this.position,
    required this.gamePiece,
  });

  final ActionDuration duration;
  final PiecePickupPosition position;
  final Piece gamePiece;

  static PiecePickup? fromJson(Json json) {
    final duration = ActionDuration.fromString(json['duration']);
    final position = PiecePickupPosition.fromString(json['position']);
    final gamePiece = Piece.fromString(json['gamePiece']);

    if (duration == null || position == null || gamePiece == null) {
      return null;
    }

    return PiecePickup(
      duration: duration,
      position: position,
      gamePiece: gamePiece,
    );
  }

  static List<PiecePickup> list(List<Json> list) {
    return list.map((pickup) => fromJson(pickup)).filterNotNull().toList();
  }
}

class PieceDropoff {
  const PieceDropoff({
    required this.duration,
    required this.grid,
    required this.row,
    required this.column,
    required this.gamePiece,
  });

  final ActionDuration duration;
  final Grid grid;
  final int row, column;
  final Piece gamePiece;

  static PieceDropoff? fromJson(Json json) {
    final duration = ActionDuration.fromString(json['duration']);
    final grid = Grid.fromString(json['grid']);
    final row = json['row'];
    final column = json['column'];
    final gamePiece = Piece.fromString(json['gamePiece']);

    if (duration == null ||
        grid == null ||
        row == null ||
        column == null ||
        gamePiece == null) {
      return null;
    }

    return PieceDropoff(
      duration: duration,
      grid: grid,
      row: row,
      column: column,
      gamePiece: gamePiece,
    );
  }

  static List<PieceDropoff> list(List<Json> list) {
    return list.map((dropoff) => fromJson(dropoff)).filterNotNull().toList();
  }
}

enum CommunityPass {
  arenaWall,
  loadingZone;

  static CommunityPass? fromString(String value) {
    switch (value) {
      case 'arenaWall':
        return arenaWall;
      case 'loadingZone':
        return loadingZone;
    }
    return null;
  }

  static List<CommunityPass> list(List<String> list) {
    return list.map((pass) => fromString(pass)).filterNotNull().toList();
  }
}

enum LoadingZonePass {
  start,
  end;

  static LoadingZonePass? fromString(String value) {
    switch (value) {
      case 'start':
        return start;
      case 'end':
        return end;
    }
    return null;
  }

  static List<LoadingZonePass> list(List<String> list) {
    return list.map((pass) => fromString(pass)).filterNotNull().toList();
  }
}

enum ChargeStationPass {
  enteredCommunity,
  exitedCommunity;

  static ChargeStationPass? fromString(String value) {
    switch (value) {
      case 'enteredCommunity':
        return enteredCommunity;
      case 'exitedCommunity':
        return exitedCommunity;
    }
    return null;
  }

  static List<ChargeStationPass> list(List<String> list) {
    return list.map((pass) => fromString(pass)).filterNotNull().toList();
  }
}

enum ClimbingState {
  none,
  docked,
  dockedByOther,
  engaged;

  static ClimbingState? fromString(String value) {
    switch (value) {
      case 'none':
        return none;
      case 'docked':
        return docked;
      case 'dockedByOther':
        return dockedByOther;
      case 'engaged':
        return engaged;
    }
    return null;
  }
}

class AutoClimb {
  const AutoClimb({
    required this.duration,
    required this.state,
  });

  final ActionDuration duration;
  final ClimbingState state;

  static AutoClimb? fromJson(Json json) {
    final duration = ActionDuration.fromString(json['duration']);
    final state = ClimbingState.fromString(json['state']);

    if (state == null || duration == null) {
      return null;
    }

    return AutoClimb(
      duration: duration,
      state: state,
    );
  }
}

class EndgameClimb {
  const EndgameClimb({
    required this.duration,
    required this.state,
    required this.robotIndex,
  });

  final ActionDuration duration;
  final ClimbingState state;
  final RobotIndex robotIndex;

  static EndgameClimb? fromJson(Json json) {
    final duration = ActionDuration.fromString(json['duration']);
    final state = ClimbingState.fromString(json['state']);
    final robotIndex = RobotIndex.fromString(json['robotIndex']);

    if (duration == null || state == null || robotIndex == null) {
      return null;
    }

    return EndgameClimb(
      duration: duration,
      state: state,
      robotIndex: robotIndex,
    );
  }
}
