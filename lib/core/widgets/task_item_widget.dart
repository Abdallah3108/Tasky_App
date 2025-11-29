import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/theme/theme_controller.dart';
import 'package:taskyapp2/models/task_model.dart';

import '../enums/task_item_actions_enum.dart';
import '../utils/app_colors.dart';
import 'custom_check_box.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;

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
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color:
                  model.isDone
                      ? AppColors.isDoneColor
                      : Theme.of(context).iconTheme.color,
            ),
            onSelected: (value) {
              switch (value) {
                case TaskItemActionsEnum.markTaskAsDone:
                  onChanged(!model.isDone);

                case TaskItemActionsEnum.edit:
                  // TODO: Handle this case.
                  throw UnimplementedError();
                case TaskItemActionsEnum.delete:
                  onDelete(model.id);
              }
            },
            itemBuilder:
                (BuildContext context) =>
                    TaskItemActionsEnum.values.map((e) {
                      return PopupMenuItem<TaskItemActionsEnum>(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
          ),
        ],
      ),
    );
  }
}
