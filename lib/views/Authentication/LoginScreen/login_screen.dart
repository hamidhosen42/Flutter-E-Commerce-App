// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:e_commerce/widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../helper/form_helper.dart';
import '../../../utils/colors.dart';
import '../../BottomBavBarView/bottom_view.dart';
import '../RegisterScreen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      body: Padding(
        padding: EdgeInsets.all(20),
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
              ],
            ),
            Column(
              children: [
                CutomTextField(
                  hintText: "Email",
                ),
                SizedBox(
                  height: 20,
                ),
                CutomTextField(
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
                  height: 30,
                ),
                CustomButton(
                  btnTitle: "Sign In",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BottomBarScreen()));
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()));
                  },
                  child: Text(
                    "Create new account",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}