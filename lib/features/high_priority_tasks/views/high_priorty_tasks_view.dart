import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/task_list_widget.dart';
import '../../../models/task_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'High Priority Tasks',
          style: TextStyle(fontSize: 20.sp, color: AppColors.textColorAtDark),
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
            final pref = await SharedPreferences.getInstance();

            final allData = pref.getString('tasks');
            if (allData != null) {
              List<TaskModel> allDataList =
                  (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromJson(e))
                      .toList();
              final int newIndex = allDataList.indexWhere(
                (e) => e.id == highPriorityTasks[index!].id,
              );
              allDataList[newIndex] = highPriorityTasks[index!];

              await pref.setString('tasks', jsonEncode(allDataList));
              _loadTasks();
            }
          },
        ),
      ),
    );
  }
}
