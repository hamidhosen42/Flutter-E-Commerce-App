// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:e_commerce/views/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../CartScreen/cart_screen.dart';
import '../FavouriteScreen/favourite_screen.dart';
import '../ProfileScreen/profile_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int selectedIndex = 0;
  List<Widget> screen = [
    HomeScreen(),
    FavouriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
  final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
      body: screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: color,
           type: BottomNavigationBarType.fixed, // Fixed 
         backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black, 
          unselectedItemColor:themeManager.themeMode == ThemeMode.light
            ?  Colors.black.withOpacity(0.5):Colors.grey[700],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ]),
    );
  }
}