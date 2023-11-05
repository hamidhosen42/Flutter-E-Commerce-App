// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../utils/colors.dart';
import '../AddBanner/add_banner.dart';
import '../EditBanner/edit_banner.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Banner"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AddBannerScreen()));
                },
                icon: Icon(Icons.add)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
          stream: fireStore.collection('banners').snapshots(),
          builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        } else {
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(
                                    10)), // Adjust the radius as needed
                            child: Image.network(
                              data['image'],
                              width: 100.w,
                              height: 40.h,
                              fit: BoxFit.fill,
                            ),
                          )
                        : CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EditBanners(
                                          banners: data)));
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
                                  .collection('banners')
                                  .doc(data.id)
                                  .delete();
                              showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message: "Successfully Banner Delete",
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
          );
        }
          },
        ),
      ),
    );
  }
}