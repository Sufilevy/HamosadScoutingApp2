import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/services/utilities.dart';
import '/theme.dart';
import '/widgets/input/buttons.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class SelectedTeamsChips extends StatelessWidget {
  const SelectedTeamsChips(
      {super.key, required this.onSelectionChange, required this.selectedTeams});

  final List<String> selectedTeams;
  final void Function(List<String> teams) onSelectionChange;

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100 * AnalyticsTheme.appSizeRatio,
        mainAxisExtent: 40 * AnalyticsTheme.appSizeRatio,
        crossAxisSpacing: 5 * AnalyticsTheme.appSizeRatio,
        mainAxisSpacing: 5 * AnalyticsTheme.appSizeRatio,
      ),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: selectedTeams
          .map(
            (teamNumber) => _TeamChip(
              teamNumber,
              onRemoved: (teamNumber) => onSelectionChange(selectedTeams - [teamNumber]),
            ),
          )
          .toList(),
    );
  }
}

class _TeamChip extends StatefulWidget {
  const _TeamChip(this.teamNumber, {required this.onRemoved});

  final String teamNumber;
  final void Function(String teamNumber) onRemoved;

  @override
  State<_TeamChip> createState() => _TeamChipState();
}

class _TeamChipState extends State<_TeamChip> {
  double _scale = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(10.milliseconds, () => setState(() => _scale = 1));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: 150.milliseconds,
      scale: _scale,
      child: Container(
        decoration: BoxDecoration(
          color: AnalyticsTheme.background2,
          borderRadius: BorderRadius.circular(20 * AnalyticsTheme.appSizeRatio),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _teamColorAvatar(widget.teamNumber),
            navigationText(widget.teamNumber, fontSize: 14).padRight(8),
          ],
        ),
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
          widget.onRemoved(teamNumber);
        },
      ),
    );
  }
}
