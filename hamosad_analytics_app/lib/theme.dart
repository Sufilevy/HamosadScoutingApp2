import 'package:flutter/material.dart';

import '/services/utilities.dart';

/* spell-checker: disable */

class AnalyticsTheme {
  // This class is not meant to be instantiated or extended;
  // this constructor prevents instantiation and extension.
  AnalyticsTheme._();

  static late double appSizeRatio;
  static double get appSizeRatioSquared => appSizeRatio * appSizeRatio;
  static void setAppSizeRatio(BuildContext context) {
    final screenHeight = getScreenSize(context).height;
    appSizeRatio = screenHeight / 1140.0;
    debug('Screen size: ${getScreenSize(context)} | App size ratio: $appSizeRatio');
  }

  static const appTitle = 'Analytics App';

  static const darkBackground = Color(0xFF16151A);
  static const background1 = Color(0xFF1F1E24);
  static const background2 = Color(0xFF29272F);
  static const background3 = Color(0xFF363442);
  static const foreground1 = Color(0xFFFFFFFF);
  static const foreground2 = Color(0xFFADADB1);
  static const primary = Color(0xFF0DBF78);
  static const primaryVariant = Color(0xFF075F3C);
  static const error = Color(0xFFD4353A);
  static const warning = Color(0xFFF5C400);
  static const hamosad = Color(0xFF165700);
  static const blueAlliance = Color(0xFF1E88E5);
  static const redAlliance = Color(0xFFC62828);

  static TextStyle get navigationStyle => TextStyle(
        fontFamily: 'Varela Round',
        fontWeight: FontWeight.normal,
        fontSize: 18.0 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get navigationTitleStyle => TextStyle(
        fontFamily: 'Varela Round',
        fontWeight: FontWeight.normal,
        fontSize: 20.0 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get dataTitleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w500,
        fontSize: 20.0 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get dataSubtitleStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.normal,
        fontSize: 18.0 * appSizeRatio,
        color: foreground1,
      );

  static TextStyle get dataBodyStyle => TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w600,
        fontSize: 22.0 * appSizeRatio,
        color: primary,
      );

