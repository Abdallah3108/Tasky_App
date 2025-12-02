import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/core/theme/dark_theme.dart';
import 'package:taskyapp2/core/theme/light_theme.dart';
import 'package:taskyapp2/core/theme/theme_controller.dart';

import 'features/navigation/main_screen.dart';
import 'features/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await PreferencesManager().init();
  String? username = PreferencesManager().getString('username');
  ThemeController().init();

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
          valueListenable: ThemeController.themeNotifier,
          builder: (context, ThemeMode themeMode, Widget? child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              title: 'Tasky App',
              home: username == null ? WelcomeScreen() : MainScreen(),
            );
          },
        );
      },
    );
  }
}
