// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_brace_in_string_interps, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .doc(user!.email)
            .collection("order")
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
              backgroundColor: themeManager.themeMode == ThemeMode.light
                  ? AppColor.fieldBackgroundColor
                  : Colors.black87,
              appBar: customAppBar(
                  context: context,
                  title: "My Order",
                  backgroundColor: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.black12),
              body: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                          height: 70.h,
                          decoration: BoxDecoration(
                              color: Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Center(
                                      child: Image.network(
                                          data['item'][0]['image'])),
                                  height: 60.h,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['item'][0]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp),
                                    ),
                                    Text(
                                      "\$${data['amount']}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['gtName'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColor.primaryColor)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: data['delivery'] == false
                                            ? Text(
                                                "Pending",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                            : Text(
                                                "Success",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    );
                  }),
            );
          }
        }));
  }
}
