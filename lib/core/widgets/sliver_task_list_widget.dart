import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/widgets/custom_check_box.dart';

import '../../models/task_model.dart';
import '../utils/app_colors.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
          child: Center(
            child: Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 20.sp,
                color: AppColors.textColorAtDark,
              ),
            ),
          ),
        )
        : SliverPadding(
          padding: EdgeInsets.only(bottom: 50).r,
          sliver: SliverList.builder(
            itemCount: tasks.length,

            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8).r,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.textFormFieldColorDark,
                    borderRadius: BorderRadius.circular(20),
                    // border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      CustomCheckBox(
                        value: tasks[index].isDone,
                        onChanged: (bool? value) async {
                          onTap(value, index);
                        },
                      ),

                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[index].taskName,
                              style: TextStyle(
                                color:
                                    tasks[index].isDone
                                        ? AppColors.isDoneColor
                                        : AppColors.textColorAtDark,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                decoration:
                                    tasks[index].isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            if (tasks[index].taskDescription.isNotEmpty)
                              Text(
                                tasks[index].taskDescription,
                                style: TextStyle(
                                  color: AppColors.textColorAtDark,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 1,
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.more_vert,
                          color:
                              tasks[index].isDone
                                  ? AppColors.isDoneColor
                                  : AppColors.textColorAtDark,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
  }
}
