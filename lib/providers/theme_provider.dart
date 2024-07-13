import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  ThemeProvider() {
    _loadThemeMode();
  }

  _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkMode');
    print('isDarkMode: $isDarkMode');

    if (isDarkMode != null) {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } else {
      var brightness = WidgetsBinding.instance!.window.platformBrightness;
      _themeMode = brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }

    notifyListeners();
  }
}