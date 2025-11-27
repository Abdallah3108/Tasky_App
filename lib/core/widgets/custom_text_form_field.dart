import 'package:flutter/material.dart';

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
        decoration: InputDecoration(hintText: hintText, labelText: labelText),
        style: TextStyle(color: Theme.of(context).textTheme.labelMedium!.color),
      ),
    );
  }
}
