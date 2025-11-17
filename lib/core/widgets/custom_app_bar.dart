import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
      centerTitle: false,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textColorAtDark),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textColorAtDark,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
