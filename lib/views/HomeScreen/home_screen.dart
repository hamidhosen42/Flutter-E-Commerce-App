// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/widget/custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> sliderImage = [
    'https://img.freepik.com/premium-vector/sale-banner-template-design_74379-121.jpg',
    'https://img.freepik.com/free-vector/flat-sale-banner-with-photo_23-2149026968.jpg'
  ];

  List<Map<String, String>> categories = [
    {
      'icon': "assets/images/img1.png",
    },
    {
      'icon': "assets/images/img2.png",
    },
    {
      'icon': "assets/images/img3.png",
    },
    {
      'icon': "assets/images/img4.png",
    },
    {
      'icon': "assets/images/img5.png",
    },
  ];

    List<Map<String, String>> products = [
    {
      'image': "assets/images/r1.png",
      'name':'Redmi Note 4',
      'price':'40'
    },
    {
      'image': "assets/images/r2.png",
      'name':'Apple Watch - series 6',
      'price':'60'
    },
    {
      'image': "assets/images/r3.png",
      'name':'Redmi Note 4',
      'price':'40'
    },
    {
      'image': "assets/images/r4.png",
      'name':'Redmi Note 4',
      'price':'40'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          isLeading: Icon(Icons.menu),
          action: [IconButton(onPressed: () {}, icon: Icon(Icons.search))]),
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
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                height: 150,
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: sliderImage.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(sliderImage[index]),
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
              SizedBox(
                height: 62,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 15),
                        width: 64,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            border: Border.all(color: Color(0xFFD8D3D3)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(categories[index]['icon']!),
                      );
                    }),
              ),
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
              GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        products[index]['image']!,
                                      )),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
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
                                            "50% OFF",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite_outline,color: Colors.black.withOpacity(0.5),))
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index]['name']!,
                                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "\$${products[index]['price']!?? '10'}",
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
