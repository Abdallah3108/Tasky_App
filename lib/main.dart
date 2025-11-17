import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/app_colors.dart';
import 'features/get_started/views/get_started_view.dart';
import 'features/main_screen/views/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();

  String? username = pref.getString('username');

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.backgroundDark,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.backgroundDark,
              titleTextStyle: TextStyle(
                color: AppColors.textColorAtDark,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
              iconTheme: IconThemeData(color: AppColors.textColorAtDark),
            ),
          ),
          title: 'Tasky App',
          home: username == null ? GetStartedView() : MainScreen(),
        );
      },
    );
  }
}
