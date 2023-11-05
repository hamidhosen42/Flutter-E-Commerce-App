// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce/views/Authentication/LoginScreen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../helper/form_helper.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../widget/custom_button.dart';
import '../../BottomBavBarView/bottom_view.dart';
import '../ForgotScreen/forgot_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPasswordSecured = true;
  bool isConfirmPasswordSecured = true;

  final List<String> items = [
    'Barishal',
    'Chattogram',
    'Dhaka',
    'Khulna',
    'Rajshahi',
    'Rangpur',
    'Mymensingh',
    'Sylhet',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: themeManager.themeMode == ThemeMode.light
          ? Colors.white
          : Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Column(
                  children: [
                    Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: themeManager.themeMode == ThemeMode.light
                              ? AppColor.primaryColor
                              : Colors.white,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Create an account so you can explore all the\nexisting jobs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      CutomTextField(
                          controller: _nameController,
                          hintText: "Name",
                          isRequired: true),
                      SizedBox(
                        height: 15.h,
                      ),
                      CutomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          isRequired: true),
                      SizedBox(
                        height: 15.h,
                      ),
                      DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                            hintText: "Bangladesh District",
                            hintStyle: TextStyle(color: color),
                            filled: true,
                            fillColor: themeManager.themeMode == ThemeMode.light
                                ? AppColor.fieldBackgroundColor
                                : Colors.black,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: themeManager.themeMode ==
                                            ThemeMode.light
                                        ? Colors.transparent
                                        : Colors.white))),
                        items: items
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      // color: color
                                    ),
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "The Field is required";
                          }
                          return null;
                        },
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: themeManager.themeMode == ThemeMode.light
                                ? Colors.black45
                                : Colors.white,
                          ),
                          iconSize: 24.sp,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CutomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                        isRequired: true,
                        secured: isPasswordSecured,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordSecured = !isPasswordSecured;
                              });
                            },
                            icon: isPasswordSecured
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CutomTextField(
                        controller: _confirmPasswordController,
                        hintText: "Confirm Password",
                        isRequired: true,
                        secured: isConfirmPasswordSecured,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordSecured =
                                    !isConfirmPasswordSecured;
                              });
                            },
                            icon: isConfirmPasswordSecured
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ForgotScreen()));
                            },
                            child: Text(
                              "Forgot your password",
                              style: TextStyle(
                                  color:
                                      themeManager.themeMode == ThemeMode.light
                                          ? AppColor.primaryColor
                                          : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                        btnTitle: "Sign Up",
                        onTap: () async {
                          if (_formState.currentState!.validate()) {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: "Password mismatch",
                                  ));
                            } else {
                              try {
                                await _auth.createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                                //! User data get

                                final userData = await FirebaseFirestore
                                    .instance
                                    .collection("users")
                                    .where("email",
                                        isEqualTo: _emailController.text)
                                    .get();

                                if (userData.docs.isEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(_emailController.text)
                                      .set({
                                    'email': _emailController.text,
                                    'name': _nameController.text,
                                    'uid':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    "address": selectedValue.toString(),
                                    "image": "",
                                  }).then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const BottomBarScreen()));

                                    showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.success(
                                          message: "SignUp Successfully",
                                        ));
                                  });
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(_emailController.text)
                                      .update({
                                    'email': _emailController.text,
                                    'name': _nameController.text,
                                    'uid':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    "address": selectedValue.toString(),
                                    "image": "",
                                  }).then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const BottomBarScreen()));

                                    showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message: "SignUp Successfully",
                                      ),
                                    );
                                  });
                                }
                              } catch (e) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.error(
                                    message: e.toString(),
                                  ),
                                );
                              }
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        child: Text(
                          "Already have an account",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: color),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}