import 'package:flutter/material.dart';

import '../components/app_page.dart';
import '../components/report_search_box.dart';
import '../models/report.dart';

class ReportDetailsPage extends StatefulWidget {
  const ReportDetailsPage({Key? key}) : super(key: key);

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  TextEditingController teamSelectionCntroller = TextEditingController();
  Report? selectedReport;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(title: const Text('Report Details')),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Column(
          children: [
            ReportSearchBox(
                reports: const [
                  Report(teamNumber: 6740, scouter: 'liad inon', match: '1'),
                  Report(teamNumber: 6740, scouter: 'amir', match: '1')
                ],
                onChange: (Report newTeam) {
                  selectedReport = newTeam;
                },
                inputController: teamSelectionCntroller),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
