// ignore_for_file: prefer_const_constructors, unused_local_variable, non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls, invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: "Favourite Screen"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users-favourite-items')
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("place")
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
      
            return ListView(
              children: List.generate(
                snapshot.data!.docs.length,
                (index) {
                  var data = snapshot.data!.docs[index];
                  return Card(
                    color: AppColor.fieldBackgroundColor,
                    child: ListTile(
                      leading: data['image'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  10)), // Adjust the radius as needed
                              child: Image.network(
                                data['image'],
                                width: 50.w,
                                fit: BoxFit.fill,
                              ),
                            )
                          : CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                      title: Text(
                        data['name'],
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("\$${data['price']}",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w700)),
                      trailing: IconButton(onPressed: (){
                         FirebaseFirestore.instance
                                    .collection('users-favourite-items')
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection('place')
                                    .where('id', isEqualTo: data['id'])
                                    .get()
                                    .then((querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    doc.reference.delete();
                                  });
      
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(
                                      message: "Product deleted successfully",
                                    ),
                                  );
                                }).catchError((error) => showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.error(
                                            message:
                                                "Failed to delete place: $error",
                                          ),
                                        ));
                      }, icon:   Icon(Icons.delete))
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}