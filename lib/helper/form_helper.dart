// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../main.dart';
import '../utils/colors.dart';

class CutomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool? secured;
  final Widget? suffixIcon;
  final bool? isRequired;
  final TextEditingController? controller;
  const CutomTextField(
      {super.key,
      required this.hintText,
      this.keyboardType,
      this.secured,
      this.suffixIcon,
      this.isRequired,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: secured ?? false,
      validator: isRequired == true
          ? (value) {
              if (value!.isEmpty) {
                return "The Field is required";
              }
              return null;
            }
          : null,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          color: themeManager.themeMode == ThemeMode.light
              ? Colors.black
              : Colors.white),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: themeManager.themeMode == ThemeMode.light
              ? Colors.black
              : Colors.white),
          filled: true,
          fillColor: themeManager.themeMode == ThemeMode.light
              ? AppColor.fieldBackgroundColor
              : Colors.black87,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: themeManager.themeMode == ThemeMode.light
                    ? Colors.transparent
                    : Colors.white,
              ))),
    );
  }
}
