import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main(List<String> args) async {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 680),
      builder: (context, child) {
        return GetMaterialApp(
          // title: AppConstants.appName,
          // debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   scaffoldBackgroundColor: AppColors.secondary,
          //   appBarTheme: const AppBarTheme(
          //     backgroundColor: AppColors.secondary,
          //   ),
          //   fontFamily: GoogleFonts.lato().fontFamily,
          // ),
          // initialRoute: initialRoute,
          // getPages: RouteDestinations.pages,
          // builder: EasyLoading.init(),
          // onReady: () {
          //   FlutterNativeSplash.remove();
          // },
        );
      },
    );
  }
}
