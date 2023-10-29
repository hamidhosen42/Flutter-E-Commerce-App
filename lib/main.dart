import 'package:e_commerce/views/BottomBavBarView/bottom_view.dart';
import 'package:flutter/material.dart';

import 'views/SplashScreen/splash_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commarce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true
      ),
      home:const BottomBarScreen(),
    );
  }
}