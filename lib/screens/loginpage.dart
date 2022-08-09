import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawks/Repository/ApiServices.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/constants/style.dart';
import 'package:hawks/screens/dashboard.dart';
import 'package:hawks/screens/sales_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  // Future login() async {
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('https://hawksapi.nexinfosoft.com/Api/login'));
  //   request.fields.addAll(
  //       {'email': emailcontroller.text, 'password': passwordcontroller.text});
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     print(response.reasonPhrase);
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   return response.reasonPhrase;
  // }

  bool remember = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * .10,
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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Login",
              style: logintext,
            ),
          ),
          SizedBox(
            height: height * .04,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  color: primarycolor,
                  width: 1.0,
                ),
              )),
              child: TextField(
                cursorColor: primarycolor,
                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: loginhinttext,
                  hintText: "Email",
                  hintStyle: loginhinttext,
                  border: InputBorder.none,
                ),
              )),
          SizedBox(
            height: height * .02,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                  //                   <--- left side
                  color: primarycolor,
                  width: 1.0,
                ),
              )),
              child: TextField(
                cursorColor: primarycolor,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: loginhinttext,
                  hintText: "Password",
                  hintStyle: loginhinttext,
                  border: InputBorder.none,
                ),
              )),
          SizedBox(
            height: height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(05),
                    ),
                    value: remember,
                    activeColor: primarycolor,
                    onChanged: (bool? newValue) {
                      setState(() {
                        remember = newValue!;
                      });
                    }),
                Text(
                  'Remember me?',
                  style: loginhinttext,
                ),
              ]),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: loginhinttext,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: height * .02,
          ),
          Center(
              child: Container(
                  width: width * .20,
                  child: CupertinoButton(
                    onPressed: () {
                      // ApiServices()
                      //     .Login(emailcontroller.text, passwordcontroller.text);
                      ApiServices()
                          .login(emailcontroller.text, passwordcontroller.text);
                    },
                    child: Text("Login"),
                    color: primarycolor,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ))),
          SizedBox(
            height: height * .04,
          ),
        ],
      ),
    )));
  }
}
