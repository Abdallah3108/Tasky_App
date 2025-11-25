import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: AppColors.textFormFieldColorDark,
  ),
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
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.secondaryTextColorAtDark;
    }),
    thumbColor: WidgetStateProperty.all(Colors.white),
    trackOutlineColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return AppColors.secondaryTextColorAtDark;
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return 0;
      }
      return 1;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.primary),
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: AppColors.textColorAtDark,
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: AppColors.textColorAtDark,
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      color: AppColors.textColorAtDark,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      overflow: TextOverflow.ellipsis,
    ),

    //for done task
    titleLarge: TextStyle(
      color: AppColors.isDoneColor,
      fontSize: 16.sp,
      decoration: TextDecoration.lineThrough,
      decorationColor: AppColors.isDoneColor,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: Color(0xff6D6D6D)),
    labelStyle: TextStyle(
      color: AppColors.textColorAtDark,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: AppColors.textFormFieldColorDark,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.grey, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
  ),
);
