import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/constants/style.dart';
import 'package:get/get.dart';
import 'package:hawks/screens/signup_screen.dart';
import 'loginpage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.10,
        ),
        Text(
          "Connect with",
          style: headline1,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Image(image: AssetImage("assets/images/HAWKS.jpg")),
        SizedBox(
          height: height * 0.02,
        ),
        Text(
          "ACCOUNTING & BILLING",
          style: headline1,
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Image(
          image: AssetImage("assets/images/Group 95.jpg"),
          height: height * .30,
          // width: width * .50,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: height * 0.06,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Now managing your Accounting is much \n easier with the Hawks Accounting Mobile App",
            style: loginhinttext,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: height * 0.15,
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: CupertinoButton(
                onPressed: () {
                  Get.to(SignupScreen(),
                      duration: Duration(milliseconds: 300),
                      transition: Transition.rightToLeft);
                },
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                    "Get started",
                    style: subheadline1,
                  ),
                  IconButton(
                    onPressed: () {
                      // Get.to(SignupScreen(),
                      //     duration: Duration(milliseconds: 500),
                      //     transition: Transition.rightToLeft);
                    },
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      color: blackcolor,
                    ),
                    iconSize: 30,
                  )
                ])))
      ],
    ));
  }
}
