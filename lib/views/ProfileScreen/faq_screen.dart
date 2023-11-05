// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../main.dart';
import '../../utils/config.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeManager.themeMode == ThemeMode.light
          ? Colors.white
          : Colors.black12,
      appBar: customAppBar(
          context: context,
          title: "FAQ Screen",
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black12),
      body: Padding(
        padding: EdgeInsets.all(18.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.h.heightBox,
              customExpansionTile(
                  title: AppConfig.faqTitle1,
                  description: AppConfig.faqDescription1),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: AppConfig.faqTitle2,
                  description: AppConfig.faqDescription2),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: AppConfig.faqTitle3,
                  description: AppConfig.faqDescription3),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: AppConfig.faqTitle4,
                  description: AppConfig.faqDescription4),
              5.h.heightBox,
              Divider(),
              5.h.heightBox,
              customExpansionTile(
                  title: AppConfig.faqTitle5,
                  description: AppConfig.faqDescription5),
            ],
          ),
        ),
      ),
    );
  }

  ExpansionTile customExpansionTile(
      {required String title, required String description}) {
    return ExpansionTile(
      backgroundColor: Colors.grey,
      collapsedTextColor: themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white,
      iconColor:   themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white,
      textColor:   themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white,
      childrenPadding: EdgeInsets.all(10.h),
      title: Text(title),
      children: [
        description.text.black.make(),
      ],
    );
  }
}