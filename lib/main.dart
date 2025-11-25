import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/core/theme/dark_theme.dart';
import 'package:taskyapp2/core/theme/light_theme.dart';

import 'features/main_screen.dart';
import 'features/welcome_screen.dart';

//value notifier
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  String? username = PreferencesManager().getString('username');

  //final pref = await SharedPreferences.getInstance();
  // String? username = pref.getString('username');
  runApp(TaskyApp(username: username));
}

class TaskyApp extends StatelessWidget {
  const TaskyApp({super.key, required this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 809),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (context, ThemeMode value, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: value,
              title: 'Tasky App',
              home: username == null ? WelcomeScreen() : MainScreen(),
            );
          },
        );
      },
    );
  }
}
