// ignore_for_file: unused_field, use_build_context_synchronously, prefer_const_constructors, avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../helper/form_helper.dart';
import '../../../widget/custom_button.dart';

class AddCategorieScreen extends StatefulWidget {
  const AddCategorieScreen({super.key});

  @override
  State<AddCategorieScreen> createState() => _AddCategorieScreenState();
}

class _AddCategorieScreenState extends State<AddCategorieScreen> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  final _nameController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Sategories",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                  key: _formState,
                  child: Column(
                    children: [
                      CutomTextField(
                        controller: _nameController,
                        isRequired: true,
                        hintText: "Categories Name",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CutomTextField(
                        controller: _imageController,
                        isRequired: true,
                        hintText: "Image Link",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // !=============== Add categories botton ===================
                      CustomButton(
                          btnTitle: "Add Categorie",
                          onTap: () async {
                            if (_formState.currentState!.validate()) {
                              try {
                                final data = FirebaseFirestore.instance
                                    .collection("categories")
                                    .doc();
                                await data.set({
                                  'id': data.id.toString(),
                                  'name': _nameController.text,
                                  'icon': _imageController.text,
                                }).then((value) {
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message:
                                            "Categories Added Successfully",
                                      ));

                                  _nameController.clear();
                                  _imageController.clear();
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
                          }),
                    ],
                  )),
            ),
          ),
        ));
  }
}