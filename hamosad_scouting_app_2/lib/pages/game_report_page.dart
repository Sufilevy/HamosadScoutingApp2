import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/game_report/game_report.dart';
import '/models/game_report/summary.dart';
import '/services/database.dart';
import '/theme.dart';
import '/widgets/buttons.dart';
import '/widgets/paddings.dart';
import '/widgets/reports/report_page.dart';
import '/widgets/reports/report_tab.dart';
import '/widgets/scouting/crescendo/center_line_pickups.dart';
import '/widgets/scouting/crescendo/climb.dart';
import '/widgets/scouting/crescendo/mic_scores.dart';
import '/widgets/scouting/number/counter.dart';
import '/widgets/scouting/scouting_match_and_team.dart';
import '/widgets/scouting/text/notes.dart';
import '/widgets/scouting/text/text_field.dart';
import '/widgets/scouting/toggle/switch.dart';
import '/widgets/scouting/toggle/toggle_button.dart';
import '/widgets/text.dart';

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
            column([
              InfoButton(
                widgetName: 'איסוף מקו האמצע באוטונומי',
                description: "תסמנו אילו חלקי משחק הרובוט אסף מקו האמצע במהלך האוטונומי.\n\n"
                    "חלקי המשחק מסודרים בהנחה שהברית האדומה משמאל והכחולה מימין.",
                child: ScoutingText.title('Center Line Auto Pickups'),
              ),
              ScoutingCenterLinePickups(cubit: report.auto.centerLinePickups),
            ]),
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
              ScoutingCounter(cubit: report.teleop.trapScores, title: 'Trap Scores', max: 3),
              InfoButton(
                widgetName: 'טראפ מהרצפה',
                description: "האם הרובוט יכול לקלוע לטראפ מהרצפה (בלי לטפס).\n\n"
                    "אם הרובוט עושה את זה בלי לירות את החלק משחק, תכתבו בהערות איך הוא עושה את זה.",
                child: ScoutingToggleButton(
                  cubit: report.teleop.trapFromFloor,
                  title: 'Robot scores TRAP from the floor',
                ),
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
              ScoutingToggleButton(cubit: report.summary.won, title: "Robot's ALLIANCE won"),
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
              InfoButton(
                widgetName: 'איסוף מהרצפה',
                description: "האם הרובוט יכול לאסוף חלקי משחק מהרצפה.\n\n"
                    "לא משנה אם הוא יכול לאסוף מהפידר או לא.",
                child: ScoutingToggleButton(
                  cubit: report.summary.canIntakeFromFloor,
                  title: 'Robot can intake from floor',
                ),
              ),
              InfoButton(
                widgetName: 'ירי ממיקום ספציפי',
                description: "אם הרובוט צריך להיות במקום ספציפי כדי לקלוע לספיקר, "
                    "תתארו אותו פה הכי טוב שאתם יכולים.\n\n"
                    "לדוגמה, אם הרובוט צריך להיות צמוד לקיר בדיוק מתחת לספיקר, "
                    "תכתבו 'מתחת לספיקר'.",
                topPadding: 12,
                child: ScoutingText.subtitle(
                  'If the robot can only shoot\nfrom one location, describe it here.',
                ).pad(top: 12),
              ),
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
