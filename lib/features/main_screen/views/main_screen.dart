import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskyapp2/features/to_do_tasks_screen/views/to_do_tasks_screen.dart';

import '../../../core/utils/app_colors.dart';
import '../../../models/task_model.dart';
import '../../completed_tasks/views/completed_tasks_view.dart';
import '../../home_screen/views/home_view.dart';
import '../../profile_screen/views/profile_screen.dart';

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
    final pref = await SharedPreferences.getInstance();
    final saved = pref.getString('tasks');

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

    final pref = await SharedPreferences.getInstance();
    await pref.setString(
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
      body: _screens[_currentIndex],
    );
  }
}

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:taskyapp2/features/home_screen/views/home_view.dart';
//
// import '../../../core/utils/app_colors.dart';
// import '../../../models/task_model.dart';
// import '../../completed_tasks/views/completed_tasks_view.dart';
// import '../../profile_screen/views/profile_screen.dart';
// import '../../to_do_tasks_screen/views/to_do_tasks_screen.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   final List<Widget> _screens = [
//     HomeView(tasks: tasks, onTap: _updateTask),
//     ToDoScreen(),
//     CompletedTasksView(),
//     ProfileScreen(),
//   ];
//   List<TaskModel> tasks = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }
//
//   void _loadTasks() async {
//     final pref = await SharedPreferences.getInstance();
//     final finalTask = pref.getString('tasks');
//     if (finalTask != null) {
//       final decoded = jsonDecode(finalTask);
//       List<dynamic> taskAfterDecode = [];
//       if (decoded is List)
//         taskAfterDecode = decoded;
//       else if (decoded is Map)
//         taskAfterDecode = [decoded];
//       setState(() {
//         tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
//       });
//     }
//   }
//
//   void _updateTask(int index, bool isDone) async {
//     setState(() {
//       tasks[index].isDone = isDone;
//     });
//     final pref = await SharedPreferences.getInstance();
//     await pref.setString(
//       'tasks',
//       jsonEncode(tasks.map((e) => e.toJson()).toList()),
//     );
//   }
//
//   int _currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     print(_screens[_currentIndex].runtimeType);
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (int? index) {
//           setState(() {
//             _currentIndex = index ?? 0;
//           });
//           print("Current Screen = $_currentIndex");
//         },
//         backgroundColor: AppColors.backgroundDark,
//         unselectedItemColor: Colors.white,
//         selectedItemColor: AppColors.primary,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               'assets/homeicon.svg',
//               colorFilter: ColorFilter.mode(
//                 _currentIndex == 0
//                     ? AppColors.primary
//                     : AppColors.textColorAtDark,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               'assets/todoicon.svg',
//               colorFilter: ColorFilter.mode(
//                 _currentIndex == 1
//                     ? AppColors.primary
//                     : AppColors.textColorAtDark,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: 'To Do',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               'assets/completedtasksicon.svg',
//               colorFilter: ColorFilter.mode(
//                 _currentIndex == 2
//                     ? AppColors.primary
//                     : AppColors.textColorAtDark,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: 'Completed',
//           ),
//           BottomNavigationBarItem(
//             icon: SvgPicture.asset(
//               'assets/profileicon.svg',
//               colorFilter: ColorFilter.mode(
//                 _currentIndex == 3
//                     ? AppColors.primary
//                     : AppColors.textColorAtDark,
//                 BlendMode.srcIn,
//               ),
//             ),
//             label: 'Profile',
//           ),
//         ],
//       ),
//       body: IndexedStack(index: _currentIndex, children: _screens),
//     );
//   }
// }
