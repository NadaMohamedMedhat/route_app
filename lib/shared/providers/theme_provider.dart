import 'package:flutter/material.dart';
import 'package:route_app/shared/prefs_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
   ThemeMode themeMode = ThemeMode.light;

  Future<void> changeTheme(ThemeMode newThemeMode) async {
    if (themeMode == newThemeMode) return;
    themeMode = newThemeMode;
    PrefsHelper.preferences.setString('themeMode', themeMode.name);
    print('themeMode: ${themeMode.name}');
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final String? themeModeName = PrefsHelper.preferences.getString('themeMode');
    themeMode = (themeModeName == 'dark') ? ThemeMode.dark : ThemeMode.light;
    print(themeModeName);
  }
}
