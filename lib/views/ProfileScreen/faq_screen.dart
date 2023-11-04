// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../utils/config.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: "FAG"),
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
      // backgroundColor: Colors.grey[400],
      collapsedTextColor: Colors.black,
      iconColor: Colors.black,
      textColor: Colors.black,
      childrenPadding: EdgeInsets.all(10.h),
      title: Text(title),
      children: [
        description.text.black.make(),
      ],
    );
  }
}