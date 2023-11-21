import 'package:flutter/material.dart';

import '/services/utilities.dart';

/* spell-checker: disable */

abstract class AnalyticsTheme {
  // This class is not meant to be instantiated or extended;
  // this constructor prevents instantiation and extension.
  AnalyticsTheme._();

  static late double appSizeRatio;
  static double get appSizeRatioSquared => appSizeRatio * appSizeRatio;

  static void setAppSizeRatio(BuildContext context) {
    final screenHeight = context.screenSize.height;
    appSizeRatio = screenHeight / 1000;
    debug('Screen size: ${context.screenSize} | App size ratio: $appSizeRatio');
  }

  static const appTitle = 'Analytics App';

  static const darkBackground = Color(0xFF16151A);
  static const background1 = Color(0xFF1F1E24);
  static const background2 = Color(0xFF29272F);
  static const background3 = Color(0xFF423F50);
  static const foreground1 = Color(0xFFFFFFFF);
  static const foreground2 = Color(0xFFA5A5A5);
  static const primary = Color(0xFF0DBF78);
  static const primaryVariant = Color(0xFF075F3C);
  static const secondary = Color(0xFF53B8B2);
  static const error = Color(0xFFD4353A);
  static const warning = Color(0xFFF5C400);
  static const hamosad = Color(0xFF165700);
  static const blueAlliance = Color(0xFF1E88E5);
  static const redAlliance = Color(0xFFC62828);

  static TextStyle get navigationStyle => TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w600,
        fontSize: 22 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get navigationTitleStyle => TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.bold,
        fontSize: 25 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get dataTitleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w500,
        fontSize: 20 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get dataSubtitleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w500,
        fontSize: 18 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get dataBodyStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w600,
        fontSize: 22 * appSizeRatio,
        color: primary,
      );

  static TextStyle get logoTextStyle => TextStyle(
        fontFamily: 'Fira Code',
        fontWeight: FontWeight.w700,
        fontSize: 24 * appSizeRatioSquared,
        color: primary,
        height: 1.1,
      );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Open Sans',
    colorScheme: const ColorScheme.dark(
      primary: primary,
      onPrimary: background3,
      secondary: primaryVariant,
      onSecondary: background3,
      background: background1,
      onBackground: foreground1,
      surface: background2,
      onSurface: foreground1,
      error: error,
      onError: foreground1,
      outline: foreground2,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 4,
      shadowColor: Colors.black,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: background2,
      elevation: 3,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5 * appSizeRatio),
      ),
      side: const BorderSide(style: BorderStyle.none),
    ),
    dividerTheme: DividerThemeData(
      color: background3,
      thickness: 2,
      space: 0,
      indent: 10 * appSizeRatio,
      endIndent: 10 * appSizeRatio,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: background1,
      surfaceTintColor: Colors.transparent,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primary,
    ),
    listTileTheme: ListTileThemeData(
      tileColor: AnalyticsTheme.background2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      surfaceTintColor: background1,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      surfaceTintColor: background2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: background2,
      behavior: SnackBarBehavior.floating,
    ),
  );

  static const defaultShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.3),
    blurRadius: 3,
    spreadRadius: 2,
  );
}

class TeamInfo {
  const TeamInfo._(this.name, this.location, this.color);

  static TeamInfo fromNumber(String number) => _teamNumberToInfo[number]!;

  final String name, location;
  final Color color;

  static Set<String> get teams => _teamNumberToInfo.keys.toSet();

