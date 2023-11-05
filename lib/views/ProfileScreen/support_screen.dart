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
                "The FlutterChittagong Bhromon App is a versatile mobile application designed to SupportScreen tourists exploring Chittagong, Bangladesh. It provides a user-friendly platform with various features to assist users in planning and enjoying their visit to the city. The app includes secure email verification authentication and profile updates to ensure user security. It offers a comprehensive list of popular tourist spots, complete with detailed overviews, images, and ratings, allowing users to browse and choose their preferred destinations. Each spot has dedicated screens with in-depth information, including historical significance and visitor tips, enhancing the user's knowledge and experience. The app also highlights local culinary delights in the food item section, providing tourists with an opportunity to explore the local cuisine. Additionally, the app includes an admin panel that enables administrators to easily add new tourist spots, ensuring the app stays up to date with the latest attractions. Overall, the FlutterChittagong Bhromon App aims to provide a comprehensive and user-friendly platform for tourists to plan and enjoy their visit to Chittagong.",
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
              supportField("Phone", "01858570337"),
              supportField("E-mail", "hamidhosen8444@mail.com"),
              supportField("Facebook", "http://facebook.com"),
            ],
          ),
        ),
      ),
    );
  }
}