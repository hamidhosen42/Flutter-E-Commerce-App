// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, unused_import, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/views/ProfileScreen/edit_profile_screen.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../Authentication/LoginScreen/login_screen.dart';
import '../CartScreen/oder_screen.dart';
import 'faq_screen.dart';
import 'privacy_policy_screen.dart';
import 'support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? AppColor.fieldBackgroundColor
            : Colors.black87,
        appBar: customAppBar(
            context: context,
            title: "Profile Screen",
            backgroundColor: themeManager.themeMode == ThemeMode.light
                ? AppColor.fieldBackgroundColor
                : Colors.black12),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var data = snapshot.data;
                      return Card(
                        color: themeManager.themeMode == ThemeMode.light
                            ? AppColor.fieldBackgroundColor
                            : Colors.black12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipOval(
                                        clipBehavior: Clip.hardEdge,
                                        child: GestureDetector(
                                          onTap: () async {
                                            //! Use Navigator to show a full-screen image page
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  backgroundColor: color,
                                                  body: Center(
                                                    child: Hero(
                                                        tag: 'user-avatar',
                                                        child: data['image'] !=
                                                                ""
                                                            ? Image.network(
                                                                data['image'],
                                                                height: 80.h,
                                                                width: 80.w,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                "assets/avatar.png",
                                                                height: 80.h,
                                                                width: 80.w,
                                                              )),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                              tag: 'user-avatar',
                                              child: data!['image'] != ""
                                                  ? Image.network(
                                                      data['image'],
                                                      height: 80.h,
                                                      width: 80.w,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      "assets/avatar.png",
                                                      height: 80.h,
                                                      width: 80.w,
                                                    )),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -10,
                                        right: -15,
                                        child: IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProfileEditScreen()));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: color,
                                            size: 25.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20.w),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: Text(
                                          data['name'],
                                          style: TextStyle(
                                              fontSize: 20.sp, color: color),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, bottom: 5),
                                        child: Text(
                                          data['email'],
                                          style: TextStyle(color: color),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, bottom: 5),
                                        child: Text(
                                          data['address'],
                                          style: TextStyle(color: color),
                                        ),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                 Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.payment,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Order',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => OrderScreen()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SupportScreen()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Privacy',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PrivacyScreen()));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'FAQ',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FAQScreen()));
                            },
                            icon: Icon(
                              Icons.question_answer,
                              color: color,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                      bottom: 5,
                      top: 6,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.color_lens,
                              color: color,
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Theme',
                              style: TextStyle(fontSize: 18.sp, color: color),
                            ),
                          ],
                        ),
                        Switch(
                            value: themeManager.themeMode == ThemeMode.dark,
                            activeColor: color,
                            onChanged: (value) async {
                              setState(() {
                                themeManager.toggleTheme(value);
                              });
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                        (route) => false);
                  },
                  child: Card(
                    color: themeManager.themeMode == ThemeMode.light
                        ? AppColor.fieldBackgroundColor
                        : Colors.black12,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 10,
                        bottom: 5,
                        top: 6,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: color,
                                ),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Text(
                                  'LogOut',
                                  style:
                                      TextStyle(fontSize: 18.sp, color: color),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}