  /// [Color, Name, Location]
  static const _teamNumberToInfo = {
    '1574': TeamInfo._('MisCar', 'Misgav', Color.fromARGB(255, 126, 12, 43)),
    '1576': TeamInfo._('Voltrix', 'Tel-Aviv', Color.fromARGB(255, 252, 124, 23)),
    '1577': TeamInfo._('Steampunk', 'Binyamina', Color.fromARGB(255, 255, 165, 0)),
    '1580': TeamInfo._('Blue Monkeys', 'Ashkelon', Color.fromARGB(255, 4, 178, 241)),
    '1657': TeamInfo._('Hamosad', 'Ein Shemer', Color.fromARGB(255, 22, 87, 0)),
    '1690': TeamInfo._('Orbit', 'Binyamina', Color.fromARGB(255, 0, 0, 252)),
    '1937': TeamInfo._('Elysium', "Modi'in", Color.fromARGB(255, 131, 175, 252)),
    '1942': TeamInfo._('Cinderella', 'Gadera', Color.fromARGB(255, 0, 24, 65)),
    '1943': TeamInfo._('Neat Team', "Rosh Ha'ayin", Color.fromARGB(255, 101, 86, 198)),
    '1954': TeamInfo._('ElectroBunny', "Be'er Sheva", Color.fromARGB(255, 219, 217, 231)),
    '2096': TeamInfo._('RoboActive', 'Dimona', Color.fromARGB(255, 232, 255, 29)),
    '2212': TeamInfo._('Spikes', 'Lod', Color.fromARGB(255, 6, 30, 138)),
    '2230': TeamInfo._('General Angels', 'Herzliya', Color.fromARGB(255, 142, 142, 142)),
    '2231': TeamInfo._('OnyxTronix', 'Shoham', Color.fromARGB(255, 204, 4, 0)),
    '2630': TeamInfo._('Thunderbolts', 'Emek Hefer', Color.fromARGB(255, 51, 164, 108)),
    '2679': TeamInfo._('Tiger Team', 'Jerusalem', Color.fromARGB(255, 179, 119, 8)),
    '3065': TeamInfo._('Jatt', 'Jatt', Color.fromARGB(255, 255, 82, 0)),
    '3075': TeamInfo._('Ha-Dream', 'Hod Hasharon', Color.fromARGB(255, 132, 20, 184)),
    '3083': TeamInfo._('Artemis', "Ma'agan Michael", Color.fromARGB(255, 115, 122, 137)),
    '3211': TeamInfo._('Y Team', 'Yeruham', Color.fromARGB(255, 45, 180, 236)),
    '3316': TeamInfo._('D-Bug', 'Tel-Aviv', Color.fromARGB(255, 255, 140, 0)),
    '3339': TeamInfo._('BumbleB', 'Kfar Yona', Color.fromARGB(255, 255, 223, 15)),
    '3388': TeamInfo._('Flash', 'Gan Yavne', Color.fromARGB(255, 234, 90, 65)),
    '3835': TeamInfo._('Vulcan', 'Tel-Aviv', Color.fromARGB(255, 47, 84, 133)),
    '4319': TeamInfo._('Ladies FIRST', "Be'er Sheva", Color.fromARGB(255, 255, 48, 207)),
    '4320': TeamInfo._('Joker', 'Petah Tikva', Color.fromARGB(255, 255, 123, 123)),
    '4338': TeamInfo._('Falcons', 'Even-Yehuda', Color.fromARGB(255, 174, 3, 12)),
    '4416': TeamInfo._('Skynet', 'Ramat Hasharon', Color.fromARGB(255, 62, 77, 86)),
    '4586': TeamInfo._('PRIMO', "Modi'in", Color.fromARGB(255, 246, 230, 152)),
    '4590': TeamInfo._('GreenBlitz', 'HaKfar HaYarok', Color.fromARGB(255, 38, 169, 38)),
    '4661': TeamInfo._('Red Pirates', 'Bet-Hashmonai', Color.fromARGB(255, 62, 9, 11)),
    '4744': TeamInfo._('Ninjas', 'Hadera', Color.fromARGB(255, 72, 72, 73)),
    '5135': TeamInfo._('Black Unicorns', 'Yehud', Color.fromARGB(255, 34, 33, 33)),
    '5291': TeamInfo._('Emperius', 'Eilat', Color.fromARGB(255, 204, 0, 0)),
    '5554': TeamInfo._('Poros', 'Netanya', Color.fromARGB(255, 169, 193, 216)),
    '5614': TeamInfo._('Sycamore', 'Holon', Color.fromARGB(255, 0, 255, 0)),
    '5635': TeamInfo._('Demacia', 'Nes  Ziona', Color.fromARGB(255, 136, 13, 134)),
    '5654': TeamInfo._('Phoenix', 'Arad', Color.fromARGB(255, 255, 128, 0)),
    '5715': TeamInfo._('DRC', 'Dabburiya', Color.fromARGB(255, 255, 153, 51)),
    '5928': TeamInfo._('MetalBoost', 'Petah Tikva', Color.fromARGB(255, 25, 25, 26)),
    '5951': TeamInfo._('MA', 'Tel-Aviv', Color.fromARGB(255, 84, 3, 3)),
    '5987': TeamInfo._('Galaxia', 'Haifa', Color.fromARGB(255, 0, 153, 153)),
    '5990': TeamInfo._('TRIGON', "Modi'in", Color.fromARGB(255, 255, 0, 0)),
    '6104': TeamInfo._('Desert Eagles', 'Ofakim', Color.fromARGB(255, 215, 225, 110)),
    '6168': TeamInfo._('alzahwari', 'Iksal', Color.fromARGB(255, 82, 177, 182)),
    '6230': TeamInfo._('Team Koi', 'Jerusalem', Color.fromARGB(255, 204, 57, 204)),
    '6738': TeamInfo._('Excalibur', "Modi'in", Color.fromARGB(255, 26, 34, 185)),
    '6740': TeamInfo._('G3', 'Pardes Hana', Color.fromARGB(255, 255, 0, 204)),
    '6741': TeamInfo._('Space Monkeys', 'Rishon Le Tzion', Color.fromARGB(255, 100, 146, 103)),
    '7039': TeamInfo._('XO', 'Hadasa Neurim', Color.fromARGB(255, 163, 0, 0)),
    '7067': TeamInfo._('Team Streak', 'Jerusalem', Color.fromARGB(255, 255, 102, 51)),
    '7112': TeamInfo._('EverGreen', 'Kadima-Zoran', Color.fromARGB(255, 51, 153, 51)),
    '7177': TeamInfo._('Amal Tayibe', 'Tayibe', Color.fromARGB(255, 172, 139, 218)),
    '7845': TeamInfo._('8BIT', 'Jerusalem', Color.fromARGB(255, 208, 0, 0)),
    '8175': TeamInfo._('P.O.M', 'Emek Yisrael', Color.fromARGB(255, 113, 0, 81)),
    '8223': TeamInfo._('Mariners', 'Tel-Aviv', Color.fromARGB(255, 98, 173, 183)),
    '9303': TeamInfo._('PORTAL', 'Givat Shmuel', Color.fromARGB(255, 126, 51, 153)),
    '9304': TeamInfo._("legend's", 'Sdot Negev', Color.fromARGB(255, 129, 34, 34)),
  };
}
