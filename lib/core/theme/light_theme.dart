import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: AppColors.textFormFieldColorLight,
  ),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
    titleTextStyle: TextStyle(
      color: AppColors.textColorAtLight,
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.textColorAtLight),
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
      color: AppColors.textColorAtLight,
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: AppColors.textColorAtLight,
      fontSize: 28.sp,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      color: AppColors.textColorAtLight,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none,
      overflow: TextOverflow.ellipsis,
    ),

    //for done task
    titleLarge: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize: 16.sp,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: AppColors.textColorAtLight),
    labelStyle: TextStyle(
      color: AppColors.textColorAtLight,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
    filled: true,
    fillColor: AppColors.textFormFieldColorLight,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.grey, width: 1),
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
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
  ),
);
