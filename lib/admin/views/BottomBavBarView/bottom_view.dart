// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';

import '../AddCategories/add_categories.dart';
import '../AddProduct/add_product.dart';
import '../AllUser/user_screen.dart';
import '../HomeScree/home_screen.dart';

class BottomBarAdminScreen extends StatefulWidget {
  const BottomBarAdminScreen({super.key});

  @override
  State<BottomBarAdminScreen> createState() => _BottomBarAdminScreenState();
}

class _BottomBarAdminScreenState extends State<BottomBarAdminScreen> {
  int selectedIndex = 0;
  List<Widget> screen = [
    AdminHomeScreen(),
    AddProductScreen(),
    AddCategorieScreen(),
    UserScren(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: AppColor.primaryColor,
          // showUnselectedLabels: false,
          // showSelectedLabels: false,
          unselectedItemColor: Colors.black.withOpacity(0.5),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.add), label: "Add Product"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "Add Categorie"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
          ]),
    );
  }
}