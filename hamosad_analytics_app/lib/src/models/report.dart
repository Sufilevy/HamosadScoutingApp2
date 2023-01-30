import 'package:hamosad_analytics_app/src/models.dart';
import 'package:intl/intl.dart';

class Report {
  final int teamNumber;
  final String match, scouter;
  final DateTime time;
  final ReportAutonomus autonomus;
  final ReportTeleop teleop;
  final ReportEndgame endgame;
  final ReportSummary summary;

  Report({
    required this.teamNumber,
    required this.match,
    required this.scouter,
    required this.time,
  })  : autonomus = ReportAutonomus(),
        teleop = ReportTeleop(),
        endgame = ReportEndgame(),
        summary = ReportSummary();

  Report.fromJson(Json json)
      : teamNumber = (json['info'] ?? {})['teamNumber'] ?? 0,
        match = (json['info'] ?? {})['match'] ?? '',
        scouter = (json['info'] ?? {})['scouter'] ?? '',
        time = DateFormat('dd/MM HH:mm:ss')
            .parse((json['info'] ?? {})['time'] ?? '01/01 00:00:00'),
        autonomus = ReportAutonomus.fromJson(json['autonomus'] ?? {}),
        teleop = ReportTeleop.fromJson(json['teleop'] ?? {}),
        endgame = ReportEndgame.fromJson(json['endgame'] ?? {}),
        summary = ReportSummary.fromJson(json['summary'] ?? {});
}

class ReportAutonomus {
  String notes;

  ReportAutonomus({
    this.notes = '',
  });

  ReportAutonomus.fromJson(Json json) : notes = json['notes'] ?? '';
}

class ReportTeleop {
  String notes;

  ReportTeleop({
    this.notes = '',
  });

  ReportTeleop.fromJson(Json json) : notes = json['notes'] ?? '';
}

class ReportEndgame {
  String notes;

  ReportEndgame({
    this.notes = '',
  });

  ReportEndgame.fromJson(Json json) : notes = json['notes'] ?? '';
}

class ReportSummary {
  bool won;
  int focus;
  int autonomusScore, teleopScore, endgameScore, totalScore;

  ReportSummary({
    this.won = false,
    this.focus = 0,
    this.autonomusScore = 0,
    this.teleopScore = 0,
    this.endgameScore = 0,
    this.totalScore = 0,
  });

  ReportSummary.fromJson(Json json)
      : won = json['won'] ?? false,
        focus = json['focus'] ?? 0,
        autonomusScore = json['autonomusScore'] ?? 0,
        teleopScore = json['teleopScore'] ?? 0,
        endgameScore = json['endgameScore'] ?? 0,
        totalScore = json['totalScore'] ?? 0;
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
    final duration = ActionDuration.fromString(json['duration'] ?? '');
    final position = GamePiecePickupPosition.fromString(json['position'] ?? '');
    final gamePiece = GamePiece.fromString(json['gamePiece'] ?? '');

    if (duration == null || position == null || gamePiece == null) {
      return null;
    }

    return GamePiecePickup(
      duration: duration,
      position: position,
      gamePiece: gamePiece,
    );
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
    final duration = ActionDuration.fromString(json['duration'] ?? '');
    final row = json['row'];
    final column = json['column'];
    final gamePiece = GamePiece.fromString(json['gamePiece'] ?? '');

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
}
