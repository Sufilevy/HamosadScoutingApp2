import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';

class SelectTeams extends StatelessWidget {
  const SelectTeams({
    super.key,
    required this.teams,
    required this.onSelectionChange,
    this.selectedTeams,
  });

  final List<String> teams;
  final List<String>? selectedTeams;
  final void Function(List<String>) onSelectionChange;

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.multiple(
      title: 'Select Teams',
      placeholder: '',
      choiceItems: teams.map((team) => S2Choice<String>(title: team, value: team)).toList(),
      selectedChoice: _selectedChoice,
      onChange: (value) {
        onSelectionChange(
          value.choice?.map((selection) => selection.value).toList() ?? [],
        );
      },
      choiceType: S2ChoiceType.switches,
      builder: const S2MultiBuilder(),
    );
  }

  List<S2Choice<String>>? get _selectedChoice =>
      selectedTeams?.map((team) => S2Choice<String>(title: team, value: team)).toList();
}
