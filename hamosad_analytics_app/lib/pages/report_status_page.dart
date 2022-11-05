import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/pages/report_details_page.dart';

import '../Constants.dart';
import '../components/app_page.dart';
import '../components/rounded_section.dart';
import '../models/report.dart';

class ReportStatusPage extends StatefulWidget {
  const ReportStatusPage({ Key? key }) : super(key: key);

  @override
  _ReportStatusPageState createState() => _ReportStatusPageState();
}

class _ReportStatusPageState extends State<ReportStatusPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppBar(
        title: const Text('Report Status'),
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
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: ListView(
          children: [
            match(
              name: 'Match 7',
              reports: [
                Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                Report(match: '7', scouter: 'liad inon', teamNumber: 5),
              ]
            )
          ],
        ),
      ),
    );
  }

  Widget match({required List<Report> reports, required String name}) => RoundedSection(
    child: Column(
      children: [
        Container(
          color: Consts.primaryDisplayColor,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: Text(
            name, 
            style: const TextStyle(
              color: Consts.sectionDefultColor,
              fontSize: 20
            )
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(
            children: List<Widget>.generate(
              reports.length, 
              (index) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Consts.primaryDisplayColor)
                  ),
                  child: Text(
                    '${reports[index].teamNumber} - ${reports[index].scouter}',
                    style: const TextStyle(
                      color: Consts.sectionDefultColor,
                      fontSize: 18
                    )
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReportDetailsPage(initReport: reports[index])
                    ));
                  },
                ),
              )
              )
          ),
        )
      ],
    ),
  );
}