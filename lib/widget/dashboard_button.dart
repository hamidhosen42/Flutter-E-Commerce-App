// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/colors.dart';

Widget dashboardButton(
    {required context,
    required String title,
    required String quantity,
    required icon}) {
  var size = MediaQuery.of(context).size.width;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title.text.white.size(14.sp).semiBold.make(),
            quantity.text.white.size(18.sp).semiBold.make(),
          ],
        ),
      ),
      Image.asset(
        icon,
        color: Colors.white,
        width: 40.w,
      )
    ],
  )
      .animatedBox
      .color(AppColor.primaryColor)
      .size(size * 0.45, 80)
      .rounded
      .p8
      .make();
}