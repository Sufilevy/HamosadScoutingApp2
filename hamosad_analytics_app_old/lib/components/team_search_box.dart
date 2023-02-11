import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components.dart';
import 'package:hamosad_analytics_app/models.dart';

class TeamSearchBox extends StatelessWidget {
  const TeamSearchBox({
    Key? key,
    required this.teams,
    required this.onChange,
    required this.inputController,
  }) : super(key: key);

  final List<Team> teams;
  final Function(Team) onChange;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return SearchBox<Team>(
      items: teams,
      onChange: onChange,
      hintText: 'Choose team',
      itemDisplay: (Team team) => '${team.info.number} ${team.info.name}',
      inputController: inputController,
      suggestionsFilter: (String search) => teams
          .where(
            (team) => '${team.info.number} ${team.info.name}'
                .toLowerCase()
                .contains(search.toLowerCase()),
          )
          .toList(),
    );
  }
}
