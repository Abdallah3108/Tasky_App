import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/core/theme/theme_controller.dart';
import 'package:taskyapp2/models/task_model.dart';

import '../enums/task_item_actions_enum.dart';
import '../utils/app_colors.dart';
import 'custom_check_box.dart';
import 'custom_elevated_button.dart';
import 'custom_text_form_field.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool?) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              ThemeController.isLight()
                  ? Color(0xffe5ede9)
                  : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) async {
              onChanged(value);
            },
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style:
                      model.isDone
                          ? Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          )
                          : Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style:
                        model.isDone
                            ? Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(fontSize: 14.sp)
                            : Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color:
                  model.isDone
                      ? AppColors.isDoneColor
                      : Theme.of(context).iconTheme.color,
            ),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionsEnum.markTaskAsDone:
                  onChanged(!model.isDone);

                case TaskItemActionsEnum.edit:
                  final result = await _ShowBottomSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }

                case TaskItemActionsEnum.delete:
                  await _showAlertDialog(context);
              }
            },
            itemBuilder:
                (BuildContext context) =>
                    TaskItemActionsEnum.values.map((e) {
                      return PopupMenuItem<TaskItemActionsEnum>(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
          ),
        ],
      ),
    );
  }

  Future<bool?> _ShowBottomSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    TextEditingController taskDescriptionController = TextEditingController(
      text: model.taskDescription,
    );
    GlobalKey<FormState> key = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) setState,
          ) {
            return Padding(
              padding: const EdgeInsets.all(16).r,
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16.h),
                            Text(
                              'Task Name',
                              style: Theme.of(context).textTheme.labelMedium,
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
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            SizedBox(height: 8.h),
                            CustomTextFormField(
                              controller: taskDescriptionController,

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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                      text: 'Edit Task',
                      icon: Icon(Icons.edit, color: AppColors.textColorAtDark),
                      onPressed: () async {
                        if (key.currentState?.validate() ?? false) {
                          final taskJson = PreferencesManager().getString(
                            'tasks',
                          );
                          List<dynamic> listTasks = [];
                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }
                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isDone: model.isDone,
                          );
                          final item = listTasks.firstWhere(
                            (e) => e['id'] == model.id,
                          );
                          final int index = listTasks.indexOf(item);
                          listTasks[index] = newModel.toJson();
                          final taskEncode = jsonEncode(listTasks);
                          await PreferencesManager().setString(
                            'tasks',
                            taskEncode,
                          );
                          Navigator.of(context).pop(true);
                        }
                        // if (_key.currentState!.validate()) {
                        //   // save data at {SharedPrefrence}
                        //   final taskJson = PreferencesManager()
                        //       .getString('tasks');
                        //   List<dynamic> listTasks =
                        //       []; //--> List<Map<String,dynamic>>
                        //   if (taskJson != null) {
                        //     listTasks = jsonDecode(taskJson);
                        //   }
                        //
                        //   TaskModel model = TaskModel(
                        //     id: listTasks.length + 1,
                        //     taskName: taskNameController.text,
                        //     taskDescription:
                        //         taskDescriptionController.text,
                        //     isHighPriority: isHighPriority,
                        //   );
                        //
                        //   listTasks.add(model.toJson());
                        //
                        //   final taskEncode = jsonEncode(listTasks);
                        //   await PreferencesManager().setString(
                        //     'tasks',
                        //     taskEncode,
                        //   );
                        //
                        //   // pref.setString('tasks', jsonEncode(listTasks));
                        //
                        //   final finalTask = PreferencesManager()
                        //       .getString('tasks');
                        //   final taskAfterDecode =
                        //       jsonDecode(finalTask ?? "[]")
                        //           as List<dynamic>;
                        //
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (BuildContext context) {
                        //         return MainScreen();
                        //       },
                        //     ),
                        //   );
                        // }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text('Are you sure,You want to delete this task'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
