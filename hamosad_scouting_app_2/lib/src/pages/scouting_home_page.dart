import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/pages.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/theme.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

class ScoutingHomePage extends StatelessWidget {
  static final List<String> _allowedTeams = ['1657'];

  const ScoutingHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final reportData = reportDataProvider(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ScoutingTheme.background1,
        appBar: AppBar(
          backgroundColor: ScoutingTheme.background2,
          centerTitle: true,
          title: ScoutingText.navigation(title),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.info_outline_rounded,
                size: 35.0 * ScoutingTheme.appSizeRatio,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              splashRadius: 25.0 * ScoutingTheme.appSizeRatio,
              tooltip: 'About',
            ),
          ),
        ),
        drawer: _buildDrawer(),
        body: ScoutingReportTab(
          title: title,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScoutingTextField(
                  cubit: reportData.scouter,
                  hint: 'Enter your name...',
                  title: 'Name',
                  onlyNames: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ScoutingTextField(
                    cubit: reportData.scouterTeamNumber,
                    hint: 'Enter your team number...',
                    title: 'Team Number',
                    onlyNumbers: true,
                  ),
                ),
              ],
            ),
            ScoutingIconButton(
              icon: Icons.add_box_outlined,
              iconSize: 400.0 * ScoutingTheme.appSizeRatio,
              tooltip: 'Create a new report',
              onPressed: () => _createReport(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: ScoutingTheme.background2,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              40.0 * ScoutingTheme.appSizeRatio,
              20.0 * ScoutingTheme.appSizeRatio,
              40.0 * ScoutingTheme.appSizeRatio,
              30.0 * ScoutingTheme.appSizeRatio,
            ),
            child: ScoutingImage(
              path: 'assets/images/hamosad_logo.png',
            ),
          ),
          Center(
            child: ScoutingText.navigation(
              'In association with:',
              fontSize: 36.0 * ScoutingTheme.appSizeRatio,
            ),
          ),
          const Stack(
            children: [],
          ),
        ],
      ),
    );
  }

  void _createReport(BuildContext context) {
    ReportDataProvider reportData = reportDataProvider(context);

    if (reportData.scouter.data.isEmpty ||
        reportData.scouterTeamNumber.data.isEmpty ||
        !_allowedTeams.contains(reportData.scouterTeamNumber.data)) {
      showDialog(
        context: context,
        builder: (context) => ScoutingDialog(
          titleIcon: Icons.warning_rounded,
          iconColor: ScoutingTheme.warning,
          content: 'Please enter your name and team number.\n'
              'Valid teams are: ${_allowedTeams.join(', ')}.',
        ),
      );
    } else {
      Navigator.pushNamed(context, '/report');
    }
  }
}
