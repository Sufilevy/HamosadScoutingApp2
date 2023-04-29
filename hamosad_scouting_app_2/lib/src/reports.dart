import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/theme.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

Widget gameReport(BuildContext context) {
  final report = reportDataProvider(context);
  final gameReport = report.gameReport;
  return ScoutingReportPage(
    title: 'Game Report',
    tabs: [
      ScoutingReportTab(
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
        title: 'Auto',
        children: [
          ScoutingNotes(
            cubit: gameReport.auto.notes,
          ),
        ],
      ),
      ScoutingReportTab(
        title: 'Teleop',
        children: [
          ScoutingNotes(
            cubit: gameReport.teleop.notes,
          ),
        ],
      ),
      ScoutingReportTab(
        title: 'Endgame',
        children: [
          ScoutingNotes(
            cubit: gameReport.endgame.notes,
          ),
        ],
      ),
      ScoutingReportTab(
        title: 'Summary',
        children: [
          ScoutingToggleButton(
            cubit: gameReport.summary.won,
            title: 'Did the robot\'s alliance win?',
          ),
          ScoutingSwitch(
            items: const ['Almost only', 'Half', 'None'],
            customWidths: [
              200.0 * ScoutingTheme.appSizeRatio,
              150.0 * ScoutingTheme.appSizeRatio,
              150.0 * ScoutingTheme.appSizeRatio,
            ],
            onChanged: (index) => gameReport.summary.defenceFocus.data =
                index == null ? null : DefenceFocus.values[index],
          ),
          ScoutingNotes(
            cubit: gameReport.summary.notes,
          ),
          ScoutingNotes(
            cubit: gameReport.summary.fouls,
            title: 'Fouls',
            hint: 'Enter the team\'s fouls...',
          ),
          ScoutingNotes(
            cubit: gameReport.summary.defenceNotes,
            title: 'Defence Notes',
            hint: 'Enter your defence notes...',
          ),
        ],
      ),
    ],
  );
}
