import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

DateTime startDate = DateTime(
  2021,
  6,
  20,
);
List<String> keys = ["qwertyuiop", " asdfghjkl ", "[zxcvbnm]"];
int notificationFade = 200;
int notificationDisplay = 3000;

MaterialColor lightColors = const MaterialColor(0xffd3d6da, {
  100: Color(0xff000000),
  200: Color(0xff787c7e),
  300: Color(0xff878a8c),
  400: Color(0xffd3d6da),
  500: Color(0xffedeff1),
  600: Color(0xfff6f7f8),
  700: Color(0xffffffff),
});
MaterialColor darkColors = const MaterialColor(0xff3a3a3c, {
  100: Color(0xffffffff),
  200: Color(0xff818384),
  300: Color(0xff565758),
  400: Color(0xff3a3a3c),
  500: Color(0xff272729),
  600: Color(0xff1a1a1b),
  700: Color(0xff121213),
});

Color green(bool darkMode) =>
    darkMode ? const Color(0xff538d4e) : const Color(0xff6aaa64);
Color yellow(bool darkMode) =>
    darkMode ? const Color(0xffc9b458) : const Color(0xffb59f3b);
Color gray(bool darkMode) =>
    darkMode ? const Color(0xff86888a) : const Color(0xff939598);
Color white = Colors.white;
Color black = const Color(0xff212121);

ThemeData lightTheme = ThemeData.light().copyWith(
  // brightness: Brightness.dark,
  scaffoldBackgroundColor: lightColors[700],
  colorScheme: ColorScheme.fromSeed(seedColor: lightColors),
  textTheme: TextTheme(headline5: TextStyle(color: lightColors[100])),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    backgroundColor: lightColors[700],
    elevation: 1,
    shadowColor: black,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  // brightness: Brightness.dark,
  scaffoldBackgroundColor: darkColors[700],
  colorScheme: ColorScheme.fromSeed(seedColor: darkColors),
  textTheme: TextTheme(headline5: TextStyle(color: darkColors[100])),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    backgroundColor: darkColors[700],
    elevation: 1,
    shadowColor: white,
  ),
);
