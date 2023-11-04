// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:e_commerce/views/Authentication/ForgotScreen/forgot_screen.dart';
import 'package:e_commerce/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../admin/views/BottomBavBarView/bottom_view.dart';
import '../../../helper/form_helper.dart';
import '../../../utils/colors.dart';
import '../../BottomBavBarView/bottom_view.dart';
import '../RegisterScreen/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordSecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 120.h,
              ),
              Column(
                children: [
                  Text(
                    "Login here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    "Welcome back you’ve\nbeen missed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                ],
              ),
              Form(
                key: _formState,
                child: Column(
                  children: [
                    CutomTextField(
                      controller: _emailController,
                      isRequired: true,
                      hintText: "Email",
                    ),
                    SizedBox(
                      height: 20.h,
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
                                color: AppColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      btnTitle: "Sign In",
                      onTap: () async {
                        if (_formState.currentState!.validate()) {
                          if (_emailController.text == "admin6403@gmail.com" &&
                              _passwordController.text == "admin6403admin") {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                message: "Admin User Login Successfully",
                              ),
                            );

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const BottomBarAdminScreen()),
                                (route) => false);
                          } else {
                            try {
                              await _auth
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message: "Login Successfully",
                                  ),
                                );
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const BottomBarScreen()),
                                    (route) => false);
                              });
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
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RegisterScreen()));
                      },
                      child: Text(
                        "Create new account",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}