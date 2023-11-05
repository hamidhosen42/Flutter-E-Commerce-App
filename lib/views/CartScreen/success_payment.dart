// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../BottomBavBarView/bottom_view.dart';

class SuccessPaymentScreen extends StatefulWidget {
  const SuccessPaymentScreen({super.key});

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
       Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomBarScreen ()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: themeManager.themeMode == ThemeMode.light
          ? AppColor.primaryColor
          : Colors.black12,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            Image.asset(
              "assets/images/successful.png",
              width: size.width * 0.8,
            ),
          ],
        ),
      ),
    );
  }
}