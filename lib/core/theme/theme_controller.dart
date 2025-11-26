import 'package:flutter/material.dart';

import '../services/preferences_manager.dart';

class ThemeController {
  //value notifier
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    bool result = PreferencesManager().getBool('theme') ?? true;

    if (result == true) {
      themeNotifier.value = ThemeMode.dark;
    } else {
      themeNotifier.value = ThemeMode.light;
    }
  }

  static toggleTheme() {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      PreferencesManager().setBool('theme', false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      PreferencesManager().setBool('theme', true);
    }
  }

  static isDark() => themeNotifier.value == ThemeMode.dark;
  static isLight() => themeNotifier.value == ThemeMode.light;
}
