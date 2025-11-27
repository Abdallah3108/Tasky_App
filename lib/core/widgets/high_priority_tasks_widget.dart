import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp2/models/task_model.dart';

import '../../features/high_priorty_tasks_view.dart';
import '../theme/theme_controller.dart';
import '../utils/app_colors.dart';
import 'custom_check_box.dart';

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
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              ThemeController.isLight()
                  ? Color(0xffe5ede9)
                  : Colors.transparent,
        ),
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
                      CustomCheckBox(
                        value: element.isDone,
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
                          style:
                              element.isDone
                                  ? Theme.of(context).textTheme.titleLarge!
                                      .copyWith(fontWeight: FontWeight.w600)
                                  : Theme.of(context).textTheme.titleMedium!
                                      .copyWith(fontWeight: FontWeight.w600),

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
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: CustomSvgPicture(
                path: 'assets/arrowupright.svg',
                withColorFilter: true,
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
