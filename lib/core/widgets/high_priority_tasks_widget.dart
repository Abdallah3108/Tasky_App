import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/models/task_model.dart';

import '../../features/high_priorty_tasks_view.dart';
import '../utils/app_colors.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,

    required this.onTap,
    required this.tasks,
    required this.refresh,
  });

  final Function(bool?, int?) onTap;
  final List<TaskModel> tasks;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.textFormFieldColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'High Priority Tasks',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.primary,
                  ),
                ),
                // SizedBox(height: 8.h),
                ...tasks.where((e) => e.isHighPriority).take(4).map((element) {
                  return Row(
                    children: [
                      Checkbox(
                        value: element.isDone,
                        activeColor: AppColors.checkBoxColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: (bool? value) async {
                          final index = tasks.indexWhere(
                            (e) => e.id == element.id,
                          );
                          onTap(value, index);

                          final updatedTask =
                              tasks.map((e) => e.toJson()).toList();
                          await PreferencesManager().setString(
                            'tasks',
                            jsonEncode(updatedTask),
                          );
                        },
                      ),
                      Expanded(
                        child: Text(
                          element.taskName,
                          style: TextStyle(
                            color:
                                element.isDone
                                    ? AppColors.isDoneColor
                                    : AppColors.textColorAtDark,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            decoration:
                                element.isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HighPriorityTasksView();
                  },
                ),
              );
              refresh();
            },
            child: Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                color: AppColors.textFormFieldColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: SvgPicture.asset(
                'assets/arrowupright.svg',
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
