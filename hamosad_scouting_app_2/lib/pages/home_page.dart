import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/models/game_report/game_report.dart';
import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/icon_button.dart';
import '/widgets/image.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'reports/widgets/report_tab.dart';
import 'reports/widgets/scouting/text/text_field.dart';

class ScoutingHomePage extends ConsumerWidget {
  static final _allowedTeams = ['1657'];

  const ScoutingHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.read(gameReportProvider);

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
                size: 32 * ScoutingTheme.appSizeRatio,
                color: ScoutingTheme.primaryVariant,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
              splashRadius: 25 * ScoutingTheme.appSizeRatio,
              tooltip: 'About',
            ),
          ),
        ),
        drawer: _buildDrawer(),
        body: ReportTab(
          title: ScoutingTheme.appTitle,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ScoutingTextField(
                  cubit: report.scouter,
                  hint: 'Enter your name...',
                  title: 'Name',
                  onlyNames: true,
                ),
                ScoutingTextField(
                  cubit: report.scouterTeamNumber,
                  hint: 'Enter your team number...',
                  title: 'Team Number',
                  onlyNumbers: true,
                ).padSymmetric(vertical: 20),
              ],
            ),
            ScoutingIconButton(
              icon: FontAwesomeIcons.squarePlus,
              iconSize: 250 * ScoutingTheme.appSizeRatio,
              splashRadius: 160 * ScoutingTheme.appSizeRatio,
              tooltip: 'Create a new report',
              onPressed: () => _createReport(context, report),
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
        children: <Widget>[
          ScoutingImage(path: 'assets/images/hamosad_logo.png').padLTRB(40, 20, 40, 30),
          ScoutingText.navigation(
            'In association with:',
            fontSize: 36 * ScoutingTheme.appSizeRatio,
          ),
          const Expanded(
            child: Column(
              children: <Widget>[],
            ),
          ),
          padBottom(
            20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ScoutingText.navigation(
                  'Made with',
                  fontSize: 24 * ScoutingTheme.appSizeRatio,
                ).padRight(10),
                const FlutterLogo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _createReport(BuildContext context, GameReport report) {
    if (report.scouter.data.isEmpty ||
        report.scouterTeamNumber.data.isEmpty ||
        !_allowedTeams.contains(report.scouterTeamNumber.data)) {
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
