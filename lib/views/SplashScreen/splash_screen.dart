import 'dart:async';

import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/config.dart';
import 'package:flutter/material.dart';

import '../WelcomeScreen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    
    Timer(const Duration(seconds: 3), () { 
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const WelcomeScreen()), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Text(
          AppConfig.appName,
          style:const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
