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
    centerTitle: true,
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
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textColorAtDark,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStateProperty.all(Colors.white)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textColorAtDark,
    splashColor: AppColors.primary,
    focusColor: AppColors.primary,
    hoverColor: AppColors.primary,
    extendedTextStyle: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.textColorAtDark,
    ),
    elevation: 4,
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
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.resolveWith((states) {
        return AppColors.textColorAtDark; // للـ Light Mode
      }),
    ),
  ),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: AppColors.textColorAtDark,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xffC6C6C6)),
  dividerTheme: DividerThemeData(color: Color(0xff6E6E6E), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.backgroundDark,
    unselectedItemColor: Colors.white,
    selectedItemColor: AppColors.primary,
    type: BottomNavigationBarType.fixed,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.backgroundDark,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: AppColors.primary, width: 1),
    ),
    elevation: 4,
    shadowColor: AppColors.primary,
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(
        color: AppColors.textColorAtDark,
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
  ),
);
