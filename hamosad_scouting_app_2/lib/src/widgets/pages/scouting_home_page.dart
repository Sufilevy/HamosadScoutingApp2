import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';
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
      Navigator.pushNamed(context,
          '/${reportDataProvider(context).reportType.data.name}-report');
    }
  }

  Widget _reportTypeSwitch(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0 * size),
          child: const ScoutingText(text: 'Report type:'),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8.0 * size,
            bottom: 8.0 * size,
          ),
          child: ToggleSwitch(
            cornerRadius: 10.0 * size,
            inactiveBgColor: context.theme.backgroundColor.lighten(),
            inactiveFgColor: context.theme.textTheme.bodySmall?.color?.darken(),
            activeBgColors: [
              [const Color(0xFF1E88E5).darken()],
              [const Color(0xFFC62828).darken()],
            ],
            activeFgColor: const Color.fromARGB(255, 213, 231, 226),
            initialLabelIndex: 0,
            totalSwitches: 2,
            labels: const ['Game', 'Pit'],
            fontSize: 22 * size,
            minWidth: 100 * size,
            animate: true,
            curve: Curves.easeOutQuint,
            onToggle: (index) {
              reportDataProvider(context).reportType.data =
                  ReportType.values[index ?? 0];
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 24 * size,
              color: context.theme.textTheme.bodySmall?.color,
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: context.theme.backgroundColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0 * size),
                  child: ScoutingImage(
                    path: 'assets/images/hamosad_logo.png',
                  ),
                ),
              ),
              _reportTypeSwitch(context),
              const Divider(),
            ],
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
                iconSize: 200 * size,
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
