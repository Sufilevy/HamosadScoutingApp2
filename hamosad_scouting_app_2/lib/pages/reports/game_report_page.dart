import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/game_report/game_report.dart';
import '/models/game_report/summary.dart';
import '/pages/reports/widgets/scouting/crescendo/climb.dart';
import '/services/database.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'report_page.dart';
import 'widgets/report_tab.dart';
import 'widgets/scouting/crescendo/center_line_pickups.dart';
import 'widgets/scouting/crescendo/mic_scores.dart';
import 'widgets/scouting/number/counter.dart';
import 'widgets/scouting/scouting_match_and_team.dart';
import 'widgets/scouting/text/notes.dart';
import 'widgets/scouting/text/text_field.dart';
import 'widgets/scouting/toggle/switch.dart';
import 'widgets/scouting/toggle/toggle_button.dart';

class GameReportPage extends ConsumerWidget {
  const GameReportPage({super.key});

  Widget column(List<Widget> children) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children
            .mapIndexed(
              (index, child) => index == 0 ? child : child.padTop(24),
            )
            .toList(),
      );

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
            column([
              ScoutingCounter(cubit: report.auto.speakerScores, title: 'Speaker Scores'),
              ScoutingCounter(cubit: report.auto.speakerMisses, title: 'Speaker Misses'),
            ]),
            column([
              ScoutingCounter(cubit: report.auto.ampScores, title: 'Amp Scores'),
              ScoutingCounter(cubit: report.auto.ampMisses, title: 'Amp Misses'),
            ]),
            ScoutingCenterLinePickups(cubit: report.auto.centerLinePickups),
            ScoutingNotes(cubit: report.auto.notes),
          ],
        ),
        ReportTab(
          title: 'Teleop',
          children: <Widget>[
            column([
              ScoutingCounter(cubit: report.teleop.speakerScores, title: 'Speaker Scores'),
              ScoutingCounter(cubit: report.teleop.speakerMisses, title: 'Speaker Misses'),
            ]),
            column([
              ScoutingCounter(cubit: report.teleop.ampScores, title: 'Amp Scores'),
              ScoutingCounter(cubit: report.teleop.ampMisses, title: 'Amp Misses'),
            ]),
            column([
              ScoutingCounter(cubit: report.teleop.trapScores, title: 'Trap Scores'),
              ScoutingToggleButton(
                cubit: report.teleop.trapFromFloor,
                title: 'Robot scores TRAP from the floor',
              ),
            ]),
            ScoutingClimb(cubit: report.teleop.climb, harmonyCubit: report.teleop.harmony),
            ScoutingMicScores(
              cubit: report.teleop.micScores,
              humanPlayerCubit: report.teleop.isHumanPlayerFromTeam,
            ),
            ScoutingNotes(cubit: report.teleop.notes),
          ],
        ),
        ReportTab(
          title: 'Summary',
          children: <Widget>[
            column([
              ScoutingToggleButton(cubit: report.summary.won, title: "Robot's alliance won"),
              ScoutingText.subtitle('How much did the robot focus on defense?').padTop(12),
              ScoutingSwitch(
                items: const ['None', 'Half', 'Almost Only'],
                customWidths: [
                  200 * ScoutingTheme.appSizeRatio,
                  200 * ScoutingTheme.appSizeRatio,
                  350 * ScoutingTheme.appSizeRatio,
                ],
                onChanged: (index) {
                  report.summary.defenseFocus.data =
                      index == null ? DefenseFocus.defaultValue : DefenseFocus.values[index];
                },
              ),
            ]),
            column([
              ScoutingToggleButton(
                cubit: report.summary.canIntakeFromFloor,
                title: 'Robot can intake from floor',
              ),
              ScoutingText.body('If the robot can only shoot from one location, describe it here.')
                  .padTop(12),
              ScoutingTextField(
                cubit: report.summary.pinnedShooterLocation,
                hint: 'Describe the location...',
                title: 'Location',
                canBeEmpty: true,
              ),
            ]),
            ScoutingNotes(cubit: report.summary.notes),
          ],
        ),
      ],
    );
  }
}
