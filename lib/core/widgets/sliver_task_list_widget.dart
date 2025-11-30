import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/widgets/task_item_widget.dart';

import '../../models/task_model.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
  final Function onEdit;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
          child: Center(
            child: Text(
              emptyMessage,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(fontSize: 20.sp),
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
                child: TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) => onTap(value, index),
                  onDelete: (int id) {
                    onDelete(id);
                  },
                  onEdit: () => onEdit(),
                ),
              );
            },
          ),
        );
  }
}
