import "package:flutter/material.dart";
import "package:flutter_typeahead/flutter_typeahead.dart";
import 'package:hamosad_scouting_app_2/constants.dart';

import '../models/team.dart';

class TeamsSelector extends StatelessWidget {
  const TeamsSelector({super.key, 
    required this.teams,
    required this.onChange,
    required this.inputController,
  });

  final List<Team> teams;
  final void Function(Team) onChange;
  final TextEditingController inputController;
  @override
  Widget build(final BuildContext context) {
    return TypeAheadFormField<Team>(
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(Consts.defultBorderRadiusSize),
        color: Consts.sectionDefultColor
      ),
      validator: (final String? value) {
        if (value == "") {
          return "Please pick a team";
        }
        return null;
      },
      textFieldConfiguration: TextFieldConfiguration(
        onSubmitted: (final String number) {
          try {
            final Team team = teams.firstWhere(
              (final Team team) => team.number.toString() == number,
            );
            onChange(team);
            inputController.text = "${team.number} ${team.name}";
          } on StateError catch (_) {
            //ignored
          }
        },
        onTap: inputController.clear,
        controller: inputController,
        style: const TextStyle(
          color: Consts.secondaryDisplayColor,
          fontSize: 24
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Consts.defultBorderRadiusSize),
          ),
          contentPadding: EdgeInsets.zero,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0)
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0)
          ),
          filled: true,
          fillColor: Consts.sectionDefultColor,
          focusColor: Consts.secondaryDisplayColor,
          prefixIcon: const Icon(
            Icons.search, 
            color: Consts.secondaryDisplayColor,
            size: 27,
          ),
          hintText: "Search Team",
          hintStyle: const TextStyle(
            color: Consts.secondaryDisplayColor,
            fontSize: 24
          )
        ),
      ),
      suggestionsCallback: (final String pattern) => teams.where(
        (final Team element) {
          return ('${element.number.toString()} ${element.name.toLowerCase()}').contains(pattern.toLowerCase());
        },
      ).toList()
        ..sort(
          (final Team a, Team b) =>
              a.number.compareTo(b.number),
        ),
      itemBuilder: (final BuildContext context, final Team suggestion) =>
          ListTile(title: Text(
            "${suggestion.number} ${suggestion.name}",
            style: const TextStyle(color: Consts.secondaryDisplayColor),
          )),
      transitionBuilder: (
        final BuildContext context,
        final Widget suggestionsBox,
        final AnimationController? controller,
      ) {
        return FadeTransition(
          child: suggestionsBox,
          opacity: CurvedAnimation(
            parent: controller!,
            curve: Curves.fastOutSlowIn,
          ),
        );
      },
      noItemsFoundBuilder: (final BuildContext context) => Container(
        height: 60,
        child: const Center(
          child: Text(
            "No Teams Found",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      onSuggestionSelected: (final Team suggestion) {
        inputController.text = "${suggestion.number} ${suggestion.name}";
        onChange(
          teams[teams.indexWhere(
            (final Team team) => team.number == suggestion.number,
          )],
        );
      },
    );
  }
}
