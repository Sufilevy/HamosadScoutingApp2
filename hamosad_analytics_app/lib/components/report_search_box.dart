import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components/search_box.dart';
import 'package:hamosad_analytics_app/models/report.dart';

class ReportSearchBox extends StatelessWidget {
  const ReportSearchBox({
    Key? key,
    required this.reports,
    required this.onChange,
    required this.inputController,
  }) : super(key: key);

  final List<Report> reports;
  final Function(Report) onChange;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return SearchBox<Report>(
        items: reports,
        onChange: onChange,
        hintText: 'Choose Report',
        itemDisplay: (Report report) =>
            '${report.teamNumber} - ${report.match} - ${report.scouter}',
        inputController: inputController,
        suggestionsFilter: (String search) => reports
            .where((report) =>
                '${report.teamNumber} ${report.match} ${report.scouter}'
                    .toLowerCase()
                    .contains(search.toLowerCase()))
            .toList());
  }
}
