import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/task_list_widget.dart';
import '../../../models/task_model.dart';
import '../../add_task_view/views/add_task_view.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? username;
  List<TaskModel> tasks = [];
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTasks();
  }

  void _loadUserName() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username');
    });
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
        tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      });

      print("taskAfterDecode= $taskAfterDecode");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      floatingActionButton: SizedBox(
        width: 167.w,
        height: 40.h,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.primary,
          label: Text(
            'Add New Task',
            style: TextStyle(color: AppColors.textColorAtDark),
          ),
          icon: Icon(Icons.add, color: AppColors.textColorAtDark),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskView();
                },
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/person.png'),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening ,${username} ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColorAtDark,
                        ),
                      ),
                      Text(
                        'One task at a time.One step closer.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryTextColorAtDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Yuhuu ,Your work Is',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColorAtDark,
                ),
              ),
              Row(
                children: [
                  Text(
                    'almost done ! ',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColorAtDark,
                    ),
                  ),
                  SvgPicture.asset('assets/hand.svg'),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'My Tasks',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColorAtDark,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: TaskListWidget(
                  emptyMessage: 'No Tasks',
                  tasks: tasks,
                  onTap: (bool? value, int? index) async {
                    setState(() {
                      tasks[index!].isDone = value ?? false;
                    });
                    final pref = await SharedPreferences.getInstance();
                    final updatedTask = tasks.map((e) => e.toJson()).toList();
                    await pref.setString('tasks', jsonEncode(updatedTask));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
