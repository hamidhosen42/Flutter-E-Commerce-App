// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/dashboard_button.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    final data = snapshot.data?.docs ?? [];
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return InkWell(
                        onTap: () {},
                        child: dashboardButton(
                          context: context,
                          title: "Producs",
                          quantity: data.length.toString(),
                          icon: "assets/images/products.png",
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("categories")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          // Get.to(() => TourGuidePackageScreen());
                        },
                        child: dashboardButton(
                          context: context,
                          title: "Tour Guide",
                          quantity: snapshot.data!.docs.length.toString(),
                          icon: "assets/images/direction.png",
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return InkWell(
                        onTap: () {},
                        child: dashboardButton(
                          context: context,
                          title: "Users",
                          quantity: snapshot.data!.docs.length.toString(),
                          icon: "assets/images/users.png",
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
                StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection("sds").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Hamid"),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          // Get.to(() => TourGuidePackageScreen());
                        },
                        child: dashboardButton(
                          context: context,
                          title: "Tour Guide",
                          quantity: snapshot.data!.docs.length.toString(),
                          icon: "assets/images/clock.png",
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Divider(
              color: AppColor.fieldBackgroundColor,
              thickness: 2,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Recent Product",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 10.h),
            StreamBuilder(
              stream: fireStore.collection('products').snapshots(),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs ?? [];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  );
                } else {
                  return Expanded(
                    child: GridView.builder(
                        itemCount: data.length,
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) =>
                              //             ProductDetailsScreen(
                              //               product: data[index],
                              //             )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                              child: Text(
                                            '${data[index]['discount']}%OFF',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.favorite_outline,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ))
                                    ],
                                  ),
                                  Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            // fit: BoxFit.cover,
                                            image: NetworkImage(
                                          data[index]['image'],
                                        )),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index]['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "\$${data[index]['price']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
