import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/task_list_widget.dart';
import '../../../models/task_model.dart';

class ToDoTasksScreen extends StatefulWidget {
  const ToDoTasksScreen({super.key});

  @override
  State<ToDoTasksScreen> createState() => _ToDoTasksScreenState();
}

class _ToDoTasksScreenState extends State<ToDoTasksScreen> {
  List<TaskModel> todoTasks = [];

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
        todoTasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        todoTasks =
            todoTasks.where((element) => element.isDone == false).toList();
      });

      print("taskAfterDecode= $taskAfterDecode");
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
            'To Do Tasks',
            style: TextStyle(fontSize: 20.sp, color: AppColors.textColorAtDark),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TaskListWidget(
              emptyMessage: 'To Do Tasks Is Empty',
              tasks: todoTasks,
              onTap: (bool? value, int? index) async {
                setState(() {
                  todoTasks[index!].isDone = value ?? false;
                });
                final pref = await SharedPreferences.getInstance();

                final allData = pref.getString('tasks');
                if (allData != null) {
                  List<TaskModel> allDataList =
                      (jsonDecode(allData) as List)
                          .map((e) => TaskModel.fromJson(e))
                          .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == todoTasks[index!].id,
                  );
                  allDataList[newIndex] = todoTasks[index!];

                  await pref.setString('tasks', jsonEncode(allDataList));
                  _loadTasks();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
