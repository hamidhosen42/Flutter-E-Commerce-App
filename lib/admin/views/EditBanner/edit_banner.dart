// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../helper/form_helper.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_button.dart';
import '../Banner/banner_screen.dart';

class EditBanners extends StatefulWidget {
  final dynamic banners;
  const EditBanners({required this.banners});

  @override
  State<EditBanners> createState() => _EditBannersState();
}

class _EditBannersState extends State<EditBanners> {
  var _imageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: "Update banners"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              CutomTextField(
                controller: _imageController,
                isRequired: true,
                hintText: "Image Link",
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                  btnTitle: "Update Banner",
                  onTap: () async {
                   try {
                        final data = FirebaseFirestore.instance
                            .collection("banners")
                            .doc(widget.banners['id']);
                        await data.update({
                          'image': _imageController.text,
                        }).then((value) {
                          showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                message: "Banners Update Successfully",
                              ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BannerScreen()));
                        });
                      } catch (e) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: e.toString(),
                          ),
                        );
                      }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}