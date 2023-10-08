import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/game_report/game_report.dart';
import '/pages/reports/report_page.dart';
import '/pages/reports/widgets/scouting/text/text_field.dart';
import 'widgets/report_tab.dart';

class PitReportPage extends ConsumerWidget {
  const PitReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.read(gameReportProvider);

    return ReportPage(
      title: 'Pit Report',
      tabs: [
        ReportTab(
          title: 'Info',
          children: [
            ScoutingTextField(
              title: 'Team Number',
              hint: "Enter the team's number...",
              cubit: report.scouter,
            ),
          ],
        ),
      ],
    );
  }
}
