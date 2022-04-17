import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:wordle_opener/code/constants.dart';
import 'package:wordle_opener/code/providers.dart';
import 'package:wordle_opener/code/storage.dart';
import 'package:wordle_opener/screen/game.dart';

void main() async {
  await GetStorage.init();
  storageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isDarkMode =
    //     SchedulerBinding.instance!.window.platformBrightness == Brightness.dark;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Builder(builder: (context) {
        ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'Wordle Opener',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.darkMode ? ThemeMode.dark : ThemeMode.light,
          home: const GamePage(),
        );
      }),
    );
  }
}
