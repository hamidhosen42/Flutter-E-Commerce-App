// ignore_for_file: unused_field, use_build_context_synchronously, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../helper/form_helper.dart';
import '../../../utils/colors.dart';
import '../../../widget/custom_button.dart';
import '../BottomBavBarView/bottom_view.dart';

class EditProductScreen extends StatefulWidget {
  final dynamic product;
  const EditProductScreen({required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  var _nameController = TextEditingController();
  var _priceController = TextEditingController();
  var _imageController = TextEditingController();
  final _discountController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> variantItems = [
    '20',
    '25',
    '30',
    '35',
    '40',
    '45',
    '50',
  ];
  final List<String> stockItems = [
    'Stock Out',
    'Available in stock',
  ];

  String? selectedValue;
  List<dynamic> selectedVariantItems = [];
  String? selectedcategoriesValue;

  void changeSelectedValue() {
    setState(() {
      selectedVariantItems = widget.product['variant'];
      selectedValue =
          widget.product['stock'] == true ? 'Available in stock' : 'Stock Out';
          selectedcategoriesValue=widget.product['categories'];
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product['name'];
    _priceController.text = widget.product['price'];
    _imageController.text = widget.product['image'];
    _discountController.text = widget.product['discount'];
    _descriptionController.text = widget.product['description'];

    changeSelectedValue();
  }

  bool isPasswordSecured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context: context, title: "Update Product"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
                key: _formState,
                child: Column(
                  children: [
                    CutomTextField(
                      controller: _nameController,
                      isRequired: true,
                      hintText: "Name",
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CutomTextField(
                      controller: _priceController,
                      isRequired: true,
                      hintText: "Price",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CutomTextField(
                      controller: _imageController,
                      isRequired: true,
                      hintText: "Image Link",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CutomTextField(
                      controller: _discountController,
                      isRequired: true,
                      hintText: "Discount",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      minLines: 1,
                      maxLines: 4,
                      maxLength: 2000,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "The Field is required";
                        }
                        return null;
                      },
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                          hintText: "Description",
                          filled: true,
                          fillColor: AppColor.fieldBackgroundColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        return DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                              hintText: "Select Your Categories",
                              filled: true,
                              fillColor: AppColor.fieldBackgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                          items: snapshot.data!.docs
                              .map((item) => DropdownMenuItem<String>(
                                    value: item['name'],
                                    child: Text(
                                      item['name'],
                                      style: TextStyle(
                                        fontSize: 14.sp,
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
                          value: selectedcategoriesValue,
                          onChanged: (String? value) {
                            setState(() {
                              selectedcategoriesValue = value;
                            });
                          },
                          iconStyleData: IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
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
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                          hintText: "Select Your Stock",
                          filled: true,
                          fillColor: AppColor.fieldBackgroundColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.transparent))),
                      items: stockItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontSize: 14.sp,
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
                          color: Colors.black45,
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
                      height: 10.h,
                    ),
                    Container(
                      height: 65,
                      decoration: BoxDecoration(
                          color: AppColor.fieldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all()),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Vaiant Size',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: variantItems.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      selectedVariantItems.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? selectedVariantItems.remove(item)
                                          : selectedVariantItems.add(item);
                                      //This rebuilds the StatefulWidget to update the button's text
                                      setState(() {});
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: selectedVariantItems.isEmpty
                              ? null
                              : selectedVariantItems.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return variantItems.map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    selectedVariantItems.join(', '),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 2,
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // !=============== Edit Product botton ===================
                    CustomButton(
                        btnTitle: "Update Product",
                        onTap: () async {
                          if (_formState.currentState!.validate()) {
                            try {
                              final data = FirebaseFirestore.instance
                                  .collection("products")
                                  .doc(widget.product['id']);
                              await data.update({
                                'name': _nameController.text,
                                'price': _priceController.text,
                                'image': _imageController.text,
                                'discount': _discountController.text,
                                'description': _descriptionController.text,
                                'stock':
                                    selectedValue == "Stock Out" ? false : true,
                                'variant': selectedVariantItems.toList(),
                                'categories':selectedcategoriesValue
                              }).then((value) {
                                showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(
                                      message: "Product Update Successfully",
                                    ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BottomBarAdminScreen()));
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
        ));
  }
}