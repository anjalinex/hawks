import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hawks/screens/welcomeScreen.dart';

import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ));
    });
    // Timer(Duration(seconds: 5),
    //         () =>
    //         Get.to(WelcomeScreen(),
    //             duration: Duration(milliseconds: 1500),
    //             transition: Transition.rightToLeft)
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Image(
        image: AssetImage("assets/images/android1.jpg"),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
    ));
  }
}
