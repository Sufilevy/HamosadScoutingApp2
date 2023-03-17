import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

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
    if (reportData.scouter.data.isEmpty ||
        reportData.scouterTeamNumber.data.isEmpty ||
        (reportData.scouterTeamNumber.data != '1657' &&
            reportData.scouterTeamNumber.data != '5951')) {
      showDialog(
        context: context,
        builder: (context) => const ScoutingAlertDialog(
          titleIcon: Icons.warning_rounded,
          iconColor: ScoutingTheme.warning,
          content:
              'Please enter your name and team number.\nValid teams are: 1657, 5951',
        ),
      );
    } else {
      Navigator.pushNamed(context, '/report');
    }
  }

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
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  40.0 * size,
                  20.0 * size,
                  40.0 * size,
                  30.0 * size,
                ),
                child: ScoutingImage(
                  path: 'assets/images/hamosad_logo.png',
                ),
              ),
              Center(
                child: ScoutingText.navigation(
                  'In association with:',
                  fontSize: 36.0 * size,
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 60.0 * size,
                    ),
                    child: ScoutingImage(
                      path: 'assets/images/ma_logo.png',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 60.0 * size,
                      right: 60.0 * size,
                      top: 210.0 * size,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/black_unicorns_logo.svg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: ScoutingReportTab(
          title: title,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ScoutingTextField(
                  size: size,
                  cubit: reportDataProvider(context).scouter,
                  hint: 'Enter your name...',
                  title: 'Name',
                  onlyNames: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ScoutingTextField(
                    size: size,
                    cubit: reportDataProvider(context).scouterTeamNumber,
                    hint: 'Enter your team number...',
                    title: 'Team Number',
                    onlyNumbers: true,
                  ),
                ),
              ],
            ),
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
