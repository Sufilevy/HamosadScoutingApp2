import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:hamosad_scouting_app_2/src/widgets/scouting_widgets/scouting_pickups.dart';

Widget gameReport(BuildContext context, double size) {
  final report = reportDataProvider(context);
  final gameReport = report.gameReport;
  return ScoutingReportPage(
    size: size,
    title: 'Game Report',
    tabs: [
      ScoutingReportTab(
        size: size,
        title: 'Info',
        children: [
          ScoutingMatchAndTeam(
            matches: ScoutingDatabase.matches,
            match: report.match,
            team: report.teamNumber,
          ),
        ],
      ),
      ScoutingReportTab(
        size: size,
        title: 'Auto',
        children: [
          ScoutingToggleButton(
            size: size,
            cubit: gameReport.auto.leftCommunity,
            title: 'Did the robot leave the community?',
          ),
          ScoutingPickups(
            size: size,
            cubit: gameReport.auto.pickups,
            onlyFloor: true,
          ),
          ScoutingDropoffs(
            size: size,
            cubit: gameReport.auto.dropoffs,
            isAuto: true,
          ),
          ScoutingCounter(
            size: size,
            cubit: gameReport.auto.chargeStationPasses,
            min: 0,
            max: 99,
            step: 1,
            initial: 0,
            title: 'Charge Station\npasses',
          ),
          ScoutingClimb(
            size: size,
            includeDuration: false,
            cubit: gameReport.auto.climb,
          ),
          ScoutingNotes(
            size: size,
            cubit: gameReport.auto.notes,
          ),
        ],
      ),
      ScoutingReportTab(
        size: size,
        title: 'Teleop',
        children: [
          ScoutingPickups(
            size: size,
            cubit: gameReport.teleop.pickups,
          ),
          ScoutingDropoffs(
            size: size,
            cubit: gameReport.teleop.dropoffs,
          ),
          ScoutingCounter(
            size: size,
            cubit: gameReport.teleop.chargeStationPasses,
            min: 0,
            initial: 0,
            max: 99,
            step: 1,
            title: 'Charge Station\npasses',
          ),
          ScoutingNotes(
            size: size,
            cubit: gameReport.teleop.notes,
          ),
        ],
      ),
      ScoutingReportTab(
        size: size,
        title: 'Endgame',
        children: [
          ScoutingPickups(
            size: size,
            cubit: gameReport.endgame.pickups,
          ),
          ScoutingDropoffs(
            size: size,
            cubit: gameReport.endgame.dropoffs,
          ),
          ScoutingCounter(
            size: size,
            cubit: gameReport.endgame.chargeStationPasses,
            min: 0,
            max: 99,
            step: 1,
            initial: 0,
            title: 'Charge Station\npasses',
          ),
          ScoutingClimb(
            size: size,
            cubit: gameReport.endgame.climb,
          ),
          ScoutingNotes(
            size: size,
            cubit: gameReport.endgame.notes,
          ),
        ],
      ),
      ScoutingReportTab(
        title: 'Summary',
        children: [
          ScoutingToggleButton(
            size: size,
            cubit: gameReport.summary.won,
            title: 'Did the robot\'s alliance win?',
          ),
          ScoutingDefenceFocus(
            size: size,
            onChanged: (index) => gameReport.summary.defenceFocus.data =
                DefenceFocus.values[index],
          ),
          ScoutingNotes(
            size: size,
            cubit: gameReport.summary.notes,
          ),
          ScoutingNotes(
            size: size,
            cubit: gameReport.summary.fouls,
            title: 'Fouls',
            hint: 'Enter the team\'s fouls...',
          ),
          ScoutingNotes(
            size: size,
            cubit: gameReport.summary.defenceNotes,
            title: 'Defence Notes',
            hint: 'Enter your defence notes...',
          ),
        ],
      ),
    ],
  );
}
