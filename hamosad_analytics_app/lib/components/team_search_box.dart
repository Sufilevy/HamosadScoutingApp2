import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/components/search_box.dart';

import '../models/team.dart';

class TeamSearchBox extends StatelessWidget {
  const TeamSearchBox({
    required this.teams,
    required this.onChange,
    required this.inputController,
  });

  final List<Team> teams;
  final Function(Team) onChange;
  final TextEditingController inputController;


  @override
  Widget build(BuildContext context){
    return SearchBox<Team>(
      items: teams,
      onChange: onChange, 
      hintText: 'Choose team',
      itemDisplay: (Team team) => '${team.number} ${team.name}', 
      inputController: inputController,  
      suggestionsFilter: (String search) => teams.where((team) => '${team.number} ${team.name}'.toLowerCase().contains(search.toLowerCase())).toList()
    );
  }
}