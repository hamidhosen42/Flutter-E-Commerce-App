// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_is_empty, use_build_context_synchronously, unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../main.dart';
import '../Authentication/LoginScreen/login_screen.dart';
import '../ProductDetaris/product_details.dart';
import '../ProductsByCategory/pbc_screen.dart';
import '../SeeAll/see_all_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fireStore = FirebaseFirestore.instance;
  List firebaseSliders = [];

  //!  Firstore sliderImage
  Future<void> getSlider() async {
    var data = await fireStore.collection('banners').get();
    setState(() {
      setState(() {
        firebaseSliders = data.docs;
      });
    });
  }

  Future addToFavourite(
      QueryDocumentSnapshot<Map<String, dynamic>>? data1) async {
    var ref = FirebaseFirestore.instance
        .collection("users-favourite-items")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("place")
        .doc();

    ref.set({
      'id': data1!['id'],
      'name': data1['name'],
      'image': data1['image'],
      'price': data1['price'],
      'categories': data1['categories'],
    }).then((value) => showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "Added to favourite place",
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getSlider();
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
           backgroundColor: themeManager.themeMode == ThemeMode.light
            ? Colors.white
            : Colors.black,
          isLeading: Icon(
            Icons.menu,
            color: color,
          ),
          action: [
            IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.logout,color: color,),
            )
          ]),
      body: firebaseSliders.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: fireStore
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .snapshots(),
                        builder: (_, snapshot) {
                          final data = snapshot.data;
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                color:themeManager.themeMode == ThemeMode.light ?AppColor.primaryColor:Colors.white,
                              ),
                            );
                          } else {
                            return Text(
                              "Hello ${data!['name']} 👋",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 16.sp,color: color),
                            );
                          }
                        }),
                    Text(
                      "Let’s start shopping!",
                      style: TextStyle(color: themeManager.themeMode == ThemeMode.light ?Colors.black.withOpacity(0.5):Colors.grey[400]),
                    ),
                    firebaseSliders.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color:themeManager.themeMode == ThemeMode.light ?AppColor.primaryColor:Colors.white,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
                            height: 120.h,
                            width: double.infinity,
                            child: CarouselSlider.builder(
                              itemCount: firebaseSliders.length,
                              itemBuilder: (context, index, realIndex) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              firebaseSliders[index]['image']),
                                          fit: BoxFit.cover)),
                                );
                              },
                              options: CarouselOptions(
                                  autoPlay: true,
                                  autoPlayCurve: Curves.easeInOut,
                                  enlargeCenterPage: true),
                            ),
                          ),
                    // ! Categories=============
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp,color: color),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SeeAllScreen()));
                          },
                          child: Text("See All",
                              style: TextStyle( color:themeManager.themeMode == ThemeMode.light ?AppColor.primaryColor:Colors.white,)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    StreamBuilder(
                        stream: fireStore.collection('categories').snapshots(),
                        builder: (_, snapshot) {
                          final data = snapshot.data?.docs ?? [];
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                 color:themeManager.themeMode == ThemeMode.light ?AppColor.primaryColor:Colors.white,
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 70,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductByCategory(
                                                        category:
                                                            data[index])));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 15),
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: themeManager.themeMode == ThemeMode.light ?Color(0xFFF2F2F2):Colors.grey[500],
                                            border: Border.all(
                                                color: Color(0xFFD8D3D3)
                                                
                                                ),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Image.network(
                                                data[index]['icon']!)),
                                      ),
                                    );
                                  }),
                            );
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Recent Products",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp,color: color),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                      stream: fireStore.collection('products').snapshots(),
                      builder: (context, snapshot) {
                        final data = snapshot.data?.docs ?? [];
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                               color:themeManager.themeMode == ThemeMode.light ?AppColor.primaryColor:Colors.white,
                            ),
                          );
                        } else {
                          return GridView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.7,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15),
                              itemBuilder: (context, index) {
                                final data1 = snapshot.data?.docs[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ProductDetailsScreen(
                                                    product: data[index],
                                                    rool: 'user')));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                       color: themeManager.themeMode == ThemeMode.light ?Color(0xFFF2F2F2):Colors.grey[900],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                height: 20.h,
                                                width: 50.w,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: Text(
                                                  '${data[index]['discount']}%OFF',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.sp),
                                                )),
                                              ),
                                            ),
                                            StreamBuilder(
                                                stream: fireStore
                                                    .collection(
                                                        'users-favourite-items')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.email)
                                                    .collection("place")
                                                    .where("id",
                                                        isEqualTo: data1!['id'])
                                                    .snapshots(),
                                                builder: (_, snapshot) {
                                                  if (snapshot.data == null) {
                                                    return Center(
                                                        child: Text(
                                                            'Place is Empty'));
                                                  }
                                                  if (snapshot.hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Something went wrong'));
                                                  }
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  return IconButton(
                                                      icon: snapshot.data!.docs
                                                                  .length ==
                                                              0
                                                          ? Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: 20.sp,
                                                              color:
                                                                  color,
                                                            )
                                                          : Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: 20.sp,
                                                              color: Colors.red,
                                                            ),
                                                      onPressed: () => snapshot
                                                                  .data!
                                                                  .docs
                                                                  .length ==
                                                              0
                                                          ? addToFavourite(
                                                              data1)
                                                          : showTopSnackBar(
                                                              Overlay.of(
                                                                  context),
                                                              CustomSnackBar
                                                                  .error(
                                                                message:
                                                                    "Already Added",
                                                              ),
                                                            ));
                                                }),
                                          ],
                                        ),
                                        Container(
                                          height: 80.h,
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
                                                    fontSize: 14.sp,color: color),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                "\$${data[index]['price']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,color: color),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
