import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/models/pit_report.dart';
import '/services/database.dart';
import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/buttons.dart';
import '/widgets/paddings.dart';
import '/widgets/scouting/text/text_field.dart';
import '/widgets/text.dart';

class PitReportPage extends ConsumerWidget {
  const PitReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.read(pitReportProvider);

    return PitReportScaffold(
      report: report,
      body: padSymmetric(
        horizontal: 64,
        vertical: 32,
        ListView(
          children: [
            ScoutingTextField(
              cubit: report.teamNumber,
              title: 'Team Number',
              onlyNumbers: true,
            ).padBottom(32),
            _buildSeparator().padBottom(32),
            ScoutingText.subtitle(
              'Enter general info about the robot.\n'
              'This should include stuff like strengths,\n'
              'flaws, scoring capabilities, general structure...',
            ).padBottom(32),
            ScoutingTextField(
              cubit: report.data,
              title: 'Info',
              minLines: 10,
              maxLines: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      height: 1.5,
      decoration: BoxDecoration(
        color: ScoutingTheme.background3,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

class PitReportScaffold extends ConsumerWidget {
  const PitReportScaffold({
    super.key,
    required this.body,
    required this.report,
  });

  final Widget body;
  final PitReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ScoutingTheme.background1,
        appBar: AppBar(
          toolbarHeight: 100 * ScoutingTheme.appSizeRatio,
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
                      'Pit Report',
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
        ),
        body: body,
      ),
    );
  }

  Widget _buildSendButton(BuildContext context, PitReport report) {
    return ScoutingIconButton(
      icon: Icons.send_rounded,
      iconSize: 36,
      color: ScoutingTheme.blueAlliance,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String? content;

            if (report.teamNumber.data.isNullOrEmpty) {
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

  Widget _buildSendReportDialog(BuildContext context, PitReport report) {
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

  Widget _buildCloseButton(BuildContext context, PitReport report) {
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

  Widget _buildCloseReportDialog(BuildContext context, PitReport report) {
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

  void _sendReport(BuildContext context, PitReport report) async {
    try {
      ScoutingDatabase.sendPitReport(report).then(
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
