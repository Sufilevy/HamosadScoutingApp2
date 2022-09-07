import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';
import 'package:provider/provider.dart';

class ScoutingApp extends StatefulWidget {
  final Color? textColor, lightTextColor;

  const ScoutingApp({
    Key? key,
    this.textColor,
    this.lightTextColor,
  }) : super(key: key);

  @override
  State<ScoutingApp> createState() => _ScoutingAppState();
}

class _ScoutingAppState extends State<ScoutingApp> {
  Widget _homePage(BuildContext context) {
    return ScoutingHomePage(
      size: size,
      title: 'Scouting App',
    );
  }

  Widget _gameReport(BuildContext context) {
    return ScoutingReportPage(
      size: size,
      title: 'Game Report',
      tabs: <ScoutingReportTab>[
        ScoutingReportTab(
          size: size,
          title: 'Info',
          children: <Widget>[
            ScoutingCounter(
              cubit: reportDataProvider(context).gameReport.teleopHubMissed,
              min: 0,
              max: 100,
              step: 1,
              title: 'Teleop Hub Missed',
              initial: 0,
              size: size,
            ),
            ScoutingImage(
              title: 'This is an image',
              url:
                  'https://www.manchesterdigital.com/storage/13256/0_ZQ9Xa7CINFVMA95w.png',
              scale: 1.0,
            ),
            ScoutingSlider(
              cubit: Cubit(0),
              min: 1,
              max: 5,
              step: 1,
              title: 'This is a  slider',
              subtitle: 'This is the subtitle',
              initial: 1,
              size: size,
            ),
            ScoutingTeamNumber(
              cubit: Cubit(''),
              teams: const [
                '1000',
                '2000',
                '3000',
                '4000',
                '5000',
                '6000',
              ],
              size: size,
            ),
            ScoutingTextField(
              cubit: Cubit(''),
              hint: 'Enter your name',
              errorHint: 'Please do it!',
              onlyNumbers: true,
              size: size,
            ),
            ScoutingText(
              text: 'This is some text!',
              fontSize: 20,
              size: size,
            ),
            ScoutingToggleButton(
              cubit: Cubit(false),
              title: 'This is a really really extremly very very long title',
              size: size,
            ),
            ScoutingSlider(
              cubit: Cubit(0),
              min: 1,
              max: 5,
              step: 1,
              title: 'This is a  slider',
              subtitle: 'This is the subtitle',
              initial: 1,
              size: size,
            ),
            ScoutingCounter(
              cubit: Cubit(0),
              min: 0,
              max: 100,
              step: 1,
              title: 'This is a looooong counter',
              initial: 0,
              size: size,
            ),
          ],
        ),
        ScoutingReportTab(
          size: size,
          title: 'Heyoo',
          children: const <Widget>[
            ScoutingText(text: 'hello'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    size = screenSize.height / 1200;
    return Provider<ReportDataProvider>(
      create: (_) => ReportDataProvider(),
      child: MaterialApp(
        title: 'Scouting App',
        darkTheme: _themeData(),
        initialRoute: '/',
        routes: {
          '/': _homePage,
          '/game-report': _gameReport,
        },
      ),
    );
  }

  Color? textColor, lightTextColor;
  late double size;

  @override
  void initState() {
    textColor = widget.textColor ?? const Color.fromARGB(255, 121, 121, 121);
    lightTextColor =
        widget.lightTextColor ?? const Color.fromARGB(255, 175, 175, 175);
    super.initState();
  }

  TextTheme _textTheme() => TextTheme(
        bodySmall: TextStyle(fontSize: 12 * size, color: lightTextColor),
        bodyMedium: TextStyle(fontSize: 16 * size, color: lightTextColor),
        bodyLarge: TextStyle(fontSize: 20 * size, color: lightTextColor),
        labelSmall: TextStyle(fontSize: 24 * size, color: textColor),
        labelMedium: TextStyle(fontSize: 30 * size, color: textColor),
        labelLarge: TextStyle(fontSize: 36 * size, color: textColor),
      );

  TooltipThemeData _tooltipTheme() => TooltipThemeData(
        decoration: const BoxDecoration(
          color: Color(0xFF383838),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        textStyle: TextStyle(
          fontSize: 22 * size,
          color: textColor?.lighten(),
        ),
        padding: const EdgeInsets.all(8.0),
      );

  ThemeData _themeData() => ThemeData(
        brightness: Brightness.dark,
        textTheme: _textTheme(),
        toggleableActiveColor: const Color(0xFF2962FF),
        primaryColor: const Color(0xFF394DA7),
        tooltipTheme: _tooltipTheme(),
      );
}
