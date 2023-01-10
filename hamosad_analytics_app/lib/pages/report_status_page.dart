import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components.dart';
import 'package:hamosad_analytics_app/constants.dart';
import 'package:hamosad_analytics_app/models.dart';
import 'package:hamosad_analytics_app/pages.dart';

class ReportStatusPage extends StatefulWidget {
  const ReportStatusPage({Key? key}) : super(key: key);

  @override
  State<ReportStatusPage> createState() => _ReportStatusPageState();
}

class _ReportStatusPageState extends State<ReportStatusPage> {
  @override
  Widget build(BuildContext context) {
    return AppPage(
        appBar: AppBar(title: const Text('Report Status'), 
        actions: const [AppbarBackButton()]
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: ListView(
          children: [
            match(
              name: 'Match 7',
              reports: [
                const Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                const Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                const Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                const Report(match: '7', scouter: 'liad inon', teamNumber: 5),
                const Report(match: '7', scouter: 'liad inon', teamNumber: 5),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget match({required List<Report> reports, required String name}) =>
      RoundedSection(
        child: Column(
          children: [
            Container(
              color: Consts.primaryDisplayColor,
              width: double.maxFinite,
              alignment: Alignment.center,
              child: Text(
                name,
                style: const TextStyle(
                    color: Consts.sectionDefultColor, fontSize: 20),
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
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Consts.primaryDisplayColor)),
                      child: Text(
                          '${reports[index].teamNumber} - ${reports[index].scouter}',
                          style: const TextStyle(
                              color: Consts.sectionDefultColor, fontSize: 18)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ReportDetailsPage(initReport: reports[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
