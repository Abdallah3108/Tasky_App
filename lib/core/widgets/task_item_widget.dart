import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/theme/theme_controller.dart';
import 'package:taskyapp2/models/task_model.dart';

import '../utils/app_colors.dart';
import 'custom_check_box.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
  });

  final TaskModel model;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 56.h,
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
        children: [
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) async {
              onChanged(value);
            },
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style:
                      model.isDone
                          ? Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          )
                          : Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style:
                        model.isDone
                            ? Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(fontSize: 14.sp)
                            : Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color:
                  model.isDone
                      ? AppColors.isDoneColor
                      : AppColors.textColorAtDark,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
