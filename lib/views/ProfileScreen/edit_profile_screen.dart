// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, avoid_print, unused_import, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../helper/form_helper.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../widget/custom_appbar.dart';
import '../../widget/custom_button.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();

  File? _image;
  final _picker = ImagePicker();

  Future getImageGally() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Picked");
      }
    });
  }

  showUserData({required data}) {
    nameController.text = data['name'];
    emailController.text = data['email'];
    addressController.text = data['address'];

    return SingleChildScrollView(
      child: Column(
        children: [
          CutomTextField(
            controller: nameController,
            isRequired: true,
            hintText: "Name",
          ),
          SizedBox(
            height: 20.h,
          ),
          CutomTextField(
            controller: addressController,
            isRequired: true,
            hintText: "Address",
          ),
          SizedBox(height: 25.h),
          InkWell(
            onTap: () {
              getImageGally();
            },
            child: Container(
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: themeManager.themeMode == ThemeMode.light
                        ? Colors.black
                        : Colors.white),
              ),
              child: _image != null
                  ? Image.file(_image!)
                  : Center(
                      child: data['image'] != ""
                          ? Image.network(data['image'])
                          : Image.asset("assets/avatar.png")),
            ),
          ),
          SizedBox(height: 25.h),
          CustomButton(
            btnTitle: "Update",
            onTap: () async {
              String id = DateTime.now().microsecondsSinceEpoch.toString();
              var ref = FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.email);

              if (_image != null) {
                firebase_storage.Reference ref1 = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/profile/' + id);
                firebase_storage.UploadTask uploadTask = ref1.putFile(_image!);
                await uploadTask.whenComplete(() => null);
                String downloadUrl = await ref1.getDownloadURL();
                ref.update({'image': downloadUrl});
              }

              try {
                ref
                    .update({
                      'name': nameController.text,
                      // 'email': emailController.text,
                      'address': addressController.text,
                    })
                    .then((value) => showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Updated Successfully",
                          ),
                        ))
                    .then(
                      (value) => Navigator.pop(context),
                    );
              } catch (e) {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.success(
                    message: "Something is wrong",
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: themeManager.themeMode == ThemeMode.light
          ? AppColor.fieldBackgroundColor
          : Colors.black12,
      appBar: customAppBar(
          context: context,
          title: "Profile Edit",
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? AppColor.fieldBackgroundColor
              : Colors.black12),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data;
              return showUserData(data: data);
            }
          },
        ),
      ),
    );
  }
}