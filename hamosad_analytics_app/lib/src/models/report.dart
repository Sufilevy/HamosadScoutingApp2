import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
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

  int get score {
    return auto.score + teleop.score + endgame.score;
  }
}

class ReportAuto {
  StartPosition startPosition;
  bool leftCommunity;
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  int chargeStationPasses;
  AutoClimb climb;
  String notes;

  ReportAuto.fromJson(Json json)
      : startPosition = StartPosition.fromString(json['startPosition'])!,
        leftCommunity = false,
        pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        chargeStationPasses = int.parse(json['chargeStationPasses']),
        climb = AutoClimb.fromJson(json['climb'])!,
        notes = json['notes'];

  int get score {
    return (leftCommunity ? 3 : 0) + dropoffs.score(isAuto: true) + climb.score;
  }
}

class ReportTeleop {
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  int chargeStationPasses;
  String notes;

  ReportTeleop.fromJson(Json json)
      : pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        chargeStationPasses = int.parse(json['chargeStationPasses']),
        notes = json['notes'];

  int get score {
    return dropoffs.score(isAuto: false);
  }
}

class ReportEndgame {
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  int chargeStationPasses;
  EndgameClimb climb;
  String notes;

  ReportEndgame.fromJson(Json json)
      : pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        chargeStationPasses = int.parse(json['chargeStationPasses']),
        climb = EndgameClimb.fromJson(json['climb'])!,
        notes = json['notes'];

  int get score {
    return dropoffs.score(isAuto: false) + climb.score;
  }
}

class ReportSummary {
  bool won;
  RobotIndex defenceIndex;
  String fouls, notes;

  ReportSummary.fromJson(Json json)
      : won = json['won'],
        defenceIndex = RobotIndex.fromString(json['defenceRobotIndex'])!,
        fouls = json['fouls'],
        notes = json['notes'];
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
  cone(AnalyticsTheme.cones),
  cube(AnalyticsTheme.cubes);

  final Color color;

  const Piece(this.color);

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
  doubleShelf,
  doubleFloor,
  single,
  floor;

  static PiecePickupPosition? fromString(String value) {
    switch (value) {
      case 'doubleShelf':
        return doubleShelf;
      case 'doubleFloor':
        return doubleFloor;
      case 'single':
        return single;
      case 'floor':
        return floor;
    }
    return null;
  }
}

class PiecePickup {
  const PiecePickup({
    required this.duration,
    required this.position,
    required this.piece,
  });

  final ActionDuration duration;
  final PiecePickupPosition position;
  final Piece piece;

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
      piece: gamePiece,
    );
  }

  static List<PiecePickup> list(List<Json> list) {
    return list.map((pickup) => fromJson(pickup)).filterNotNull().toList();
  }
}

extension ListPickupCountPieces on List<PiecePickup> {
  int get numCones {
    return count((pickup) => pickup.piece == Piece.cone);
  }

  int get numCubes {
    return count((pickup) => pickup.piece == Piece.cube);
  }
}

class PieceDropoff {
  const PieceDropoff({
    required this.duration,
    required this.grid,
    required this.row,
    required this.column,
    required this.piece,
  });

  final ActionDuration duration;
  final Grid grid;
  final int row, column;
  final Piece piece;

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
      piece: gamePiece,
    );
  }

  int score({required bool isAuto}) {
    switch (row) {
      case 0:
        return isAuto ? 3 : 2;
      case 1:
        return isAuto ? 4 : 3;
      case 2:
        return isAuto ? 6 : 5;
    }
    return 0;
  }

  static List<PieceDropoff> list(List<Json> list) {
    return list.map((dropoff) => fromJson(dropoff)).filterNotNull().toList();
  }
}

extension _ListDropoffScoring on List<PieceDropoff> {
  int score({required bool isAuto}) {
    return map((dropoff) => dropoff.score(isAuto: isAuto)).sum();
  }
}

extension ListDropoffCountPieces on List<PieceDropoff> {
  int get numCones {
    return count((pickup) => pickup.piece == Piece.cone);
  }

  int get numCubes {
    return count((pickup) => pickup.piece == Piece.cube);
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

  int score({required bool isAuto}) {
    switch (this) {
      case ClimbingState.none:
        return 0;
      case ClimbingState.docked:
      case ClimbingState.dockedByOther:
        return isAuto ? 8 : 6;
      case ClimbingState.engaged:
        return isAuto ? 12 : 10;
    }
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

  int get score {
    return state.score(isAuto: true);
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

  int get score {
    return state.score(isAuto: false);
  }
}
