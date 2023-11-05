// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../../utils/colors.dart';
import '../ProductsByCategory/pbc_screen.dart';

class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,
      appBar: customAppBar(context: context, title: "All Top Categories",            backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: StreamBuilder(
            stream: fireStore.collection('categories').snapshots(),
            builder: (_, snapshot) {
              final data = snapshot.data?.docs ?? [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              } else {
                return GridView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductByCategory(
                                      category: data[index])));
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                border: Border.all(color: Color(0xFFD8D3D3)),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    data[index]['icon']!,
                                    height: 80.h,
                                    width: 60.w,
                                  ),
                                  Text(data[index]['name'],)
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}