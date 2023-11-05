import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

Widget supportField(title, value) {
  final color =
      themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
  TextEditingController supportDataController =
      TextEditingController(text: value);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 20.sp, color: color),
      ),
      TextField(
        controller: supportDataController,
        readOnly: true,
        style: TextStyle(
            color: themeManager.themeMode == ThemeMode.light
                ? Colors.black
                : Colors.white),
      ),
      SizedBox(
        height: 20.h,
      ),
    ],
  );
}