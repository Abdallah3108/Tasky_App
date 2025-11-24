import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/models/task_model.dart';

import '../core/services/preferences_manager.dart';
import '../core/utils/app_colors.dart';
import '../core/widgets/custom_elevated_button.dart';
import '../core/widgets/custom_text_form_field.dart';
import 'main_screen.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  bool isHighPriority = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('New Task'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   color: AppColors.textColorAtDark,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Name',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColorAtDark,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextFormField(
                        controller: taskNameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please Enter Your Task Name';
                          }
                          return null;
                        },
                        hintText: 'Finish UI design for login screen',
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Task Description',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColorAtDark,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextFormField(
                        controller: taskDescriptionController,

                        // validator: (value) {
                        //   if (value == null || value.trim().isEmpty) {
                        //     return 'Please Enter Your Task Description';
                        //   }
                        //   return null;
                        // },
                        height: 160.h,
                        hintText:
                            'Finish onboarding UI and hand off to devs by Thursday.',
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "High Priority",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColorAtDark,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 52.sp,
                            height: 32.sp,
                            child: Switch(
                              value: isHighPriority,
                              onChanged: (bool value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CustomElevatedButton(
                text: 'Add Task',
                icon: Icon(Icons.add, color: AppColors.textColorAtDark),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // save data at {SharedPrefrence}
                    final taskJson = PreferencesManager().getString('tasks');
                    List<dynamic> listTasks =
                        []; //--> List<Map<String,dynamic>>
                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }

                    TaskModel model = TaskModel(
                      id: listTasks.length + 1,
                      taskName: taskNameController.text,
                      taskDescription: taskDescriptionController.text,
                      isHighPriority: isHighPriority,
                    );

                    listTasks.add(model.toJson());

                    final taskEncode = jsonEncode(listTasks);
                    await PreferencesManager().setString('tasks', taskEncode);

                    // pref.setString('tasks', jsonEncode(listTasks));

                    final finalTask = PreferencesManager().getString('tasks');
                    final taskAfterDecode =
                        jsonDecode(finalTask ?? "[]") as List<dynamic>;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return MainScreen();
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
