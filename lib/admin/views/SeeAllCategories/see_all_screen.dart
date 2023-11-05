// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/admin/views/AddCategories/add_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../utils/colors.dart';
import '../../../views/ProductsByCategory/pbc_screen.dart';
import '../BottomBavBarView/bottom_view.dart';
import '../EditCategories/edit_categories.dart';

class AdminSeeAllScreen extends StatefulWidget {
  const AdminSeeAllScreen({super.key});

  @override
  State<AdminSeeAllScreen> createState() => _AdminSeeAllScreenState();
}

class _AdminSeeAllScreenState extends State<AdminSeeAllScreen> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomBarAdminScreen()));
            },
            icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AddCategorieScreen()));
                },
                icon: Icon(Icons.add)),
          )
        ],
      ),
      // appBar: customAppBar(context: context, title: "All Categories",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder(
            stream: fireStore.collection('categories').snapshots(),
            builder: (_, snapshot) {
                final data1 = snapshot.data?.docs ?? [];
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
                      return InkWell(
                        onTap: (){
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProductByCategory(
                                      category: data1[index])));
                        },
                        child: Card(
                          color: AppColor.fieldBackgroundColor,
                          child: ListTile(
                            leading: data['icon'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10)), // Adjust the radius as needed
                                    child: Image.network(
                                      data['icon'],
                                      width: 25.w,
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
                            trailing: PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => EditCategories(
                                                  categories: data)));
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
                                          .collection('categories')
                                          .doc(data.id)
                                          .delete();
                                      showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.success(
                                            message:
                                                "Successfully Categories Delete",
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
                        ),
                      );
                    },
                  ),
                );
              }
            }),
      ),
    );
  }
}