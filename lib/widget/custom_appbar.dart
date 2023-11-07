// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

PreferredSizeWidget customAppBar(
    {String? title,
    List<Widget>? action,
    Widget? isLeading,
    required BuildContext context,
    
    Color? backgroundColor}) {
  return AppBar(
    
    backgroundColor: backgroundColor,
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: isLeading ??
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color:themeManager.themeMode == ThemeMode.light
      ? Colors.black
      : Colors.white,)),
    title: title != null ? Text(title) : null,
    titleTextStyle: TextStyle(color: themeManager.themeMode == ThemeMode.light
      ? Colors.black
      : Colors.white,fontSize: 20.sp),
    actions:action,
  );
}
