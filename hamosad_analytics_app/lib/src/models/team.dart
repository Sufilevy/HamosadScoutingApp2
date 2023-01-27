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

  Team.only({
    int number = 1657,
    String name = 'Hamosad',
    TeamInfo? info,
    TeamAutonomus? autonomus,
    TeamTeleop? teleop,
    TeamEndgame? endgame,
  })  : info = info ?? TeamInfo.defaults(number: number, name: name),
        autonomus = autonomus ?? TeamAutonomus.defaults(),
        teleop = teleop ?? TeamTeleop.defaults(),
        endgame = endgame ?? TeamEndgame.defaults();

  @override
  bool operator ==(Object other) {
    if (other is Team) {
      return info.number == other.info.number;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => info.number.hashCode;
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

  TeamInfo.only({
    required this.number,
    required this.name,
    int? won,
    int? lost,
    Stat<int>? score,
    Stat<int>? focus,
    Stat<int>? cones,
    Stat<int>? cubes,
  })  : won = won ?? 0,
        lost = lost ?? 0,
        score = score ?? Stat.zero(),
        focus = focus ?? Stat.zero(),
        cones = cones ?? Stat.zero(),
        cubes = cubes ?? Stat.zero();

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

  TeamAutonomus.only({
    Stat<int>? score,
    Stat<int>? cones,
    Stat<int>? cubes,
    double? climbRate,
    List<String>? notes,
  })  : score = score ?? Stat.zero(),
        cones = cones ?? Stat.zero(),
        cubes = cubes ?? Stat.zero(),
        climbRate = climbRate ?? 0.0,
        notes = notes ?? [];
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

  TeamTeleop.only({
    Stat<int>? score,
    Stat<int>? cones,
    Stat<int>? cubes,
    double? climbRate,
    List<String>? notes,
  })  : score = score ?? Stat.zero(),
        cones = cones ?? Stat.zero(),
        cubes = cubes ?? Stat.zero(),
        notes = notes ?? [];
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

  TeamEndgame.only({
    Stat<int>? score,
    Stat<int>? cones,
    Stat<int>? cubes,
    double? climbRate,
    List<String>? notes,
  })  : score = score ?? Stat.zero(),
        cones = cones ?? Stat.zero(),
        cubes = cubes ?? Stat.zero(),
        climbRate = climbRate ?? 0.0,
        notes = notes ?? [];
}
