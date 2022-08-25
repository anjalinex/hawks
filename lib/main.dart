import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/dashboard.dart';
import 'package:get/get.dart';
import 'package:hawks/screens/signup_screen.dart';
import 'package:hawks/screens/splashscreen.dart';

class MyOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyOverride();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primaryColor: primarycolor),
      home: SplashScreen(),
    );
  }
}
