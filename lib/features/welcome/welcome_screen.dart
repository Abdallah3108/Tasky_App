import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';
import 'package:taskyapp2/core/widgets/custom_svg_picture.dart';
import 'package:taskyapp2/core/widgets/custom_text_form_field.dart';

import '../../core/widgets/custom_elevated_button.dart';
import '../navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16).r,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0).r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSvgPicture(
                          path: 'assets/logo.svg',
                          withColorFilter: false,
                          width: 42.w,
                          height: 42.h,
                        ),

                        SizedBox(width: 16.w),
                        Text(
                          'Tasky',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 118.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To Tasky ',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      CustomSvgPicture(
                        path: 'assets/hand.svg',
                        withColorFilter: false,
                        width: 28.w,
                        height: 28.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your productivity journey starts here.',
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 24.h),
                  CustomSvgPicture(
                    path: 'assets/pana.svg',
                    withColorFilter: false,
                    width: 215.w,
                    height: 200.h,
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
