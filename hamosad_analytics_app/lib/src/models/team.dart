import 'package:hamosad_analytics_app/src/models.dart';

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
  final int won, lost;
  final Stat<int> score, focus;

  TeamInfo({
    required this.number,
    required this.name,
    required this.won,
    required this.lost,
    required this.score,
    required this.focus,
  });
}

class TeamAutonomus {
  final Stat<int> score;
  final List<String> notes;

  TeamAutonomus({
    required this.score,
    required this.notes,
  });
}

class TeamTeleop {
  final Stat<int> score;
  final List<String> notes;

  TeamTeleop({
    required this.score,
    required this.notes,
  });
}

class TeamEndgame {
  final Stat<int> score;
  final List<String> notes;

  TeamEndgame({
    required this.score,
    required this.notes,
  });
}
