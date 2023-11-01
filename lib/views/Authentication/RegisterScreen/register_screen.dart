// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/views/Authentication/LoginScreen/login_screen.dart';
import 'package:e_commerce/views/BottomBavBarView/bottom_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../helper/form_helper.dart';
import '../../../utils/colors.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isPasswordSecured = true;
  bool isConfirmPasswordSecured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.primaryColor,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an account so you can explore all the\nexisting jobs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      CutomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          isRequired: true),
                      SizedBox(
                        height: 20,
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
                        height: 20,
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot your password",
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        btnTitle: "Sign Up",
                        onTap: () async {
                          if (_formState.currentState!.validate()) {
                            if (_passwordController.text !=
                                _confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Password mismatch")));
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
                                  }).then((value) {
                                     Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const BottomBarScreen()));
                                  });
                                } else {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(_emailController.text)
                                      .update({
                                    'email': _emailController.text,
                                  }).then((value) {
                                     Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()));
                                  });
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                        },
                        child: Text(
                          "Already have an account",
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
      ),
    );
  }
}
