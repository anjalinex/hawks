import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawks/Model/countrymodel.dart';
import 'package:hawks/constants/url.dart';
import 'package:hawks/screens/loginpage.dart';
import 'package:hawks/screens/sales_screen.dart';
import 'package:get/get.dart';
import '../Model/StateModel.dart';
import '../Model/signupModel.dart';
import '../Repository/ApiServices.dart';
import '../constants/color.dart';
import '../constants/style.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dashboard.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formGlobalKey = GlobalKey<FormState>();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController contactnocontroller = TextEditingController();
  String? countrydropdownvalue;
  String? statedropdownvalue;
  String? citydropdownvalue;

  //State
  List statedata = []; //edited line
  Future<String> getStateData() async {
    http.Response response = await http.post(Uri.parse(statesApi), body: {
      "country_id": "101",
    }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        statedata = data["data"];
        print(statedata);
      });
      return response;
    });
    return "success";
  }

  //City
  List citydata = []; //edited line
  Future<String> getCityData() async {
    http.Response response = await http.post(Uri.parse(cityApi), body: {
      "state_id": statedropdownvalue,
    }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        citydata = data["data"];
        print(citydata);
      });
      return response;
    });
    return "success";
  }

  var country = [
    'India',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countrydropdownvalue = country[0];
    getStateData();
  }

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
                child: Form(
                    key: _formGlobalKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .05,
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Signup",
                              style: logintext,
                            ),
                          ),
                          SizedBox(
                            height: height * .02,
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
                                controller: namecontroller,
                                cursorColor: primarycolor,
                                decoration: InputDecoration(
                                  labelText: "Company Name",
                                  labelStyle: loginhinttext,
                                  hintText: "Company Name",
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
                                  color: primarycolor,
                                  width: 1.0,
                                ),
                              )),
                              child: TextField(
                                controller: emailcontroller,
                                cursorColor: primarycolor,
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
                                  color: primarycolor,
                                  width: 1.0,
                                ),
                              )),
                              child: TextField(
                                controller: passwordcontroller,
                                cursorColor: primarycolor,
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
                                controller: contactnocontroller,
                                cursorColor: primarycolor,
                                decoration: InputDecoration(
                                  labelText: "Contact No.",
                                  labelStyle: loginhinttext,
                                  hintText: "Contact No.",
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
                              child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  value: countrydropdownvalue,
                                  hint: Text(
                                    "Select Country",
                                    style: loginhinttext,
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: country.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      countrydropdownvalue = newValue!;
                                    });
                                  })),
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
                              child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  value: statedropdownvalue,
                                  hint: Text(
                                    "Select State",
                                    style: loginhinttext,
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: statedata.map((items) {
                                    return DropdownMenuItem(
                                      value: items['id'].toString(),
                                      child: Text(items['name'].toString()),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      statedropdownvalue = newValue!;
                                      getCityData();
                                    });
                                  })),
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
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(),
                                value: citydropdownvalue,
                                hint: Text(
                                  "Select City",
                                  style: loginhinttext,
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: citydata.map((items) {
                                  return DropdownMenuItem(
                                    value: items['id'].toString(),
                                    child: Text(items['name'].toString()),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    citydropdownvalue = newValue!;
                                  });
                                },
                              )),
                          SizedBox(
                            height: height * .04,
                          ),
                          Center(
                              child: Container(
                                  width: width * .20,
                                  child: CupertinoButton(
                                    onPressed: () {
                                      ApiServices().Signup(
                                          namecontroller.text,
                                          emailcontroller.text,
                                          passwordcontroller.text,
                                          "1",
                                          "${statedropdownvalue}",
                                          "${citydropdownvalue}",
                                          contactnocontroller.text);
                                      print("$statedropdownvalue");
                                      print("$citydropdownvalue");
                                      // ApiServices().signup();
                                    },
                                    child: Text("Signup"),
                                    color: primarycolor,
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    pressedOpacity: 0.6,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ))),
                          SizedBox(
                            height: height * .02,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'You have already account?',
                                  style: loginhinttext,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(LoginPage(),
                                          duration: Duration(
                                              milliseconds:
                                                  300), //duration of transitions, default 1 sec
                                          transition: Transition.rightToLeft);
                                    },
                                    child: Text(
                                      "Login",
                                      style: loginhinttext,
                                    ))
                              ],
                            ),
                          ),
                        ])))));
  }
}
