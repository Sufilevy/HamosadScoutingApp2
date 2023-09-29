import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/models/report.dart';
import 'package:hamosad_scouting_app_2/models/summary.dart';
import 'package:hamosad_scouting_app_2/pages/report/report_page.dart';
import 'package:hamosad_scouting_app_2/pages/report/report_tab.dart';
import 'package:hamosad_scouting_app_2/pages/report/scouting_widgets/scouting_match_and_team.dart';
import 'package:hamosad_scouting_app_2/pages/report/scouting_widgets/scouting_notes.dart';
import 'package:hamosad_scouting_app_2/pages/report/scouting_widgets/scouting_switch.dart';
import 'package:hamosad_scouting_app_2/pages/report/scouting_widgets/scouting_toggle_button.dart';
import 'package:hamosad_scouting_app_2/services/database.dart';
import 'package:hamosad_scouting_app_2/theme.dart';

Widget gameReportPage(BuildContext context) {
  final report = reportDataProvider(context);
  return ReportPage(
    title: 'Game Report',
    tabs: [
      ReportTab(
        title: 'Info',
        children: [
          ScoutingMatchAndTeam(
            matches: ScoutingDatabase.matches,
            match: report.match,
            team: report.teamNumber,
          ),
        ],
      ),
      ReportTab(
        title: 'Auto',
        children: [
          ScoutingNotes(
            cubit: report.auto.notes,
          ),
        ],
      ),
      ReportTab(
        title: 'Teleop',
        children: [
          ScoutingNotes(
            cubit: report.teleop.notes,
          ),
        ],
      ),
      ReportTab(
        title: 'Endgame',
        children: [
          ScoutingNotes(
            cubit: report.endgame.notes,
          ),
        ],
      ),
      ReportTab(
        title: 'Summary',
        children: [
          ScoutingToggleButton(
            cubit: report.summary.won,
            title: 'Did the robot\'s alliance win?',
          ),
          ScoutingSwitch(
            items: const ['Almost only', 'Half', 'None'],
            customWidths: [
              200.0 * ScoutingTheme.appSizeRatio,
              150.0 * ScoutingTheme.appSizeRatio,
              150.0 * ScoutingTheme.appSizeRatio,
            ],
            onChanged: (index) => report.summary.defenseFocus.data =
                index == null ? null : DefenseFocus.values[index],
          ),
          ScoutingNotes(
            cubit: report.summary.notes,
          ),
          ScoutingNotes(
            cubit: report.summary.fouls,
            title: 'Fouls',
            hint: 'Enter the team\'s fouls...',
          ),
          ScoutingNotes(
            cubit: report.summary.defenseNotes,
            title: 'Defense Notes',
            hint: 'Enter your defense notes...',
          ),
        ],
      ),
    ],
  );
}
