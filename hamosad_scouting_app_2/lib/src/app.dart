import 'package:flutter/material.dart';

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

  TextTheme get _textTheme => TextTheme(
        labelSmall: TextStyle(fontSize: 24 * size, color: textColor),
        labelMedium: TextStyle(fontSize: 30 * size, color: textColor),
        labelLarge: TextStyle(fontSize: 36 * size, color: textColor),
        bodySmall: TextStyle(fontSize: 12 * size, color: lightTextColor),
        bodyMedium: TextStyle(fontSize: 16 * size, color: lightTextColor),
        bodyLarge: TextStyle(fontSize: 20 * size, color: lightTextColor),
      );

  ThemeData get _themeData => ThemeData(
        brightness: Brightness.dark,
        textTheme: _textTheme,
      );

  @override
  Widget build(BuildContext context) {
    final screenSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    size = screenSize.height / 1200.0 * 1.125;
    return MaterialApp(
      title: 'Scouting App',
      darkTheme: _themeData,
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Scouting App'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [],
          ),
        ),
      ),
    );
  }
}
