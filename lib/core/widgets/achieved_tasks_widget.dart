import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,
    required this.totalTask,
    required this.doneTask,
    required this.percentage,
  });

  final int totalTask;
  final int doneTask;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textFormFieldColor,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColorAtDark,
                ),
              ),
              Text(
                '${totalTask - doneTask} Out of ${totalTask} Done',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,

            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                    color: AppColors.primary,
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                "${(percentage * 100).toInt()}%",
                style: TextStyle(
                  color: AppColors.textColorAtDark,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
