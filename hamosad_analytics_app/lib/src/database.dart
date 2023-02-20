import 'package:dartx/dartx.dart';
import 'package:hamosad_analytics_app/src/models.dart';

export 'database/analytics_data.dart';
export 'database/analytics_database.dart';

Future<void> getData() {
  return Future.delayed(1000.milliseconds);
}

final _teams = [
  Team.only(
    info: TeamInfo.only(number: 1657, name: 'Hamosad', won: 4, lost: 1),
  ),
  Team.only(
    info: TeamInfo.only(number: 3075, name: 'Ha-Dream', won: 1, lost: 6),
  ),
  Team.only(
    info: TeamInfo.only(number: 5951, name: 'MA', won: 2, lost: 3),
  ),
  Team.only(
    info: TeamInfo.only(number: 1580, name: 'Blue Monkeys', won: 4, lost: 6),
  ),
  Team.only(
    info: TeamInfo.only(number: 1690, name: 'Orbit', won: 7, lost: 9),
  ),
  Team.only(
    info: TeamInfo.only(number: 1574, name: 'MisCar', won: 2, lost: 3),
  ),
  Team.only(
    info: TeamInfo.only(number: 2212, name: 'Spikes', won: 0, lost: 0),
  ),
];

List<Team> getTeams() {
  return _teams;
}

Map<int, Team> getTeamsMap() {
  return Map.fromEntries(
    _teams.map(
      (team) => MapEntry(team.info.number, team),
    ),
  );
}

List<int> getRanks() {
  return [
    1580,
    5951,
    1574,
    1690,
    1657,
    2212,
    3075,
  ];
}
