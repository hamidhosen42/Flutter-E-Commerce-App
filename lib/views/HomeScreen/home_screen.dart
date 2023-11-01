// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Authentication/LoginScreen/login_screen.dart';
import '../ProductDetaris/product_details.dart';
import '../ProductsByCategory/pbc_screen.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          customAppBar(context: context, isLeading: Icon(Icons.menu), action: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false);
            },
            icon: Icon(Icons.logout))
      ]),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Hamid 👋",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
              Text(
                "Let’s start shopping!",
                style: TextStyle(color: Colors.black.withOpacity(0.5)),
              ),
              firebaseSliders.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      height: 150,
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
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("See All",
                        style: TextStyle(color: AppColor.primaryColor)),
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
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
                                          builder: (_) => ProductByCategory( category:data[index])));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                      border:
                                          Border.all(color: Color(0xFFD8D3D3)),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.network(data[index]['icon']!),
                                        Text(data[index]['name'])
                                      ],
                                    ),
                                  ),
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
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
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
                    return GridView.builder(
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductDetailsScreen(
                                            product: data[index],
                                          )));
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