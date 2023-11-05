// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, unused_field, prefer_final_fields, prefer_const_constructors, unused_local_variable

import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../main.dart';
import '../../utils/config.dart';

class PrivacyScreen extends StatelessWidget {
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
          title: "Privacy Policy Screen",
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black12),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppConfig.introEng,
                style: TextStyle(
                  color: color,
                ),
                textAlign: TextAlign.justify,
              ),
              10.h.heightBox,
              Text(
                AppConfig.headingEng1,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
              15.h.heightBox,
              customDescriptionText(
                  title: AppConfig.title1Eng, desc: AppConfig.desc1Eng),
              10.h.heightBox,
              10.h.heightBox,
              customDescriptionText(
                  title: AppConfig.title3Eng, desc: AppConfig.desc3Eng),
              10.h.heightBox,
              Text(
                AppConfig.headingEng2,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ),
              10.h.heightBox,
              customDescriptionText(
                  title: AppConfig.title4Eng, desc: AppConfig.desc4Eng),
              10.h.heightBox,
              customDescriptionText(
                  title: AppConfig.title5Eng, desc: AppConfig.desc5Eng),
              10.h.heightBox,
              customDescriptionText(
                  title: AppConfig.title6Eng, desc: AppConfig.desc6Eng),
              10.h.heightBox,
              customDescriptionText(
                  title: AppConfig.title7Eng, desc: AppConfig.desc7Eng),
              10.h.heightBox,
              customDescriptionText(
                  title: AppConfig.title8Eng, desc: AppConfig.desc8Eng),
              10.h.heightBox,
              Text(
                AppConfig.conclusionEng,
                style: TextStyle(
                  color: color,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customDescriptionText({required String title, required String desc}) {
     final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        5.h.heightBox,
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            desc,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w300,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
