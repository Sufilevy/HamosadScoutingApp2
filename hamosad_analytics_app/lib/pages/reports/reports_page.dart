import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/widgets/scaffold.dart';
import 'report_view/report_view.dart';
import 'select_report/select_report_view.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key, this.reportId});

  final String? reportId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AnalyticsAppBar(title: _pageTitle()),
      drawer: const AnalyticsDrawer(),
      body: reportId != null ? ReportView(reportId!) : const SelectReportView(),
    );
  }

  String _pageTitle() {
    if (reportId == null) return 'Reports';

    var parts = reportId!.split('-');
    final game = 'Game ${parts[0]}';
    final name = parts[1].splitMapJoin(
      '_',
      onMatch: (_) => ' ',
      onNonMatch: (name) => name.capitalize(),
    );
    final dateTime = '${parts[2]}, ${parts[3]}';

    return '$game - $name ($dateTime)';
  }
}
