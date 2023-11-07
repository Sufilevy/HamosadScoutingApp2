import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/input/buttons.dart';
import '/widgets/padding.dart';
import '/widgets/text.dart';

class SelectedTeamsChips extends StatelessWidget {
  const SelectedTeamsChips({super.key, required this.onSelectionChange, this.selectedTeams});

  final List<String>? selectedTeams;
  final void Function(List<String>) onSelectionChange;

  @override
  Widget build(BuildContext context) {
    if (selectedTeams == null) {
      return SizedBox(height: 40 * AnalyticsTheme.appSizeRatio);
    }

    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100 * AnalyticsTheme.appSizeRatio,
        mainAxisExtent: 40 * AnalyticsTheme.appSizeRatio,
        crossAxisSpacing: 5 * AnalyticsTheme.appSizeRatio,
        mainAxisSpacing: 5 * AnalyticsTheme.appSizeRatio,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: selectedTeams!.map(_teamChip).toList(),
    );
  }

  Widget _teamChip(String teamNumber) {
    return Container(
      decoration: BoxDecoration(
        color: AnalyticsTheme.background2,
        borderRadius: BorderRadius.circular(20 * AnalyticsTheme.appSizeRatio),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _teamColorAvatar(teamNumber),
          navigationText(teamNumber, fontSize: 14).padRight(8),
        ],
      ),
    );
  }

  Widget _teamColorAvatar(String teamNumber) {
    final teamColor = TeamInfo.fromNumber(teamNumber).color;

    final iconHoverColor = teamColor.computeLuminance() < 0.3 ? Colors.white : Colors.black87;

    return Container(
      width: 18 * AnalyticsTheme.appSizeRatio,
      height: 18 * AnalyticsTheme.appSizeRatio,
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: teamColor,
      ),
      child: IconButtonWithHover(
        icon: FontAwesomeIcons.xmark,
        iconSize: 14 * AnalyticsTheme.appSizeRatio,
        iconColor: Colors.transparent,
        iconHoverColor: iconHoverColor,
        onPressed: () {
          onSelectionChange(selectedTeams! - [teamNumber]);
        },
      ),
    );
  }
}
