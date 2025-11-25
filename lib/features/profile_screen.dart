import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/features/user_details_view.dart';
import 'package:taskyapp2/features/welcome_screen.dart';

import '../core/utils/app_colors.dart';
import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  late String motivationQuote;
  bool isLoading = true;
  bool isDarkMode = true;

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
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.textColorAtDark,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/person.png'),
                          backgroundColor: Colors.transparent,
                          radius: 55,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                color: AppColors.backgroundDark,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
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
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: AppColors.textColorAtDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    motivationQuote ?? "One task at a time. One step closer.",
                    style: TextStyle(
                      fontSize: 16.sp,

                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                'Profile Info',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.textColorAtDark,
                  fontWeight: FontWeight.w400,
                ),
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
                leading: SvgPicture.asset('assets/personicon.svg'),
                title: Text(
                  'User Details',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textColorAtDark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: SvgPicture.asset('assets/arrowright.svg'),
              ),
              Divider(color: AppColors.secondaryTextColorAtDark, thickness: 1),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: SvgPicture.asset('assets/darkmodeicon.svg'),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textColorAtDark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    /// TODO: Change Theme
                    setState(() {
                      isDarkMode = value;
                      if (isDarkMode) {
                        themeNotifier.value = ThemeMode.dark;
                      } else {
                        themeNotifier.value = ThemeMode.light;
                      }
                    });
                  },
                ),
              ),
              Divider(color: AppColors.secondaryTextColorAtDark, thickness: 1),

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
                leading: SvgPicture.asset('assets/logout.svg'),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textColorAtDark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: SvgPicture.asset('assets/arrowright.svg'),
              ),
            ],
          ),
        );
  }
}