  static TextStyle get logoTextStyle => TextStyle(
        fontFamily: 'Fira Code',
        fontWeight: FontWeight.w700,
        fontSize: 24.0 * appSizeRatioSquared,
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
      shadowColor: Colors.black87,
      elevation: 8.0,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: background1,
      surfaceTintColor: Colors.transparent,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primary,
    ),
  );

  /// [Color, Name, Location]
  static const teamNumberToInfo = {
    1574: [Color.fromARGB(255, 126, 12, 43), 'MisCar', 'Misgav'],
    1576: [Color.fromARGB(255, 252, 124, 23), 'Voltrix', 'Tel-Aviv'],
    1577: [Color.fromARGB(255, 255, 165, 0), 'Steampunk', 'Binyamina'],
    1580: [Color.fromARGB(255, 4, 178, 241), 'Blue Monkeys', 'Ashkelon'],
    1657: [Color.fromARGB(255, 22, 87, 0), 'Hamosad', 'Ein Shemer'],
    1690: [Color.fromARGB(255, 0, 0, 252), 'Orbit', 'Binyamina'],
    1937: [Color.fromARGB(255, 131, 175, 252), 'Elysium', "Modi'in"],
    1942: [Color.fromARGB(255, 0, 24, 65), 'Cinderella', 'Gadera'],
    1943: [Color.fromARGB(255, 101, 86, 198), 'Neat Team', "Rosh Ha'ayin"],
    1954: [Color.fromARGB(255, 219, 217, 231), 'ElectroBunny', "Be'er Sheva"],
    2096: [Color.fromARGB(255, 232, 255, 29), 'RoboActive', 'Dimona'],
    2212: [Color.fromARGB(255, 6, 30, 138), 'Spikes', 'Lod'],
    2230: [Color.fromARGB(255, 142, 142, 142), 'General Angels', 'Herzliya'],
    2231: [Color.fromARGB(255, 204, 4, 0), 'OnyxTronix', 'Shoham'],
    2630: [Color.fromARGB(255, 51, 164, 108), 'Thunderbolts', 'Emek Hefer'],
    2679: [Color.fromARGB(255, 179, 119, 8), 'Tiger Team', 'Jerusalem'],
    3065: [Color.fromARGB(255, 255, 82, 0), 'Jatt', 'Jatt'],
    3075: [Color.fromARGB(255, 132, 20, 184), 'Ha-Dream', 'Hod Hasharon'],
    3083: [Color.fromARGB(255, 115, 122, 137), 'Artemis', "Ma'agan Michael"],
    3211: [Color.fromARGB(255, 45, 180, 236), 'Y Team', 'Yeruham'],
    3316: [Color.fromARGB(255, 255, 140, 0), 'D-Bug', 'Tel-Aviv'],
    3339: [Color.fromARGB(255, 255, 223, 15), 'BumbleB', 'Kfar Yona'],
    3388: [Color.fromARGB(255, 234, 90, 65), 'Flash', 'Gan Yavne'],
    3835: [Color.fromARGB(255, 47, 84, 133), 'Vulcan', 'Tel-Aviv'],
    4319: [Color.fromARGB(255, 255, 48, 207), 'Ladies FIRST', "Be'er Sheva"],
    4320: [Color.fromARGB(255, 255, 123, 123), 'Joker', 'Petah Tikva'],
    4338: [Color.fromARGB(255, 174, 3, 12), 'Falcons', 'Even-Yehuda'],
    4416: [Color.fromARGB(255, 62, 77, 86), 'Skynet', 'Ramat Hasharon'],
    4586: [Color.fromARGB(255, 246, 230, 152), 'PRIMO', "Modi'in"],
    4590: [Color.fromARGB(255, 38, 169, 38), 'GreenBlitz', 'HaKfar HaYarok'],
    4661: [Color.fromARGB(255, 62, 9, 11), 'Red Pirates', 'Bet-Hashmonai'],
    4744: [Color.fromARGB(255, 72, 72, 73), 'Ninjas', 'Hadera'],
    5135: [Color.fromARGB(255, 34, 33, 33), 'Black Unicorns', 'Yehud'],
    5291: [Color.fromARGB(255, 204, 0, 0), 'Emperius', 'Eilat'],
    5554: [Color.fromARGB(255, 169, 193, 216), 'Poros', 'Netanya'],
    5614: [Color.fromARGB(255, 0, 255, 0), 'Sycamore', 'Holon'],
    5635: [Color.fromARGB(255, 136, 13, 134), 'Demacia', 'Nes  Ziona'],
    5654: [Color.fromARGB(255, 255, 128, 0), 'Phoenix', 'Arad'],
    5715: [Color.fromARGB(255, 255, 153, 51), 'DRC', 'Dabburiya'],
    5928: [Color.fromARGB(255, 25, 25, 26), 'MetalBoost', 'Petah Tikva'],
    5951: [Color.fromARGB(255, 84, 3, 3), 'MA', 'Tel-Aviv'],
    5987: [Color.fromARGB(255, 0, 153, 153), 'Galaxia', 'Haifa'],
    5990: [Color.fromARGB(255, 255, 0, 0), 'TRIGON', "Modi'in"],
    6104: [Color.fromARGB(255, 215, 225, 110), 'Desert Eagles', 'Ofakim'],
    6168: [Color.fromARGB(255, 82, 177, 182), 'alzahwari', 'Iksal'],
    6230: [Color.fromARGB(255, 204, 57, 204), 'Team Koi', 'Jerusalem'],
    6738: [Color.fromARGB(255, 26, 34, 185), 'Excalibur', "Modi'in"],
    6740: [Color.fromARGB(255, 255, 0, 204), 'G3', 'Pardes Hana'],
    6741: [Color.fromARGB(255, 100, 146, 103), 'Space Monkeys', 'Rishon Le Tzion'],
    7039: [Color.fromARGB(255, 163, 0, 0), 'XO', 'Hadasa Neurim'],
    7067: [Color.fromARGB(255, 255, 102, 51), 'Team Streak', 'Jerusalem'],
    7112: [Color.fromARGB(255, 51, 153, 51), 'EverGreen', 'Kadima-Zoran'],
    7177: [Color.fromARGB(255, 172, 139, 218), 'Amal Tayibe', 'Tayibe'],
    7845: [Color.fromARGB(255, 208, 0, 0), '8BIT', 'Jerusalem'],
    8175: [Color.fromARGB(255, 113, 0, 81), 'P.O.M', 'Emek Yisrael'],
    8223: [Color.fromARGB(255, 98, 173, 183), 'Mariners', 'Tel-Aviv'],
    9303: [Color.fromARGB(255, 126, 51, 153), 'PORTAL', 'Givat Shmuel'],
    9304: [Color.fromARGB(255, 129, 34, 34), "legend's", 'Sdot Negev'],
  };
}
