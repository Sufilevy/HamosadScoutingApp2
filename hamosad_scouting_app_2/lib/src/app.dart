import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/other/cubit.dart';
import 'package:hamosad_scouting_app_2/src/widgets/scouting/scouting_image.dart';
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
                ScoutingCounter(
                  cubit: Cubit(0),
                  min: 0,
                  max: 100,
                  step: 1,
                  title: 'This is a looooong counter',
                  initial: 0,
                  size: size,
                ),
                ScoutingImage(
                  title: 'This is an image',
                  url:
                      'data:image/jpeg;base64,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',
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
                  title:
                      'This is a really really extremly very very long title',
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
          ),
        ),
      ),
    );
  }
}
