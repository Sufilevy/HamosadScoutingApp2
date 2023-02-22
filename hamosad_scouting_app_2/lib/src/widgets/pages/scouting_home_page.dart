import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
        reportData.reporterTeamNumber.data.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const ScoutingAlertDialog(
          titleIcon: Icons.warning_rounded,
          iconColor: ScoutingTheme.warning,
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
          child: ScoutingText.text('Report type:'),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 8.0 * size,
            bottom: 8.0 * size,
          ),
          child: ToggleSwitch(
            cornerRadius: 10.0 * size,
            inactiveBgColor: ScoutingTheme.background3,
            inactiveFgColor: ScoutingTheme.foreground2,
            activeBgColors: const [
              [ScoutingTheme.cones],
              [ScoutingTheme.cubes],
            ],
            activeFgColor: ScoutingTheme.foreground1,
            initialLabelIndex: 0,
            totalSwitches: 2,
            labels: const ['Game', 'Pit'],
            fontSize: 28.0 * size,
            minWidth: 140.0 * size,
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

  Widget _divider() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0 * size),
        child: const Divider(
          thickness: 1.5,
          color: ScoutingTheme.background3,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ScoutingTheme.background1,
        appBar: AppBar(
          backgroundColor: ScoutingTheme.background2,
          centerTitle: true,
          title: ScoutingText.navigation(
            title,
          ),
        ),
        drawer: Drawer(
          backgroundColor: ScoutingTheme.background2,
          child: Center(
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
                _divider(),
                _divider(),
              ],
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
              cubit: reportDataProvider(context).reporterTeamNumber,
              hint: 'Enter your team number...',
              title: 'Team Number',
              onlyNumbers: true,
            ),
            _reportTypeSwitch(context),
            ScoutingIconButton(
              size: size,
              icon: Icons.add_box_outlined,
              iconSize: 400.0 * size,
              tooltip: 'Create a new report',
              onPressed: () => _createReport(context),
            ),
          ],
        ),
      ),
    );
  }
}
