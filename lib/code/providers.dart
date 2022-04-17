import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:wordle_opener/code/storage.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkMode = storageService.darkMode != null
      ? storageService.darkMode!
      : SchedulerBinding.instance!.window.platformBrightness == Brightness.dark;
  bool get darkMode => _darkMode;

  toggleDarkMode() {
    _darkMode = !_darkMode;
    storageService.toggleDarkMode(_darkMode);
    notifyListeners();
  }
}
