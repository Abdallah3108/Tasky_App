import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/core/widgets/custom_text_form_field.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/custom_elevated_button.dart';
import 'main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16).r,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/logo.svg',
                        width: 42.w,
                        height: 42.h,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Tasky',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColorAtDark,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 108.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky ',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColorAtDark,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/hand.svg',
                        width: 28.w,
                        height: 28.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your productivity journey starts here.',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColorAtDark,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SvgPicture.asset(
                    'assets/pana.svg',
                    width: 215.w,
                    height: 204.h,
                  ),
                  SizedBox(height: 28.h),
                  CustomTextFormField(
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please Enter Your Full Name';
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                    hintText: 'e.g. Abdallah Ashraf',
                    labelText: 'Full Name ',
                  ),
                  SizedBox(height: 24.h),
                  CustomElevatedButton(
                    text: "Let's Get Started",
                    width: double.infinity,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await PreferencesManager().setString(
                          'username',
                          nameController.value.text,
                        );

                        String? username = PreferencesManager().getString(
                          'username',
                        );

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
        ),
      ),
    );
  }
}
