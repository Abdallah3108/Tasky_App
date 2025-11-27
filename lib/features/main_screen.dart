import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/features/to_do_tasks_screen.dart';

import '../core/utils/app_colors.dart';
import '../models/task_model.dart';
import 'completed_tasks_view.dart';
import 'home_view.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TaskModel> tasks = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final saved = PreferencesManager().getString('tasks');

    if (saved != null) {
      final decoded = jsonDecode(saved);

      List<dynamic> list = [];
      if (decoded is List) list = decoded;
      if (decoded is Map) list = [decoded];

      setState(() {
        tasks = list.map((e) => TaskModel.fromJson(e)).toList();
      });
    }
  }

  void _updateTask(int index, bool isDone) async {
    setState(() {
      tasks[index].isDone = isDone;
    });

    PreferencesManager().setString(
      'tasks',
      jsonEncode(tasks.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeView(),
      ToDoTasksScreen(),
      CompletedTasksView(),
      ProfileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),

        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/homeicon.svg', 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/todoicon.svg', 1),

            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/completedtasksicon.svg', 2),

            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture('assets/profileicon.svg', 3),

            label: "Profile",
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentIndex]),
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? AppColors.primary : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
