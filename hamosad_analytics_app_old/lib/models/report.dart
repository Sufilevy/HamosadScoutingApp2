typedef Json = Map<String, dynamic>;

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
    required String time,
    required double timeValue,
  })  : info = ReportInfo(teamNumber, match, scouter, time, timeValue),
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
  final String match;
  final String scouter;
  final String time;
  final double timeValue;

  const ReportInfo(
    this.teamNumber,
    this.match,
    this.scouter,
    this.time,
    this.timeValue,
  );

  ReportInfo.fromJson(Json json)
      : teamNumber = json['teamNumber'] ?? 0,
        match = json['match'] ?? '',
        scouter = json['scouter'] ?? '',
        time = json['time'] ?? '',
        timeValue = json['timeValue'] ?? 0;
}

class ReportAutonomus {
  bool exitedTarmac;
  int pickedTerminal;
  int pickedFloor;
  int missed;
  int lowerHub;
  int upperHub;
  String notes;

  ReportAutonomus({
    this.exitedTarmac = false,
    this.pickedTerminal = 0,
    this.pickedFloor = 0,
    this.missed = 0,
    this.lowerHub = 0,
    this.upperHub = 0,
    this.notes = '',
  });

  ReportAutonomus.fromJson(Json json)
      : exitedTarmac = json['exitedTarmac'] ?? false,
        pickedTerminal = json['pickedTerminal'] ?? 0,
        pickedFloor = json['pickedFloor'] ?? 0,
        missed = json['missed'] ?? 0,
        lowerHub = json['lowerHub'] ?? 0,
        upperHub = json['upperHub'] ?? 0,
        notes = json['notes'] ?? '';
}

class ReportTeleop {
  bool needsAnchorPoint;
  String anchorPoint;
  int pickedTerminal;
  int pickedFloor;
  int missed;
  int lowerHub;
  int upperHub;
  String notes;

  ReportTeleop({
    this.needsAnchorPoint = false,
    this.anchorPoint = '',
    this.pickedTerminal = 0,
    this.pickedFloor = 0,
    this.missed = 0,
    this.lowerHub = 0,
    this.upperHub = 0,
    this.notes = '',
  });

  ReportTeleop.fromJson(Json json)
      : needsAnchorPoint = json['needsAnchorPoint'] ?? false,
        anchorPoint = json['anchorPoint'] ?? '',
        pickedTerminal = json['pickedTerminal'] ?? 0,
        pickedFloor = json['pickedFloor'] ?? 0,
        missed = json['missed'] ?? 0,
        lowerHub = json['lowerHub'] ?? 0,
        upperHub = json['upperHub'] ?? 0,
        notes = json['notes'] ?? '';
}

class ReportEndgame {
  int bar;
  double time;
  String notes;

  ReportEndgame({
    this.bar = 0,
    this.time = 0.0,
    this.notes = '',
  });

  ReportEndgame.fromJson(Json json)
      : bar = json['bar'] ?? 0,
        time = json['time'] ?? 0.0,
        notes = json['notes'] ?? '';
}

class ReportSummary {
  bool won;
  int focus;
  int autonomusScore;
  int teleopScore;
  int endgameScore;
  int totalScore;

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
