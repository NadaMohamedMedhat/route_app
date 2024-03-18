import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_app/style/app_theme.dart';

import '../../style/app_colors.dart';

typedef fieldValidation = String? Function(String? value);

class CustomTextFormField extends StatelessWidget {
  Widget? suffixIcon;
  String hintText;
  TextInputType keyboardType;
  TextEditingController controller;
  bool obscureText;
  fieldValidation validator;

  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    required this.validator,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: AppColors.black),
      cursorColor: AppColors.black,
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: '*',
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        enabled: true,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightPrimaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: AppTheme.lightTheme.textTheme.labelSmall,
      ),
    );
  }
}
