// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../EditProduct/edit_product.dart';

class AllProductScren extends StatelessWidget {
  const AllProductScren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("products").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Expanded(
                    child: ListView(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          var data = snapshot.data!.docs[index];
                          return Card(
                            color: AppColor.fieldBackgroundColor,
                            child: ListTile(
                              onTap: () {},
                              leading: data['image'] != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("${data['price']} BDT",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700)),
                              trailing: PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    child: InkWell(
                                      onTap: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (_)=>EditProductScreen(product:data)));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          SizedBox(width: 10.w),
                                          Text("Edit"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: InkWell(
                                      onTap: () {
                                        FirebaseFirestore.instance
                                            .collection('products')
                                            .doc(data.id)
                                            .delete();
                                        showTopSnackBar(
                                            Overlay.of(context),
                                            CustomSnackBar.success(
                                              message:
                                                  "Successfully Product Delete",
                                            ));
                                            Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete),
                                          SizedBox(width: 10.w),
                                          Text("Delete"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
      ),
    );
  }
}