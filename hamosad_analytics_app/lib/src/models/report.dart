import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:intl/intl.dart';

class Report {
  final int teamNumber, scouterTeamNumber;
  final String match, scouter, id;
  final DateTime time;
  final ReportAuto auto;
  final ReportTeleop teleop;
  final ReportEndgame endgame;
  final ReportSummary summary;

  Report.fromJson(Json json, {required this.id})
      : teamNumber = int.parse(json['info']['teamNumber']),
        scouterTeamNumber =
            teamNumberFrom(json['info']['scouterTeamNumber'] ?? ''),
        match = json['info']['match'],
        scouter = json['info']['scouter'] ?? '',
        time = DateFormat('dd/MM HH:mm:ss').parse(json['info']['time']),
        auto = ReportAuto.fromJson(json['auto']),
        teleop = ReportTeleop.fromJson(json['teleop']),
        endgame = ReportEndgame.fromJson(json['endgame']),
        summary = ReportSummary.fromJson(json['summary']);

  int get score {
    return auto.score + teleop.score + endgame.score;
  }

  int get autoDropoffs {
    return auto.dropoffs.length;
  }

  int get teleopAndEndgameDropoffs {
    return teleop.dropoffs.length + endgame.dropoffs.length;
  }

  int get totalDropoffs {
    return autoDropoffs + teleopAndEndgameDropoffs;
  }

  int get totalHighDropoffs {
    return auto.dropoffs.numHigh +
        teleop.dropoffs.numHigh +
        endgame.dropoffs.numHigh;
  }

  int get totalMidDropoffs {
    return auto.dropoffs.numMid +
        teleop.dropoffs.numMid +
        endgame.dropoffs.numMid;
  }

  int get totalLowDropoffs {
    return auto.dropoffs.numLow +
        teleop.dropoffs.numLow +
        endgame.dropoffs.numLow;
  }

  int get totalCones {
    return auto.dropoffs.numCones +
        teleop.dropoffs.numCones +
        endgame.dropoffs.numCones;
  }

  int get totalCubes {
    return auto.dropoffs.numCubes +
        teleop.dropoffs.numCubes +
        endgame.dropoffs.numCubes;
  }

  String get matchAndScouter {
    return '$match - $scouter: ';
  }

  static int teamNumberFrom(String teamNumber) {
    if (teamNumber.isEmpty) {
      return 1657;
    } else {
      return int.parse(teamNumber);
    }
  }

  static int compare(Report a, Report b) {
    return a.time.compareTo(b.time);
  }
}

class ReportAuto {
  bool leftCommunity;
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  int chargeStationPasses;
  AutoClimb? climb;
  String notes;

  ReportAuto.fromJson(Json json)
      : leftCommunity = json['leftCommunity'] ?? false,
        pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        chargeStationPasses = json['chargeStationPasses'],
        climb = AutoClimb.fromJson(json['climb']),
        notes = json['notes'] ?? '';

  int get score {
    return (leftCommunity ? 2 : 0) +
        dropoffs.score(isAuto: true) +
        (climb?.score ?? 0);
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
        chargeStationPasses = json['chargeStationPasses'],
        notes = json['notes'] ?? '';

  int get score {
    return dropoffs.score(isAuto: false);
  }
}

class ReportEndgame {
  List<PiecePickup> pickups;
  List<PieceDropoff> dropoffs;
  int chargeStationPasses;
  EndgameClimb? climb;
  String notes;

  ReportEndgame.fromJson(Json json)
      : pickups = PiecePickup.list(json['pickups']),
        dropoffs = PieceDropoff.list(json['dropoffs']),
        chargeStationPasses = json['chargeStationPasses'],
        climb = EndgameClimb.fromJson(json['climb']),
        notes = json['notes'] ?? '';

  int get score {
    return dropoffs.score(isAuto: false) + (climb?.score ?? 0);
  }
}

class ReportSummary {
  DefenceRobotIndex defenceIndex;
  String fouls, notes, defenceNotes;

  ReportSummary.fromJson(Json json)
      : defenceIndex = DefenceRobotIndex.fromString(json['defenceRobotIndex'])!,
        fouls = json['fouls'] ?? '',
        notes = json['notes'] ?? '',
        defenceNotes = json['defenceNotes'] ?? '';
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

