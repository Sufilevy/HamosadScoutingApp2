import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:xcontext/material.dart';

class ScoutingHomePage extends StatelessWidget {
  final String title;
  final double size;

  const ScoutingHomePage({
    Key? key,
    required this.title,
    this.size = 1.0,
  }) : super(key: key);

  void _createReport(BuildContext context) {
    ReportDataProvider reportData = reportDataProvider(context);
    if (reportData.reporterName.data.isEmpty ||
        reportData.reporterName.data.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const ScoutingAlertDialog(
          titleIcon: Icons.warning_rounded,
          iconColor: Colors.yellow,
          content: 'Please enter your name and team number.',
        ),
      );
    } else {
      Navigator.pushNamed(context, '/game-report');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 24 * size,
              color: context.theme.textTheme.bodySmall?.color,
            ),
          ),
        ),
        body: ScoutingReportTab(
          title: title,
          children: [
            ScoutingTextField(
              size: size,
              cubit: reportDataProvider(context).reporterName,
              hint: 'Enter your name...',
              title: 'Name',
            ),
            ScoutingTextField(
              size: size,
              cubit: reportDataProvider(context).teamNumber,
              hint: 'Enter your team number...',
              title: 'Team Number',
              onlyNumbers: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: 200 * size),
              child: ScoutingIconButton(
                size: size,
                icon: Icons.add_box_outlined,
                iconSize: 200,
                tooltip: 'Create a new report',
                onPressed: () => _createReport(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
