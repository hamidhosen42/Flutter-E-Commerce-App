// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_brace_in_string_interps, use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/views/CartScreen/payment_screen.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../main.dart';
import '../../widget/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List<QueryDocumentSnapshot> cartItem = [];

  double totalAmount = 0.0;

  double calculatetotalAmount(List<QueryDocumentSnapshot> cartItem) {
    double finalAmount = 0.0;
    for (var data in cartItem) {
      double price = double.parse(data['price']);
      int quantity = data['quantity'];
      finalAmount += price * quantity;
    }
    return finalAmount;
  }

  // final bkash = FlutterBkash(
  //     bkashCredentials: BkashCredentials(
  //   username: "sandboxTokenizedUser02",
  //   password: "sandboxTokenizedUser02@12345",
  //   appKey: "4f6o0cjiki2rfm34kfdadl1eqq",
  //   appSecret: "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
  //   isSandbox: true, //!real work false
  // ));

  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user!.email)
            .collection("cart")
            .snapshots(),
        builder: ((context, snapshot) {
          cartItem = snapshot.data?.docs ?? [];
          final amount = calculatetotalAmount(cartItem);
          totalAmount = amount;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
                backgroundColor: themeManager.themeMode == ThemeMode.light
                    ? AppColor.fieldBackgroundColor
                    : Colors.black,
                appBar: customAppBar(
                  context: context,
                  title: "My Cart",
                  backgroundColor: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.black,
                ),
                body: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Container(
                            height: 70.h,
                            decoration: BoxDecoration(
                                color: themeManager.themeMode == ThemeMode.light
                                    ? AppColor.fieldBackgroundColor
                                    : Colors.grey[900],
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Center(
                                        child: Image.network(data['image'])),
                                    height: 60.h,
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                        color: color,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: color,
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        "\$${data['price']}",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: color,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Size: ${data['variant']!}",
                                        style: TextStyle(color: color),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColor.primaryColor)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                InkWell(
                                                    onTap: () async {
                                                      if (data['quantity'] >
                                                          1) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(user!.email)
                                                            .collection("cart")
                                                            .doc(data.id)
                                                            .update({
                                                          'quantity':
                                                              data['quantity'] -
                                                                  1
                                                        });
                                                      } else {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(user!.email)
                                                            .collection("cart")
                                                            .doc(data.id)
                                                            .delete();
                                                      }
                                                    },
                                                    child: Icon(
                                                        data['quantity'] == 1
                                                            ? Icons.delete
                                                            : Icons.remove)),
                                                Text(
                                                  data['quantity'].toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                InkWell(
                                                    onTap: () async {
                                                      FirebaseFirestore.instance
                                                          .collection("users")
                                                          .doc(user!.email)
                                                          .collection("cart")
                                                          .doc(data.id)
                                                          .update({
                                                        'quantity':
                                                            data['quantity'] + 1
                                                      });
                                                    },
                                                    child: Icon(Icons.add)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      );
                    }),
                bottomNavigationBar: snapshot.data!.docs.length != 0
                    ? Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: themeManager.themeMode == ThemeMode.light
                                ? Colors.black.withOpacity(0.01)
                                : Colors.black,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: color),
                                  ),
                                  Text(
                                    "\$${totalAmount}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: themeManager.themeMode ==
                                                ThemeMode.light
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                              CustomButton(
                                btnTitle: "Buy Now",
                                onTap: () async {
                                  List<Map<String, dynamic>> cardData = cartItem
                                      .map((item) =>
                                          item.data() as Map<String, dynamic>)
                                      .toList();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentGetewayScreen(
                                                  cardData: cardData,
                                                  totalAmount: totalAmount)));
                                  // try {
                                  //   if (result.trxId.isNotEmpty) {

                                  //                                       final result = await bkash.pay(
                                  //       context: context,
                                  //       amount: totalAmount,
                                  //       merchantInvoiceNumber: "invoice123");
                                  //     FirebaseFirestore.instance
                                  //         .collection("orders")
                                  //         .add({
                                  //       'email': user!.email,
                                  //       'time': result.executeTime,
                                  //       'item': cardData,
                                  //       'trxId': result.trxId,
                                  //       'paymentId': result.paymentId,
                                  //       'merchantInvoiceNumber':
                                  //           result.merchantInvoiceNumber,
                                  //       'customerMsisdn': result.customerMsisdn,
                                  //     }).then((value) async {
                                  //       final cart = await FirebaseFirestore.instance
                                  //           .collection("users")
                                  //           .doc(user!.email)
                                  //           .collection('cart')
                                  //           .get();

                                  //       for (var item in cart.docs) {
                                  //         await item.reference.delete();
                                  //       }
                                  //     });
                                  //   }

                                  //   showTopSnackBar(
                                  //     Overlay.of(context),
                                  //     CustomSnackBar.success(
                                  //       message:
                                  //           'Payment Successfull. Your Transaction ID is: ${result.trxId}',
                                  //     ),
                                  //   );
                                  // } on BkashFailure catch (e) {
                                  //   showTopSnackBar(
                                  //     Overlay.of(context),
                                  //     CustomSnackBar.error(
                                  //       message: e.toString(),
                                  //     ),
                                  //   );
                                  // }
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    : Container());
          }
        }));
  }
}