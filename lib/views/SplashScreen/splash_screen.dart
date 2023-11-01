// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';

import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/config.dart';
import 'package:e_commerce/views/Authentication/LoginScreen/login_screen.dart';
import 'package:e_commerce/views/BottomBavBarView/bottom_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // ! ---To go to the next screen and cancel all previous routes (Get.to)
      user.authStateChanges().listen((event) {
        if (event == null && mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const BottomBarScreen()),
              (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(),
            Image.asset(
              "assets/images/splash_screen.png",
              width: size.width * 0.8,
            ),
            Column(
              children: [
                Text(
                  AppConfig.appName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Version: 1.0",
                  style: TextStyle(
                      fontSize: 20.sp,
                      letterSpacing: 1,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}