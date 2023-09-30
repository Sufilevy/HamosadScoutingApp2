import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/models/report.dart';
import 'package:hamosad_scouting_app_2/pages/reports/report_tab.dart';
import 'package:hamosad_scouting_app_2/pages/reports/scouting_widgets/scouting_text_field.dart';
import 'package:hamosad_scouting_app_2/theme.dart';
import 'package:hamosad_scouting_app_2/widgets/alerts.dart';
import 'package:hamosad_scouting_app_2/widgets/icon_button.dart';
import 'package:hamosad_scouting_app_2/widgets/image.dart';
import 'package:hamosad_scouting_app_2/widgets/text.dart';

class ScoutingHomePage extends StatelessWidget {
  static final List<String> _allowedTeams = ['1657'];

  const ScoutingHomePage({super.key});

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
          title: ScoutingText.navigation(ScoutingTheme.appTitle),
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
        body: ReportTab(
          title: ScoutingTheme.appTitle,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          ScoutingText.navigation(
            'In association with:',
            fontSize: 36.0 * ScoutingTheme.appSizeRatio,
          ),
          const Expanded(
            child: Column(
              children: [],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0 * ScoutingTheme.appSizeRatio),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0 * ScoutingTheme.appSizeRatio),
                  child: ScoutingText.navigation(
                    'Made with',
                    fontSize: 24.0 * ScoutingTheme.appSizeRatio,
                  ),
                ),
                const FlutterLogo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _createReport(BuildContext context) {
    final reportData = reportDataProvider(context);

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
      Navigator.pushNamed(context, '/game-report');
    }
  }
}
