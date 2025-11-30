import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/core/theme/theme_controller.dart';
import 'package:taskyapp2/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp2/features/user_details_view.dart';
import 'package:taskyapp2/features/welcome_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  late String motivationQuote;
  bool isLoading = true;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      username = PreferencesManager().getString('username') ?? '';
      motivationQuote =
          PreferencesManager().getString('motivationQuote') ??
          'One task at a time. One step closer.';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  'My Profile',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 20.sp),
                ),
              ),
              SizedBox(height: 16.h),
              Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              _selectedImage == null
                                  ? AssetImage('assets/person.png')
                                  : FileImage(_selectedImage!),
                          backgroundColor: Colors.transparent,
                          radius: 55,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              XFile? image = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image != null) {
                                setState(() {
                                  _selectedImage = File(image.path);
                                });
                              }
                            },
                            child: Container(
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                // color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    username ?? "",
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    motivationQuote ?? "One task at a time. One step closer.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                'Profile Info',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 8.h),

              ListTile(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return UserDetailsView(
                          userName: username ?? "",
                          motivationQuote: motivationQuote ?? "",
                        );
                      },
                    ),
                  );
                  if (result != null && result) {
                    _loadData();
                  }
                },
                contentPadding: EdgeInsets.zero,
                leading: CustomSvgPicture(
                  path: 'assets/personicon.svg',
                  withColorFilter: true,
                ),

                title: Text('User Details'),
                trailing: CustomSvgPicture(
                  path: 'assets/arrowright.svg',
                  withColorFilter: true,
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CustomSvgPicture(
                  path: 'assets/darkmodeicon.svg',
                  withColorFilter: true,
                ),

                title: Text('Dark Mode'),
                trailing: ValueListenableBuilder(
                  valueListenable: ThemeController.themeNotifier,
                  builder: (BuildContext context, value, Widget? child) {
                    return Switch(
                      value: value == ThemeMode.dark,
                      onChanged: (bool value) async {
                        ThemeController.toggleTheme();
                      },
                    );
                  },
                ),
              ),
              Divider(),

              ListTile(
                onTap: () async {
                  PreferencesManager().remove('username');
                  PreferencesManager().remove('motivationQuote');
                  PreferencesManager().remove('tasks');

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return WelcomeScreen();
                      },
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                contentPadding: EdgeInsets.zero,
                leading: CustomSvgPicture(
                  path: 'assets/logout.svg',
                  withColorFilter: true,
                ),

                title: Text('Log Out'),
                trailing: CustomSvgPicture(
                  path: 'assets/arrowright.svg',
                  withColorFilter: true,
                ),
              ),
            ],
          ),
        );
  }
}
