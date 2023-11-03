// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:e_commerce/widget/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> product;
  final String rool;

  ProductDetailsScreen({super.key, required this.product, required this.rool});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selectedIndex = 0;
  String? selectedVarience;
  final user = FirebaseAuth.instance.currentUser;

  void changeSelectedValue() {
    setState(() {
      selectedVarience = widget.product['variant'][0];
    });
  }

  @override
  void initState() {
    super.initState();
    changeSelectedValue();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:
          customAppBar(context: context, backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.3,
              color: const Color(0xFFD9D9D9),
              child: Center(
                child: Image.network(widget.product['image']!),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product['name']!,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${widget.product['price']!}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      widget.product['stock'] == true
                          ? Text(
                              "Available in stock",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.5)),
                            )
                          : Text(
                              "Stock Out",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "About",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.product['description']!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.01),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 45,
              child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: widget.product['variant'].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedVarience = widget.product['variant'][index];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 45,
                        decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? AppColor.primaryColor
                                : null,
                            border: Border.all(
                                color: selectedIndex == index
                                    ? Colors.transparent
                                    : Color(0xFFD8D3D3),
                                width: 1.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            widget.product['variant'][index],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            widget.product['stock'] == true && widget.rool == "user"
                ? CustomButton(
                    btnTitle: "Add To Cart",
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user!.email)
                          .collection('cart')
                          .doc()
                          .set({
                        'user_email': user!.email,
                        'product_id': widget.product['id'],
                        'name': widget.product['name'],
                        'price': widget.product['price'],
                        'image': widget.product['image'],
                        'categories': widget.product['categories'],
                        'variant': selectedVarience,
                        'quantity': 1,
                      }).then((value) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Product successfully added to cart",
                          ),
                        );
                      });
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
