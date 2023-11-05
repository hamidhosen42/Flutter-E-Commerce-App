// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/views/Authentication/RegisterScreen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../Authentication/LoginScreen/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: themeManager.themeMode == ThemeMode.light
          ? Colors.white
          : Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Image.asset(
                "assets/images/get_started.png",
                width: size.width * 0.8,
              ),
              Column(
                children: [
                  Text(
                    "Discover Your Dream Job here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: themeManager.themeMode == ThemeMode.light
                            ? AppColor.primaryColor
                            : Colors.white,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Explore all the existing job roles based on your interest and study major",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: themeManager.themeMode == ThemeMode.light
                          ? Colors.black.withOpacity(0.5)
                          : Colors.white38,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.primaryColor.withOpacity(0.3),
                                  blurRadius: 3)
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterScreen()));
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
