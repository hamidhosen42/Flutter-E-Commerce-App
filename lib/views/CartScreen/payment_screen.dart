// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/views/HomeScreen/home_screen.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PaymentGetewayScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cardData;
  final double totalAmount;
  PaymentGetewayScreen({required this.cardData, required this.totalAmount});

  @override
  State<PaymentGetewayScreen> createState() => _PaymentGetewayScreenState();
}

class _PaymentGetewayScreenState extends State<PaymentGetewayScreen> {
  final user = FirebaseAuth.instance.currentUser;

  final bkash = FlutterBkash(
      bkashCredentials: BkashCredentials(
    username: "sandboxTokenizedUser02",
    password: "sandboxTokenizedUser02@12345",
    appKey: "4f6o0cjiki2rfm34kfdadl1eqq",
    appSecret: "2is7hdktrekvrbljjh44ll3d9l1dtjo4pasmjvs5vl5qr3fug4b",
    isSandbox: true, //!real work false
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Payment Method'),
      body: Column(children: [
        InkWell(
          onTap: () async {
            try {
              final result = await bkash.pay(
                  context: context,
                  amount: widget.totalAmount,
                  merchantInvoiceNumber: "invoice123");
              FirebaseFirestore.instance.collection("orders").add({
                'email': user!.email,
                'time': result.executeTime,
                'item': widget.cardData,
                'trxId': result.trxId,
                'paymentId': result.paymentId,
                'merchantInvoiceNumber': result.merchantInvoiceNumber,
                'customerMsisdn': result.customerMsisdn,
                'gtName':'bKash'
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
                  message:
                      'Payment Successfull. Your Transaction ID is: ${result.trxId}',
                ),
              );
            } on BkashFailure catch (e) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: e.toString(),
                ),
              );
            }
          },
          child: Card(
            child: ListTile(
              title: Text("bKash"),
            ),
          ),
        ),
        InkWell(
          onTap: () async{
             try {
              final result = await bkash.pay(
                  context: context,
                  amount: widget.totalAmount,
                  merchantInvoiceNumber: "invoice123");
              FirebaseFirestore.instance.collection("orders").add({
                'email': user!.email,
                'time': result.executeTime,
                'item': widget.cardData,
                'trxId': result.trxId,
                'paymentId': result.paymentId,
                'merchantInvoiceNumber': result.merchantInvoiceNumber,
                'customerMsisdn': result.customerMsisdn,
                'gtName':'COD'
              }).then((value) async {
                final cart = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(user!.email)
                    .collection('cart')
                    .get();

                for (var item in cart.docs) {
                  await item.reference.delete();
                }
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
              });

              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.success(
                  message:
                      'Cash on Delivary',
                ),
              );
            } on BkashFailure catch (e) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: e.toString(),
                ),
              );
            }
          },
          child: Card(
            child: ListTile(
              title: Text("COD"),
            ),
          ),
        )
      ]),
    );
  }
}