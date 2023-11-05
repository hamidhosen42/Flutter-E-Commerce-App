// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../../widget/support_field.dart';

class SupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: themeManager.themeMode == ThemeMode.light
          ? Colors.white
          : Colors.black87,
      appBar: customAppBar(
          context: context,
          title: "Support Screen",
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black12),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            children: [
              Text(
                "ShopSavvy support plays a crucial role in the overall success of an ShopSavvy business. Our ShopSavvy support services are designed to ensure a smooth and efficient customer shopping experience.",
                textAlign: TextAlign.justify,
                style: TextStyle(color: color),
              ),
              Divider(
                color: color,
              ),
              Text(
                "If you have any problems , please contact us . We are at your service all the time.",
                style: TextStyle(fontSize: 20.sp, color: color),
              ),
              Divider(
                color: color,
              ),
              supportField("Phone", "01858570332"),
              supportField("E-mail", "mdhamidhosen4@gmail.com"),
              supportField("Facebook", "http://facebook.com"),
            ],
          ),
        ),
      ),
    );
  }
}