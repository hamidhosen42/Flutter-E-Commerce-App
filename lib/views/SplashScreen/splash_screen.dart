// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';

import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/config.dart';
import 'package:e_commerce/views/Authentication/LoginScreen/login_screen.dart';
import 'package:e_commerce/views/BottomBavBarView/bottom_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  user != null ? const BottomBarScreen() : LoginScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Text(
          AppConfig.appName,
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}