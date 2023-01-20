import 'package:hamosad_analytics_app/src/models.dart';

Future<void> getData() {
  return Future.delayed(const Duration(milliseconds: 1000));
}

List<Team> getTeams() {
  return [
    Team.defaults(number: 1657, name: 'Hamosad'),
    Team.defaults(number: 3075, name: 'Ha-Dream'),
    Team.defaults(number: 5951, name: 'MA'),
    Team.defaults(number: 1580, name: 'Blue Monkeys'),
    Team.defaults(number: 1690, name: 'Orbit'),
    Team.defaults(number: 1574, name: 'MisCar'),
  ];
}

List<int> getRanks() {
  return [
    1580,
    5951,
    1574,
    1690,
    1657,
    3075,
  ];
}
