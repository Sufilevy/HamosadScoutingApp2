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

  Team.defaults({int number = 1657, String name = 'Hamosad'})
      : info = TeamInfo.defaults(number: number, name: name),
        autonomus = TeamAutonomus.defaults(),
        teleop = TeamTeleop.defaults(),
        endgame = TeamEndgame.defaults();
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

  TeamInfo.defaults({required this.number, required this.name})
      : won = 0,
        lost = 0,
        score = Stat.zero(),
        focus = Stat.zero();
}

class TeamAutonomus {
  final Stat<int> score;
  final List<String> notes;

  TeamAutonomus({
    required this.score,
    required this.notes,
  });

  TeamAutonomus.defaults()
      : score = Stat.zero(),
        notes = [];
}

class TeamTeleop {
  final Stat<int> score;
  final List<String> notes;

  TeamTeleop({
    required this.score,
    required this.notes,
  });

  TeamTeleop.defaults()
      : score = Stat.zero(),
        notes = [];
}

class TeamEndgame {
  final Stat<int> score;
  final List<String> notes;

  TeamEndgame({
    required this.score,
    required this.notes,
  });

  TeamEndgame.defaults()
      : score = Stat.zero(),
        notes = [];
}
