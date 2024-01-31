import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/models/game_report/game_report.dart';
import '/models/game_report/summary.dart';
import '/services/database.dart';
import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/buttons.dart';
import '/widgets/paddings.dart';
import '/widgets/scouting/crescendo/center_line_pickups.dart';
import '/widgets/scouting/crescendo/climb.dart';
import '/widgets/scouting/crescendo/mic_scores.dart';
import '/widgets/scouting/number/counter.dart';
import '/widgets/scouting/report_tab.dart';
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

    return GameReportScaffold(
      report: report,
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
                hint: 'תארו את המיקום...',
                textDirection: TextDirection.rtl,
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

class GameReportScaffold extends ConsumerWidget {
  const GameReportScaffold({
    super.key,
    required this.tabs,
    required this.report,
  });

  final List<ReportTab> tabs;
  final GameReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ScoutingTheme.background1,
          appBar: AppBar(
            toolbarHeight: 80 * ScoutingTheme.appSizeRatio,
            backgroundColor: ScoutingTheme.background2,
            title: pad(
              top: 16,
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildCloseButton(context, report).padLeft(8),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: ScoutingText.navigation(
                        'Game Report',
                        fontSize: 32 * ScoutingTheme.appSizeRatio,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildSendButton(context, report).padRight(8),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              indicatorWeight: 2.5 * ScoutingTheme.appSizeRatio,
              indicatorColor: ScoutingTheme.primary,
              labelPadding: EdgeInsets.symmetric(horizontal: 24 * ScoutingTheme.appSizeRatio),
              labelColor: ScoutingTheme.foreground1,
              unselectedLabelColor: ScoutingTheme.foreground2,
              labelStyle: ScoutingTheme.navigationStyle.copyWith(fontSize: 16),
              tabs: [
                for (final tab in tabs)
                  Tab(
                    text: tab.title,
                    height: 52 * ScoutingTheme.appSizeRatio,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: tabs,
          ),
        ),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context, GameReport report) {
    return ScoutingIconButton(
      icon: Icons.send_rounded,
      iconSize: 36,
      color: ScoutingTheme.blueAlliance,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String? content;

            if (report.match.data.isNullOrEmpty || report.teamNumber.data.isNullOrEmpty) {
              content = 'Please fill the match and team number.';
            }

            if (content == null) {
              return _buildSendReportDialog(context, report);
            } else {
              return ScoutingDialog(
                content: content,
                title: 'Incomplete report',
                iconColor: ScoutingTheme.warning,
                titleIcon: Icons.warning_rounded,
              );
            }
          },
        );
      },
    );
  }

  Widget _buildSendReportDialog(BuildContext context, report) {
    return ScoutingDialog(
      content:
          'Sending the report will upload it to the database and bring you back to the home screen.',
      title: 'Send Report?',
      titleIcon: Icons.send_rounded,
      iconColor: ScoutingTheme.blueAlliance,
      okButton: false,
      actions: [
        padAll(
          8,
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: ScoutingText.title('Cancel', color: ScoutingTheme.primary).padAll(4),
          ),
        ),
        padAll(
          8,
          TextButton(
            onPressed: () => _sendReport(context, report),
            child: ScoutingText.title(
              'Send',
              color: ScoutingTheme.blueAlliance,
              fontWeight: FontWeight.bold,
            ).padAll(4),
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context, GameReport report) {
    return ScoutingIconButton(
      icon: Icons.close_rounded,
      iconSize: 44,
      color: ScoutingTheme.foreground2,
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => _buildCloseReportDialog(context, report),
        );
      },
    );
  }

  Widget _buildCloseReportDialog(BuildContext context, GameReport report) {
    return ScoutingDialog(
      content: 'Closing the report will delete all of the information entered.',
      title: 'Warning!',
      titleIcon: Icons.dangerous_rounded,
      iconColor: ScoutingTheme.error,
      okButton: false,
      actions: [
        padAll(
          8,
          TextButton(
            onPressed: () {
              report.clear();
              context.go('/');
            },
            child: ScoutingText.title(
              'Delete',
              color: ScoutingTheme.error,
              fontWeight: FontWeight.bold,
            ).padAll(4),
          ),
        ),
        padAll(
          8,
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: ScoutingText.title('Cancel', color: ScoutingTheme.primary).padAll(4),
          ),
        ),
      ],
    );
  }

  void _sendReport(BuildContext context, GameReport report) async {
    try {
      ScoutingDatabase.sendReport(
        report,
        isRematch: report.isRematch.data,
      ).then(
        (_) {
          report.clear();
          context.go('/');
        },
      );
    } catch (e) {
      context.go('/');
      showWarningSnackBar(context, 'Failed to send report. ($e)');
    }
  }
}
