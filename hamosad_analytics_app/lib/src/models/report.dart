import 'package:hamosad_analytics_app/src/models.dart';
import 'package:intl/intl.dart';

class Report {
  final ReportInfo info;
  final ReportAutonomus autonomus;
  final ReportTeleop teleop;
  final ReportEndgame endgame;
  final ReportSummary summary;

  Report({
    required int teamNumber,
    required String match,
    required String scouter,
    required DateTime time,
  })  : info = ReportInfo(teamNumber, match, scouter, time),
        autonomus = ReportAutonomus(),
        teleop = ReportTeleop(),
        endgame = ReportEndgame(),
        summary = ReportSummary();

  Report.fromJson(Json json)
      : info = ReportInfo.fromJson(json['info'] ?? {}),
        autonomus = ReportAutonomus.fromJson(json['autonomus'] ?? {}),
        teleop = ReportTeleop.fromJson(json['teleop'] ?? {}),
        endgame = ReportEndgame.fromJson(json['endgame'] ?? {}),
        summary = ReportSummary.fromJson(json['summary'] ?? {});
}

class ReportInfo {
  final int teamNumber;
  final String match, scouter;
  final DateTime time;

  const ReportInfo(
    this.teamNumber,
    this.match,
    this.scouter,
    this.time,
  );

  ReportInfo.fromJson(Json json)
      : teamNumber = json['teamNumber'] ?? 0,
        match = json['match'] ?? '',
        scouter = json['scouter'] ?? '',
        time = DateFormat('dd/MM HH:mm:ss')
            .parse(json['time'] ?? '01/01 00:00:00');
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
  int focus, autonomusScore, teleopScore, endgameScore, totalScore;

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
