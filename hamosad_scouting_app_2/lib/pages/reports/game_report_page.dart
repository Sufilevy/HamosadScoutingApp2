import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_scouting_app_2/widgets/paddings.dart';
import 'package:hamosad_scouting_app_2/widgets/text.dart';

import '/models/game_report/game_report.dart';
import '/models/game_report/summary.dart';
import '/pages/reports/report_page.dart';
import '/services/database.dart';
import '/theme.dart';
import 'widgets/report_tab.dart';
import 'widgets/scouting/scouting_match_and_team.dart';
import 'widgets/scouting/text/notes.dart';
import 'widgets/scouting/toggle/switch.dart';
import 'widgets/scouting/toggle/toggle_button.dart';

class GameReportPage extends ConsumerWidget {
  const GameReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.read(gameReportProvider);

    return ReportPage(
      title: 'Game Report',
      tabs: [
        ReportTab(
          title: 'Info',
          children: <Widget>[
            ScoutingMatchAndTeam(
              match: report.match,
              team: report.teamNumber,
              isRematch: report.isRematch,
              matches: ScoutingDatabase.matches,
            ),
          ],
        ),
        ReportTab(
          title: 'Auto',
          children: <Widget>[
            ScoutingNotes(
              cubit: report.auto.notes,
            ),
          ],
        ),
        ReportTab(
          title: 'Teleop',
          children: <Widget>[
            ScoutingNotes(
              cubit: report.teleop.notes,
            ),
          ],
        ),
        ReportTab(
          title: 'Endgame',
          children: <Widget>[
            ScoutingNotes(
              cubit: report.endgame.notes,
            ),
          ],
        ),
        ReportTab(
          title: 'Summary',
          children: <Widget>[
            ScoutingToggleButton(
              cubit: report.summary.won,
              title: "Did the robot's alliance win?",
            ),
            Column(
              children: [
                ScoutingText.subtitle('How much did the robot focus on defense?').padBottom(16),
                ScoutingSwitch(
                  items: const ['None', 'Half', 'Almost only'],
                  customWidths: [
                    200 * ScoutingTheme.appSizeRatio,
                    200 * ScoutingTheme.appSizeRatio,
                    350 * ScoutingTheme.appSizeRatio,
                  ],
                  onChanged: (index) => report.summary.defenseFocus.data =
                      index == null ? null : DefenseFocus.values[index],
                ),
              ],
            ),
            ScoutingNotes(
              cubit: report.summary.notes,
            ),
            ScoutingNotes(
              cubit: report.summary.fouls,
              title: 'Fouls',
              hint: "Enter the team's fouls...",
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
}
