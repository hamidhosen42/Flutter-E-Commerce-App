// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:e_commerce/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  bool isConfirmPasswordSecured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Login here",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Welcome back you’ve\nbeen missed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 100,
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
                      height: 20,
                    ),
                    CutomTextField(
                      controller: _passwordController,
                      isRequired: true,
                      hintText: "Password",
                      secured: true,
                      suffixIcon: IconButton(
                          onPressed: () {}, icon: Icon(Icons.visibility)),
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
                      height: 50,
                    ),
                    CustomButton(
                      btnTitle: "Sign In",
                      onTap: () async{
                        if (_formState.currentState!.validate()) {
                          try {
                            await _auth
                                .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const BottomBarScreen()),
                                  (route) => false);
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())));
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