  static ActionDuration? fromString(String? value) {
    if (value == null) {
      return zeroToTwo;
    }

    switch (value) {
      case '0-2':
        return ActionDuration.zeroToTwo;
      case '2-5':
        return ActionDuration.twoToFive;
      case '5+':
        return ActionDuration.fivePlus;
    }
    return null;
  }
}

enum Piece {
  cone(AnalyticsTheme.cones),
  cube(AnalyticsTheme.cubes);

  final Color color;

  const Piece(this.color);

  static Piece? fromString(String? value) {
    switch (value) {
      case 'cone':
        return Piece.cone;
      case 'cube':
        return Piece.cube;
    }
    return null;
  }
}

enum RobotIndex {
  first,
  second,
  third;

  static RobotIndex? fromString(String? value) {
    switch (value) {
      case 'first':
        return RobotIndex.first;
      case 'second':
        return RobotIndex.second;
      case 'third':
        return RobotIndex.third;
    }
    return null;
  }
}

enum DefenceRobotIndex {
  almostAll,
  half,
  none;

  static DefenceRobotIndex? fromString(String? value) {
    switch (value) {
      case 'almostAll':
        return DefenceRobotIndex.almostAll;
      case 'half':
        return DefenceRobotIndex.half;
      case 'null':
      case 'none':
        return DefenceRobotIndex.none;
    }
    return null;
  }
}

enum PiecePickupPosition {
  loadingZone,
  floor;

  static PiecePickupPosition? fromString(String? value) {
    switch (value) {
      case 'doubleShelf':
      case 'doubleFloor':
      case 'single':
      case 'loadingZone':
        return PiecePickupPosition.loadingZone;
      case 'floor':
        return PiecePickupPosition.floor;
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
    final gamePiece = Piece.fromString(json['piece']);

    if (duration == null || position == null || gamePiece == null) {
      return null;
    }

    return PiecePickup(
      duration: duration,
      position: position,
      piece: gamePiece,
    );
  }

  static List<PiecePickup> list(List list) {
    if (list.isEmpty) {
      return [];
    }

    return list
        .map((pickup) => fromJson(pickup as Json))
        .filterNotNull()
        .toList();
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
    required this.row,
    required this.piece,
  });

  final ActionDuration duration;
  final int row;
  final Piece piece;

  static PieceDropoff? fromJson(Json json) {
    final duration = ActionDuration.fromString(json['duration']);
    final row = json['row'];
    final gamePiece = Piece.fromString(json['piece']);

    if (duration == null || row == null || gamePiece == null) {
      return null;
    }

    return PieceDropoff(
      duration: duration,
      row: row,
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

  static List<PieceDropoff> list(List list) {
    if (list.isEmpty) {
      return [];
    }

    return list
        .map((dropoff) => fromJson(dropoff as Json))
        .filterNotNull()
        .toList();
  }
}

extension _ListDropoffScoring on List<PieceDropoff> {
  int score({required bool isAuto}) {
    return map((dropoff) => dropoff.score(isAuto: isAuto)).sum();
  }
}

extension ListDropoffCounts on List<PieceDropoff> {
  int get numCones {
    return count((dropoff) => dropoff.piece == Piece.cone);
  }

  int get numCubes {
    return count((dropoff) => dropoff.piece == Piece.cube);
  }

  int get numHigh {
    return count((dropoff) => dropoff.row == 2);
  }

  int get numMid {
    return count((dropoff) => dropoff.row == 1);
  }

  int get numLow {
    return count((dropoff) => dropoff.row == 0);
  }
}

enum ClimbingState {
  noAttempt,
  failed,
  docked,
  engaged;

  static ClimbingState? fromString(String? value) {
    switch (value) {
      case 'null':
      case 'none':
      case 'noAttempt':
        return ClimbingState.noAttempt;
      case 'failed':
        return ClimbingState.failed;
      case 'dockedByOther':
      case 'docked':
        return ClimbingState.docked;
      case 'engaged':
        return ClimbingState.engaged;
    }
    return null;
  }

  int score({required bool isAuto}) {
    switch (this) {
      case ClimbingState.failed:
      case ClimbingState.noAttempt:
        return 0;
      case ClimbingState.docked:
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
  });

  final ActionDuration duration;
  final ClimbingState state;

  static EndgameClimb? fromJson(Json? json) {
    if (json == null) return null;

    final duration = ActionDuration.fromString(json['duration']);
    final state = ClimbingState.fromString(json['state']);

    if (duration == null || state == null) {
      return null;
    }

    return EndgameClimb(
      duration: duration,
      state: state,
    );
  }

  int get score {
    return state.score(isAuto: false);
  }
}
