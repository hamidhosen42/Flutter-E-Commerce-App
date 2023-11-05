// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously, prefer_typing_uninitialized_variables, prefer_const_constructors_in_immutables, prefer_final_fields

import 'dart:convert';
import 'dart:developer' as dev;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/views/CartScreen/cart_screen.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter_bkash/flutter_bkash.dart';

import '../../main.dart';
import '../../utils/colors.dart';
import 'success_payment.dart';

enum Intent { sale, authorization }

class PaymentGetewayScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cardData;
  final double totalAmount;
  PaymentGetewayScreen({required this.cardData, required this.totalAmount});

  @override
  State<PaymentGetewayScreen> createState() => _PaymentGetewayScreenState();
}

class _PaymentGetewayScreenState extends State<PaymentGetewayScreen> {
  final user = FirebaseAuth.instance.currentUser;

  Intent _intent = Intent.sale;
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: themeManager.themeMode == ThemeMode.light
          ? Colors.white
          : Colors.black,
      appBar: customAppBar(
          context: context,
          title: 'Payment Method',
          backgroundColor: themeManager.themeMode == ThemeMode.light
              ? Colors.white
              : Colors.black),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          InkWell(
            onTap: () async {
              String intent = _intent == Intent.sale ? "sale" : "authorization";

              if (widget.totalAmount.toString().isEmpty) {
                //! if the amount is empty then show the snack-bar
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.success(
                    message:
                        "Amount is empty. Without amount you can't pay. Try again",
                  ),
                );
                return;
              }
              // remove focus from TextField to hide keyboard
              focusNode!.unfocus();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BkashPayment(
                        isSandbox: true,
                        amount: widget.totalAmount.toString(),
                        intent: intent,
                        createBKashUrl:
                            'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/create',
                        executeBKashUrl:
                            'https://merchantserver.sandbox.bka.sh/api/checkout/v1.2.0-beta/payment/execute',
                        scriptUrl:
                            'https://scripts.sandbox.bka.sh/versions/1.2.0-beta/checkout/bKash-checkout-sandbox.js',
                        paymentStatus: (status, data) {
                          dev.log('return status => $status');
                          dev.log('return data => $data');
                          if (status == 'paymentSuccess') {
                            if (data['transactionStatus'] == 'Completed') {
                              final data = FirebaseFirestore.instance
                                  .collection("orders")
                                  .doc(user!.email)
                                  .collection("order")
                                  .doc();

                              data.set({
                                'id': data.id.toString(),
                                'email': user!.email,
                                'item': widget.cardData,
                                'amount': widget.totalAmount,
                                'gtName': 'bKash',
                                'delivery': true
                              }).then((value) async {
                                final cart = await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(user!.email)
                                    .collection('cart')
                                    .get();

                                for (var item in cart.docs) {
                                  await item.reference.delete();
                                }
                              });
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.success(
                                  message: "Payment Success",
                                ),
                              );
                            }
                          } else if (status == 'paymentFailed') {
                            if (data.isEmpty) {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: "Payment Failed",
                                ),
                              );
                            } else if (data[0]['errorMessage'].toString() !=
                                'null') {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message:
                                      "Payment Failed ${data[0]['errorMessage']}",
                                ),
                              );
                            } else {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: "Payment Failed",
                                ),
                              );
                            }
                          } else if (status == 'paymentError') {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message:
                                    jsonDecode(data['responseText'])['error'],
                              ),
                            );
                          } else if (status == 'paymentClose') {
                            if (data == 'closedWindow') {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: "Failed to payment, closed screen",
                                ),
                              );
                            } else if (data == 'scriptLoadedFailed') {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: "Payment screen loading failed",
                                ),
                              );
                            }
                          }
                          // back to screen to pop()
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                        },
                      )));
            },
            child: Card(
              color: themeManager.themeMode == ThemeMode.light
                  ? AppColor.fieldBackgroundColor
                  : Colors.grey[900],
              child: ListTile(
                title: Text(
                  "bKash",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: color),
                ),
                trailing: Text(
                  "\$${widget.totalAmount.toString()}",
                  style: TextStyle(fontSize: 16.sp, color: color),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              final data = FirebaseFirestore.instance
                  .collection("orders")
                  .doc(user!.email)
                  .collection("order")
                  .doc();

              await data.set({
                'id': data.id.toString(),
                'email': user!.email,
                'item': widget.cardData,
                'amount': widget.totalAmount,
                'gtName': 'COD',
                'delivery': false
              }).then((value) async {
                final cart = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(user!.email)
                    .collection('cart')
                    .get();

                for (var item in cart.docs) {
                  await item.reference.delete();
                }
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SuccessPaymentScreen()));
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message: "Payment Successfully Done",
                ),
              );
            },
            child: Card(
              color: themeManager.themeMode == ThemeMode.light
                  ? AppColor.fieldBackgroundColor
                  : Colors.grey[900],
              child: ListTile(
                title: Text(
                  "Cash on Delivery",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: color),
                ),
                trailing: Text(
                  "\$${widget.totalAmount.toString()}",
                  style: TextStyle(fontSize: 16.sp, color: color),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

// ! bKash Payment--------------


  // final flutterBkash = FlutterBkash(
  //   bkashCredentials: BkashCredentials(
  //     username: "sandboxTokenizedUser02",
  //     password: "sandboxTokenizedUser02@12345",
  //     appKey: "4f6o0cjiki2rfm34kfdadl1eqq",
  //     appSecret: "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
  //     isSandbox: true,//!real work false 
  //   ),
  // );

// try {
                // final result = await bkash.pay(
                //     context: context,
                //     amount: widget.totalAmount,
                //     merchantInvoiceNumber: "invoice123");
                // FirebaseFirestore.instance.collection("orders").add({
                //   'email': user!.email,
                //   'time': result.executeTime,
                //   'item': widget.cardData,
                //   'trxId': result.trxId,
                //   'paymentId': result.paymentId,
                //   'merchantInvoiceNumber': result.merchantInvoiceNumber,
                //   'customerMsisdn': result.customerMsisdn,
                //   'gtName':'bKash'
                // }).then((value) async {
                //   final cart = await FirebaseFirestore.instance
                //       .collection("users")
                //       .doc(user!.email)
                //       .collection('cart')
                //       .get();
      
                //   for (var item in cart.docs) {
                //     await item.reference.delete();
                //   }
                // });
      
//                 showTopSnackBar(
//                   Overlay.of(context),
//                   CustomSnackBar.success(
//                     message:
//                         'Payment Successfull. Your Transaction ID is: ${result.trxId}',
//                   ),
//                 );
//               } on BkashFailure catch (e) {
//                 showTopSnackBar(
//                   Overlay.of(context),
//                   CustomSnackBar.error(
//                     message: e.toString(),
//                   ),
//                 );
//               }