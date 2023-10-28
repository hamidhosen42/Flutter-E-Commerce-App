// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CutomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool? secured;
  final Widget? suffixIcon;
  const CutomTextField(
      {super.key,
      required this.hintText,
      this.keyboardType,
      this.secured,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: secured ?? false,
      style: TextStyle(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: AppColor.fieldBackgroundColor,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.transparent))),
    );
  }
}
