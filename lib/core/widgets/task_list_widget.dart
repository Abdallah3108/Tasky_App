import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/widgets/task_item_widget.dart';

import '../../models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
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
        ? Center(
          child: Text(
            emptyMessage ?? "No Tasks",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        )
        : ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          padding: EdgeInsets.only(bottom: 40).r,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8).r,
              child: TaskItemWidget(
                model: tasks[index],
                onChanged: (bool? value) => onTap(value, index),
              ),
            );
          },
        );
  }
}
