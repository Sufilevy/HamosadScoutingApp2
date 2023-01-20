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
  final Stat<int> cones, cubes;

  TeamInfo({
    required this.number,
    required this.name,
    required this.won,
    required this.lost,
    required this.score,
    required this.focus,
    required this.cones,
    required this.cubes,
  });

  TeamInfo.defaults({required this.number, required this.name})
      : won = 0,
        lost = 0,
        score = Stat.zero(),
        focus = Stat.zero(),
        cones = Stat.zero(),
        cubes = Stat.zero();

  double get winRate {
    if (won == 0) {
      return 0;
    } else if (lost == 0) {
      return 1;
    } else {
      return won / lost;
    }
  }
}

class TeamAutonomus {
  final Stat<int> score;
  final Stat<int> cones, cubes;
  final double climbRate;
  final List<String> notes;

  TeamAutonomus({
    required this.score,
    required this.cones,
    required this.cubes,
    required this.climbRate,
    required this.notes,
  });

  TeamAutonomus.defaults()
      : score = Stat.zero(),
        cones = Stat.zero(),
        cubes = Stat.zero(),
        climbRate = 0.0,
        notes = [];
}

class TeamTeleop {
  final Stat<int> score;
  final Stat<int> cones, cubes;
  final List<String> notes;

  TeamTeleop({
    required this.score,
    required this.cones,
    required this.cubes,
    required this.notes,
  });

  TeamTeleop.defaults()
      : score = Stat.zero(),
        cones = Stat.zero(),
        cubes = Stat.zero(),
        notes = [];
}

class TeamEndgame {
  final Stat<int> score;
  final Stat<int> cones, cubes;
  final double climbRate;
  final List<String> notes;

  TeamEndgame({
    required this.score,
    required this.cones,
    required this.cubes,
    required this.climbRate,
    required this.notes,
  });

  TeamEndgame.defaults()
      : score = Stat.zero(),
        cones = Stat.zero(),
        cubes = Stat.zero(),
        climbRate = 0.0,
        notes = [];
}
