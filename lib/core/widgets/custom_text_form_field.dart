import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.validator,
    this.width,
    this.height,
  });

  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        validator: validator,
        controller: controller,
        textAlignVertical: TextAlignVertical.top,
        expands: height != null,
        maxLines: height == null ? 1 : null,
        minLines: height == null ? 1 : null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff6D6D6D)),
          labelText: labelText,
          labelStyle: TextStyle(
            color: AppColors.textColorAtDark,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: AppColors.textFormFieldColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        cursorColor: Colors.white,
        style: TextStyle(color: AppColors.textColorAtDark),
      ),
    );
  }
}
