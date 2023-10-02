import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/models/report.dart';
import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/icon_button.dart';
import '/widgets/image.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'reports/widgets/report_tab.dart';
import 'reports/widgets/scouting/text/text_field.dart';

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
                FontAwesomeIcons.circleInfo,
                size: 32.0 * ScoutingTheme.appSizeRatio,
                color: ScoutingTheme.primaryVariant,
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
                ScoutingTextField(
                  cubit: reportData.scouterTeamNumber,
                  hint: 'Enter your team number...',
                  title: 'Team Number',
                  onlyNumbers: true,
                ).padSymmetric(vertical: 20.0),
              ],
            ),
            ScoutingIconButton(
              icon: FontAwesomeIcons.squarePlus,
              iconSize: 250.0 * ScoutingTheme.appSizeRatio,
              splashRadius: 160.0 * ScoutingTheme.appSizeRatio,
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
          ScoutingImage(path: 'assets/images/hamosad_logo.png').padLTRB(40.0, 20.0, 40.0, 30.0),
          ScoutingText.navigation(
            'In association with:',
            fontSize: 36.0 * ScoutingTheme.appSizeRatio,
          ),
          const Expanded(
            child: Column(
              children: [],
            ),
          ),
          padBottom(
            20.0,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScoutingText.navigation(
                  'Made with',
                  fontSize: 24.0 * ScoutingTheme.appSizeRatio,
                ).padRight(10.0),
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
