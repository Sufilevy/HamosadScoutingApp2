import 'package:flutter/material.dart';

import '../components/app_page.dart';
import '../components/report_search_box.dart';
import '../models/report.dart';

class ReportDetailsPage extends StatefulWidget {
  const ReportDetailsPage({
    super.key, 
    this.initReport
  });

  final Report? initReport;

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  TextEditingController reportSelectionCntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Report? selectedReport = widget.initReport;
    if (selectedReport != null) {
      reportSelectionCntroller.text = '${selectedReport.teamNumber} - ${selectedReport.match} - ${selectedReport.scouter}';
    }

    return AppPage(
      appBar: AppBar(
        title: const Text('Report Details'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          )
        ]
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Column(
          children: [
            ReportSearchBox(
              reports: [Report(teamNumber: 6740, scouter: 'liad inon', match: '1'), Report(teamNumber: 6740, scouter: 'amir', match: '1')], 
              onChange: (Report newTeam){
                selectedReport = newTeam;
              }, 
              inputController: reportSelectionCntroller
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
