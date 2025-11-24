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
        backgroundColor: AppColors.backgroundDark,
        unselectedItemColor: Colors.white,
        selectedItemColor: AppColors.primary,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/homeicon.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 0
                    ? AppColors.primary
                    : AppColors.textColorAtDark,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/todoicon.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 1
                    ? AppColors.primary
                    : AppColors.textColorAtDark,
                BlendMode.srcIn,
              ),
            ),
            label: "To Do",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/completedtasksicon.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 2
                    ? AppColors.primary
                    : AppColors.textColorAtDark,
                BlendMode.srcIn,
              ),
            ),
            label: "Completed",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/profileicon.svg",
              colorFilter: ColorFilter.mode(
                _currentIndex == 3
                    ? AppColors.primary
                    : AppColors.textColorAtDark,
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentIndex]),
    );
  }
}
