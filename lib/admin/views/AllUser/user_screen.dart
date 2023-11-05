// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_brace_in_string_interps, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';
import '../OrderScreen/order_screen.dart';


class UserScren extends StatefulWidget {
  const UserScren({super.key});

  @override
  State<UserScren> createState() => _UserScrenState();
}

class _UserScrenState extends State<UserScren> {

  @override
  Widget build(BuildContext context) {
  return Scaffold(
     appBar: customAppBar(
                  context: context,
                  title: "All User",
                  backgroundColor: themeManager.themeMode == ThemeMode.light
                      ? Colors.white
                      : Colors.black12),
    body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                final productData = snapshot.data?.docs ?? [];
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView(
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) {
                        var data = snapshot.data!.docs[index];
                        return Card(
                          color: AppColor.fieldBackgroundColor,
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AdminOrderScreen(
                                            email: data['email'],
                                          )));
                            },
                            
                            title: Text(
                              data['name'],
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(data['email'],
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700)),
                  
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
      ),
    ),
  );
  }
}
