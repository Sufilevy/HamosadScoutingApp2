import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/models/game_report/game_report.dart';
import '/services/database.dart';
import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/buttons.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'report_tab.dart';

class ReportPage extends ConsumerWidget {
  final String title;
  final List<ReportTab> tabs;

  const ReportPage({
    super.key,
    required this.title,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.read(gameReportProvider);

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
                      child:
                          ScoutingText.navigation(title, fontSize: 32 * ScoutingTheme.appSizeRatio),
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
        report.data,
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
