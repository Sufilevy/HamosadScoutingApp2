import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '/models/game_report/game_report.dart';
import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/buttons.dart';
import '/widgets/image.dart';
import '/widgets/paddings.dart';
import '/widgets/reports/report_tab.dart';
import '/widgets/scouting/text/text_field.dart';
import '/widgets/text.dart';

class HomePage extends ConsumerWidget {
  static final _allowedTeams = ['1657'];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.read(gameReportProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: ScoutingTheme.background1,
        appBar: AppBar(
          backgroundColor: ScoutingTheme.background2,
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: _buildAboutButton(context).padLeft(8),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: ScoutingText.navigation(
                    ScoutingTheme.appTitle,
                    fontSize: 36 * ScoutingTheme.appSizeRatio,
                  ),
                ),
              ),
            ],
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
              iconSize: 250,
              constraints: BoxConstraints.tight(const Size(325, 325) * ScoutingTheme.appSizeRatio),
              tooltip: 'Create a new report',
              onPressed: () => _createReport(context, report),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return ScoutingIconButton(
          icon: FontAwesomeIcons.circleInfo,
          iconSize: 40,
          color: ScoutingTheme.foreground2,
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: 'About',
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: ScoutingTheme.background2,
      surfaceTintColor: Colors.transparent,
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
      context.go('/game-report');
    }
  }
}
