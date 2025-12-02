import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';

import '../../models/task_model.dart';
import '../../widgets/task_list_widget.dart';

class HighPriorityTasksView extends StatefulWidget {
  const HighPriorityTasksView({super.key});

  @override
  State<HighPriorityTasksView> createState() => _HighPriorityTasksViewState();
}

class _HighPriorityTasksViewState extends State<HighPriorityTasksView> {
  List<TaskModel> highPriorityTasks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final finalTask = await PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final decoded = jsonDecode(finalTask);

      List<dynamic> taskAfterDecode = [];

      if (decoded is List) {
        taskAfterDecode = decoded;
      } else if (decoded is Map) {
        taskAfterDecode = [decoded];
      }

      setState(() {
        highPriorityTasks =
            taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        highPriorityTasks =
            highPriorityTasks
                .where((element) => element.isHighPriority == true)
                .toList();
        highPriorityTasks = highPriorityTasks.reversed.toList();
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
        highPriorityTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((e) => e.toJson()).toList();
      PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'High Priority Tasks',
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          emptyMessage: 'High Priority Tasks Is Empty',
          tasks: highPriorityTasks,
          onTap: (bool? value, int? index) async {
            setState(() {
              highPriorityTasks[index!].isDone = value ?? false;
            });

            final allData = PreferencesManager().getString('tasks');
            if (allData != null) {
              List<TaskModel> allDataList =
                  (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromJson(e))
                      .toList();
              final int newIndex = allDataList.indexWhere(
                (e) => e.id == highPriorityTasks[index!].id,
              );
              allDataList[newIndex] = highPriorityTasks[index!];
              PreferencesManager().setString('tasks', jsonEncode(allDataList));

              _loadTasks();
            }
          },
          onDelete: (int? id) {
            _deleteTask(id);
          },
          onEdit: () {
            _loadTasks();
          },
        ),
      ),
    );
  }
}
