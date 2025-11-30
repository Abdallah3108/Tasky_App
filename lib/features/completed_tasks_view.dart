import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/widgets/task_list_widget.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';

class CompletedTasksView extends StatefulWidget {
  const CompletedTasksView({super.key});

  @override
  State<CompletedTasksView> createState() => _CompletedTasksViewState();
}

class _CompletedTasksViewState extends State<CompletedTasksView> {
  List<TaskModel> completeTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final decoded = jsonDecode(finalTask);

      List<dynamic> taskAfterDecode = [];

      if (decoded is List) {
        taskAfterDecode = decoded;
      } else if (decoded is Map) {
        taskAfterDecode = [decoded];
      }

      setState(() {
        completeTasks =
            taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();

        completeTasks =
            completeTasks.where((element) => element.isDone == true).toList();
      });
    }
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;
    final finalTask = await PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final decoded = jsonDecode(finalTask);

      List<dynamic> taskAfterDecode = [];

      if (decoded is List) {
        taskAfterDecode = decoded;
      } else if (decoded is Map) {
        taskAfterDecode = [decoded];
      }
      tasks =
          taskAfterDecode
              .map((element) => TaskModel.fromJson(element))
              .toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((e) => e.toJson()).toList();
      PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Completed Tasks',
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontSize: 20.sp),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TaskListWidget(
              tasks: completeTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  completeTasks[index!].isDone = value ?? false;
                });

                final allData = PreferencesManager().getString('tasks');
                if (allData != null) {
                  List<TaskModel> allDataList =
                      (jsonDecode(allData) as List)
                          .map((e) => TaskModel.fromJson(e))
                          .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == completeTasks[index!].id,
                  );
                  allDataList[newIndex] = completeTasks[index!];
                  await PreferencesManager().setString(
                    'tasks',
                    jsonEncode(allDataList),
                  );

                  _loadTasks();
                }
              },
              emptyMessage: 'No Tasks Completed',
              onDelete: (int? id) {
                _deleteTask(id);
              },
              onEdit: () {
                _loadTasks();
              },
            ),
          ),
        ),
      ],
    );
  }
}
