import 'package:hamosad_analytics_app/src/models.dart';
import 'package:intl/intl.dart';

class Report {
  final int teamNumber;
  final String match, scouter;
  final DateTime time;
  final ReportAuto auto;
  final ReportTeleop teleop;
  final ReportEndgame endgame;
  final ReportSummary summary;

  Report.fromJson(Json json)
      : teamNumber = json['info']['teamNumber'],
        match = json['info']['match'],
        scouter = json['info']['scouter'],
        time = DateFormat('dd/MM HH:mm:ss').parse(json['info']['time']),
        auto = ReportAuto.fromJson(json['auto']),
        teleop = ReportTeleop.fromJson(json['teleop']),
        endgame = ReportEndgame.fromJson(json['endgame']),
        summary = ReportSummary.fromJson(json['summary']);
}

class ReportAuto {
  StartPosition startPosition;
  List<GamePiecePickup> pickups;
  List<GamePieceDropoff> dropoffs;
  List<CommunityPass> communityPasses;
  List<ChargeStationPass> chargeStationPasses;
  AutoClimb climb;
  String notes;

  ReportAuto.fromJson(Json json)
      : startPosition = StartPosition.fromString(json['startPosition'])!,
        pickups = GamePiecePickup.list(json['pickups']),
        dropoffs = GamePieceDropoff.list(json['dropoffs']),
        communityPasses = CommunityPass.list(json['communityPasses']),
        chargeStationPasses =
            ChargeStationPass.list(json['chargeStationPasses']),
        climb = AutoClimb.fromJson(json['climb'])!,
        notes = json['notes'];
}

class ReportTeleop {
  List<GamePiecePickup> pickups;
  List<GamePieceDropoff> dropoffs;
  List<CommunityPass> communityPasses;
  List<LoadingZonePass> loadingZonePasses;
  List<ChargeStationPass> chargeStationPasses;
  String notes;

  ReportTeleop.fromJson(Json json)
      : pickups = GamePiecePickup.list(json['pickups']),
        dropoffs = GamePieceDropoff.list(json['dropoffs']),
        communityPasses = CommunityPass.list(json['communityPasses']),
        loadingZonePasses = LoadingZonePass.list(json['loadingZonePasses']),
        chargeStationPasses =
            ChargeStationPass.list(json['chargeStationPasses']),
        notes = json['notes'];
}

class ReportEndgame {
  List<GamePiecePickup> pickups;
  List<GamePieceDropoff> dropoffs;
  List<CommunityPass> communityPasses;
  List<ChargeStationPass> chargeStationPasses;
  EndgameClimb climb;
  String notes;

  ReportEndgame.fromJson(Json json)
      : pickups = GamePiecePickup.list(json['pickups']),
        dropoffs = GamePieceDropoff.list(json['dropoffs']),
        communityPasses = CommunityPass.list(json['communityPasses']),
        chargeStationPasses =
            ChargeStationPass.list(json['chargeStationPasses']),
        climb = EndgameClimb.fromJson(json['climb'])!,
        notes = json['notes'];
}

class ReportSummary {
  bool won;
  RobotIndex defenceRobotIndex;
  String fouls, notes;
  int autoDropoffsCount, teleopDropoffsCount, endgameDropoffsCount;

  ReportSummary.fromJson(Json json)
      : won = json['won'],
        defenceRobotIndex = RobotIndex.fromString(json['defenceRobotIndex'])!,
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

enum GamePiece {
  cone,
  cube;

  static GamePiece? fromString(String value) {
    switch (value) {
      case 'cone':
        return cone;
      case 'cube':
        return cube;
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

enum GamePiecePickupPosition {
  doubleLeftShelf,
  doubleRightShelf,
  doubleLeftFloor,
  doubleRightFloor,
  single,
  floorStanding,
  floorLaying;

  static GamePiecePickupPosition? fromString(String value) {
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

class GamePiecePickup {
  const GamePiecePickup({
    required this.duration,
    required this.position,
    required this.gamePiece,
  });

  final ActionDuration duration;
  final GamePiecePickupPosition position;
  final GamePiece gamePiece;

  static GamePiecePickup? fromJson(Json json) {
    final duration = ActionDuration.fromString(json['duration']);
    final position = GamePiecePickupPosition.fromString(json['position']);
    final gamePiece = GamePiece.fromString(json['gamePiece']);

    if (duration == null || position == null || gamePiece == null) {
      return null;
    }

    return GamePiecePickup(
      duration: duration,
      position: position,
      gamePiece: gamePiece,
    );
  }

  static List<GamePiecePickup> list(List<Json> list) {
    return list.map((pickup) => fromJson(pickup)!).toList();
  }
}

class GamePieceDropoff {
  const GamePieceDropoff({
    required this.duration,
    required this.row,
    required this.column,
    required this.gamePiece,
  });

  final ActionDuration duration;
  final int row, column;
  final GamePiece gamePiece;

  static GamePieceDropoff? fromJson(Json json) {
    final duration = ActionDuration.fromString(json['duration']);
    final row = json['row'];
    final column = json['column'];
    final gamePiece = GamePiece.fromString(json['gamePiece']);

    if (duration == null ||
        row == null ||
        column == null ||
        gamePiece == null) {
      return null;
    }

    return GamePieceDropoff(
      duration: duration,
      row: row,
      column: column,
      gamePiece: gamePiece,
    );
  }

  static List<GamePieceDropoff> list(List<Json> list) {
    return list.map((dropoff) => fromJson(dropoff)!).toList();
  }
}

enum CommunityPass {
  left,
  right;

  static CommunityPass? fromString(String value) {
    switch (value) {
      case 'left':
        return left;
      case 'right':
        return right;
    }
    return null;
  }

  static List<CommunityPass> list(List<String> list) {
    return list.map((pass) => fromString(pass)!).toList();
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
    return list.map((pass) => fromString(pass)!).toList();
  }
}

enum ChargeStationPass {
  entered,
  exited;

  static ChargeStationPass? fromString(String value) {
    switch (value) {
      case 'entered':
        return entered;
      case 'exited':
        return exited;
    }
    return null;
  }

  static List<ChargeStationPass> list(List<String> list) {
    return list.map((pass) => fromString(pass)!).toList();
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
    required this.state,
  });

  final ClimbingState state;

  static AutoClimb? fromJson(Json json) {
    final state = ClimbingState.fromString(json['state']);

    if (state == null) {
      return null;
    }

    return AutoClimb(
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
