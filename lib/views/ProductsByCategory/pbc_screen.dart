// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../../utils/colors.dart';

class ProductByCategory extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> category;

  ProductByCategory({required this.category});

  @override
  State<ProductByCategory> createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {


  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    final color =
        themeManager.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Scaffold(
        backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,
      appBar: customAppBar(context: context,title: widget.category['name'], backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
                    stream: fireStore.collection('products').where('categories',isEqualTo: widget.category['name']).snapshots(),
                    builder: (_, snapshot) {
                      final data = snapshot.data?.docs ?? [];
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Card(
                               color: themeManager.themeMode == ThemeMode.light
                      ? AppColor.fieldBackgroundColor
                      : Colors.grey[900],
                                child: ListTile(
                                  title: Text(data[index]['name'],style: TextStyle(color: color),),
                                  subtitle: Text('Discount:${data[index]['discount']}%',style: TextStyle(color: color),),
                                  leading: data[index]['image'] != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10)), // Adjust the radius as needed
                                      child: Image.network(
                                        data[index]['image'],
                                        width: 50.w,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : CircularProgressIndicator(
                                      color:  themeManager.themeMode == ThemeMode.light ?AppColor.primaryColor:Colors.white,
                                    ),
                                    trailing: Text("\$${data[index]['price']}",style: TextStyle(fontSize: 16.sp,color: color),),
                                ),
                              );
                            });
                      }
                    }),
      ),
    );
  }
}