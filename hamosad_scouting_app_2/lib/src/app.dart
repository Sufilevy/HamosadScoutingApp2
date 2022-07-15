import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/other/cubit.dart';
import 'package:hamosad_scouting_app_2/src/widgets/widgets.dart';

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

  ThemeData _themeData() => ThemeData(
        brightness: Brightness.dark,
        textTheme: _textTheme(),
        toggleableActiveColor: Colors.blueAccent.shade700,
      );

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    size = screenSize.height / 1200;
    return MaterialApp(
      title: 'Scouting App',
      darkTheme: _themeData(),
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const ScoutingText(text: 'Scouting App'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 16 * size),
            child: ScoutingPageBody(
              children: <Widget>[
                ScoutingTextField(cubit: Cubit('')),
                // ScoutingCounter(
                //   cubit: Cubit(0),
                //   min: 0,
                //   max: 100,
                //   step: 1,
                //   title: 'This is a looooong counter',
                //   initial: 0,
                //   size: size,
                // ),
                // ScoutingImage(
                //   title: 'This is an image',
                //   url:
                //       'https://www.manchesterdigital.com/storage/13256/0_ZQ9Xa7CINFVMA95w.png',
                //   scale: 1.0,
                // ),
                // ScoutingSlider(
                //   cubit: Cubit(0),
                //   min: 1,
                //   max: 5,
                //   step: 1,
                //   title: 'This is a  slider',
                //   subtitle: 'This is the subtitle',
                //   initial: 1,
                //   size: size,
                // ),
                // ScoutingTeamNumber(
                //   cubit: Cubit(''),
                //   teams: const [
                //     '1000',
                //     '2000',
                //     '3000',
                //     '4000',
                //     '5000',
                //     '6000',
                //   ],
                //   size: size,
                // ),
                // ScoutingTextField(
                //   cubit: Cubit(''),
                //   hint: 'Enter your name',
                //   errorHint: 'Please do it!',
                //   onlyNumbers: true,
                //   size: size,
                // ),
                // ScoutingText(
                //   text: 'This is some text!',
                //   fontSize: 20,
                //   size: size,
                // ),
                // ScoutingToggleButton(
                //   cubit: Cubit(false),
                //   title:
                //       'This is a really really extremly very very long title',
                //   size: size,
                // ),
                // ScoutingSlider(
                //   cubit: Cubit(0),
                //   min: 1,
                //   max: 5,
                //   step: 1,
                //   title: 'This is a  slider',
                //   subtitle: 'This is the subtitle',
                //   initial: 1,
                //   size: size,
                // ),
                // ScoutingCounter(
                //   cubit: Cubit(0),
                //   min: 0,
                //   max: 100,
                //   step: 1,
                //   title: 'This is a looooong counter',
                //   initial: 0,
                //   size: size,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
