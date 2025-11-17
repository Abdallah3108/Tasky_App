import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskyapp2/core/widgets/task_list_widget.dart';

import '../../../models/task_model.dart';

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
    final pref = await SharedPreferences.getInstance();

    final finalTask = pref.getString('tasks');
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

      print("taskAfterDecode= $taskAfterDecode");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        automaticallyImplyLeading: false,
      ),
      body: TaskListWidget(
        tasks: completeTasks,
        onTap: (bool? value, int? index) async {
          setState(() {
            completeTasks[index!].isDone = value ?? false;
          });

          final pref = await SharedPreferences.getInstance();

          final allData = pref.getString('tasks');
          if (allData != null) {
            List<TaskModel> allDataList =
                (jsonDecode(allData) as List)
                    .map((e) => TaskModel.fromJson(e))
                    .toList();

            final int newIndex = allDataList.indexWhere(
              (e) => e.id == completeTasks[index!].id,
            );

            allDataList[newIndex] = completeTasks[index!];

            await pref.setString('tasks', jsonEncode(allDataList));

            _loadTasks();
          }
        },
        emptyMessage: 'No Tasks Completed',
      ),
    );
  }
}
