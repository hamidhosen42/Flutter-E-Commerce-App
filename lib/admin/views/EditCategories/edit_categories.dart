// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_build_context_synchronously, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../helper/form_helper.dart';
import '../../../widget/custom_appbar.dart';
import '../../../widget/custom_button.dart';
import '../SeeAllCategories/see_all_screen.dart';

class EditCategories extends StatefulWidget {
  final dynamic categories;
  const EditCategories({required this.categories});

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

class _EditCategoriesState extends State<EditCategories> {
  var _imageController = TextEditingController();
    final _nameController = TextEditingController();

  String? selectedcategoriesValue;

  @override
  void initState() {
    super.initState();
    _imageController.text = widget.categories['icon'];
    _nameController.text = widget.categories['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: "Update Categories"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
               CutomTextField(
                        controller: _nameController,
                        isRequired: true,
                        hintText: "Categories Name",
                      ),
              SizedBox(
                height: 10.h,
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
                  btnTitle: "Update Categories",
                  onTap: () async {
                   try {
                        final data = FirebaseFirestore.instance
                            .collection("categories")
                            .doc(widget.categories['id']);
                        await data.update({
                          'icon': _imageController.text,
                          'name': _nameController.text
                        }).then((value) {
                          showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                message: "Categories Update Successfully",
                              ));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AdminSeeAllScreen()));
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