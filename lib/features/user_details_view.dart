import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskyapp2/core/services/preferences_manager.dart';

import '../core/utils/app_colors.dart';
import '../core/widgets/custom_elevated_button.dart';
import '../core/widgets/custom_text_form_field.dart';

class UserDetailsView extends StatefulWidget {
  UserDetailsView({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String motivationQuote;

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final TextEditingController newUsernameController = TextEditingController();

  final TextEditingController motivationQuoteController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    newUsernameController.text = widget.userName;
    motivationQuoteController.text = widget.motivationQuote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          'Usr Details',
          style: TextStyle(fontSize: 20.sp, color: AppColors.textColorAtDark),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User Name',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColorAtDark,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                hintText: 'Abdallah Ashraf',

                controller: newUsernameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your New User Name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Motivation Quote',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColorAtDark,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: motivationQuoteController,
                hintText: 'One task at a time. One step closer',
                height: 160.h,

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your Motivation Quote';
                  }
                },
              ),
              Spacer(),
              CustomElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await PreferencesManager().setString(
                      'username',
                      newUsernameController.value.text,
                    );
                    await PreferencesManager().setString(
                      'motivationQuote',
                      motivationQuoteController.value.text,
                    );

                    // final pref = await SharedPreferences.getInstance();
                    // pref.setString(
                    //   'username',
                    //   newUsernameController.value.text,
                    // );
                    // pref.setString(
                    //   'motivationQuote',
                    //   motivationQuoteController.value.text,
                    // );
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) {
                    //       return ProfileScreen();
                    //     },
                    //   ),
                    // );
                    Navigator.pop(context, true);
                  }
                },
                text: 'Save Changes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
