// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class InitializeDatabaseScreen extends StatefulWidget {
  const InitializeDatabaseScreen({super.key});

  @override
  State<InitializeDatabaseScreen> createState() =>
      _InitializeDatabaseScreenState();
}

class _InitializeDatabaseScreenState extends State<InitializeDatabaseScreen> {
  final fireStore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<void> initDb() async {
    setState(() {
      isLoading = true;
    });
    fireStore.collection('users').doc('admin6403@gmail.com').set({
      'email': 'admin6403@gmail.com',
      'name': 'Administrator',
      'address': 'N/A',
      'image': '',
      'uid': '',
    }).then((value) {
      fireStore.collection('banners').add({
        'id': '01',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/shopsavvy-fb9e3.appspot.com/o/banner%2Fbanner1.jpg?alt=media&token=a7927247-bba3-484f-a282-96a725333009&_gl=1*1jq4ug4*_ga*NzY1MjE2MzczLjE2ODQ1OTQ0NjU.*_ga_CW55HF8NVT*MTY5OTE3MjYzNy44MS4xLjE2OTkxNzI5NDcuNS4wLjA.'
      }).then((value) {
        setState(() => isLoading = false);
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: "Database Successfully Initialized",
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Initialize Database"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Do you really want to Initialize Database?',
                  style: TextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'NOTE: If you already did this task at any time for this app then you should skip this step.',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  btnTitle: 'Start Initialization',
                  isLoading: isLoading,
                  onTap: initDb,
                )
              ],
            ),
          ),
        ));
  }
}
