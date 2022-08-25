import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hawks/screens/dashboard.dart';
import 'package:hawks/screens/welcomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoggedIn() async {
    try {
      Future.delayed(const Duration(seconds: 3), () async {
        final prefs = await SharedPreferences.getInstance();
        var user = prefs.getString("email");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => user != null ? Dashboard() : WelcomeScreen(),
          ),
          (route) => false,
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoggedIn();
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
