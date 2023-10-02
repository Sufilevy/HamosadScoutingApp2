import 'package:flutter/material.dart';

import '/models/report.dart';
import '/models/summary.dart';
import '/pages/reports/report_page.dart';
import '/services/database.dart';
import '/theme.dart';
import 'widgets/report_tab.dart';
import 'widgets/scouting/scouting_match_and_team.dart';
import 'widgets/scouting/text/notes.dart';
import 'widgets/scouting/toggle/switch.dart';
import 'widgets/scouting/toggle/toggle_button.dart';

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
