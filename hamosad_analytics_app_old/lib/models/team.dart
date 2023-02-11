import 'package:hamosad_analytics_app/models.dart';

class Team {
  final TeamInfo info;
  final TeamAutonomus autonomus;
  final TeamTeleop teleop;
  final TeamEndgame endgame;

  Team({
    required this.info,
    required this.autonomus,
    required this.teleop,
    required this.endgame,
  });
}

class TeamInfo {
  final int number;
  final String name;
  final double winRate;
  final Stat<int> score;
  final Stat<int> focus;

  TeamInfo({
    required this.number,
    required this.name,
    required this.winRate,
    required this.score,
    required this.focus,
  });
}

class TeamAutonomus {
  final Stat<int> score;
  final double exitTarmacRate;
  final double averagePickedTerminal;
  final double averagePickedFloor;
  final double averageMissed;
  final double averageLowerHub;
  final double averageUpperHub;
  final List<String> notes;

  TeamAutonomus({
    required this.score,
    required this.exitTarmacRate,
    required this.averagePickedTerminal,
    required this.averagePickedFloor,
    required this.averageMissed,
    required this.averageLowerHub,
    required this.averageUpperHub,
    required this.notes,
  });
}

class TeamTeleop {
  final Stat<int> score;
  final List<String> anchorPoints;
  final double averagePickedTerminal;
  final double averagePickedFloor;
  final double averageMissed;
  final double averageLowerHub;
  final double averageUpperHub;
  final List<String> notes;

  TeamTeleop({
    required this.score,
    required this.anchorPoints,
    required this.averagePickedTerminal,
    required this.averagePickedFloor,
    required this.averageMissed,
    required this.averageLowerHub,
    required this.averageUpperHub,
    required this.notes,
  });
}

class TeamEndgame {
  final Stat<int> score;
  final List<bool> climbableBars; // For example:  [true, false, false, true]
  final List<double> barDistribution; // For example: [10%, 35%, 25%, 30%]
  final Stat<double> time;
  final List<String> notes;

  TeamEndgame({
    required this.score,
    required this.climbableBars,
    required this.barDistribution,
    required this.time,
    required this.notes,
  });
}
