import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/models.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/constants/url.dart';
import 'package:hawks/screens/supplier/supllier_details.dart';
import 'package:hawks/widgets/widget.dart';
import 'package:http/http.dart' as http;
import '../../constants/style.dart';
import '../sales_screen.dart';

class SupplierForm extends StatefulWidget {
  const SupplierForm({Key? key}) : super(key: key);

  @override
  State<SupplierForm> createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  final TextEditingController supplier_name = TextEditingController();
  final TextEditingController mobile_no = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController gst_no = TextEditingController();
  final TextEditingController opening_balance = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController zipcode = TextEditingController();
  final TextEditingController remarks = TextEditingController();

  String? dropdownvalue;
  String? countrydropdown;
  String? statedropdownvalue;
  String? cityDropdown;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Titel Titeldropdownvalue = Titel(1, "Dr.");
  List<Titel> title = <Titel>[
    Titel(1, 'Dr.'),
    Titel(2, 'Er.'),
    Titel(3, 'Miss.'),
    Titel(4, 'Mrs.'),
  ];
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

  Future CreateSupplier() async {
    var request = http.MultipartRequest('POST', Uri.parse(create_supplier));
    request.fields.addAll({
      'supplier_name': supplier_name.text,
      'mobile_no': mobile_no.text,
      'email': email.text,
      'gst_no': gst_no.text,
      'opening_balance': opening_balance.text,
      'title': "${Titeldropdownvalue.title_name}",
      'country_id': '101',
      'state_id': "${statedropdownvalue}",
      'city_id': "${cityDropdown}",
      'address': address.text,
      'zipcode': zipcode.text,
      'remarks': remarks.text
    });
    print(request.fields);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);

    if (response.statusCode == 200) {
      print(respStr);
      var encoded = json.decode(respStr);
      print(encoded["data"]);
      Fluttertoast.showToast(
          msg: "Your Data has been added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(response.reasonPhrase);
    }
  }

  String? isValidEmail(String? email) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (email?.length == 0) return "Can't Be Empty";
    if (!regex.hasMatch(email!)) return "Invalid Email Adress";
    return null;
  }

  String? MobNo(String? MobileNo) {
    if (MobileNo?.length == 0) return "Can't Be Empty";
    return null;
  }

  var country = [
    'India',
  ];

  var states = [
    'Bihar',
    'Haryana',
    'Uttar Pradesh',
    'Punjab',
  ];

  var cities = [
    'India',
    'Nepal',
    'Australia',
    'Japan',
  ];
  @override
  void initState() {
    // TODO: implement initState
    Titeldropdownvalue = title[0];
    countrydropdown = country[0];
    getStateData();
    getCityData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Create Supplier"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        controller: supplier_name,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          labelText: "Supplier Name",
                          labelStyle: subheadline,
                          hintText: "Supplier Name",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextFormField(
                        controller: mobile_no,
                        validator: MobNo,
                        decoration: InputDecoration(
                          labelText: "Mobile No.",
                          labelStyle: subheadline,
                          hintText: "Mobile No.",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        controller: email,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: subheadline,
                          hintText: "Email",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        controller: gst_no,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          labelText: "GSTIN No.",
                          labelStyle: subheadline,
                          hintText: "GSTIN No.",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: width * .45,
                          decoration: const BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: lightblackcolor,
                              width: 1.0,
                            ),
                          )),
                          child: TextField(
                            controller: opening_balance,
                            cursorColor: lightblackcolor,
                            decoration: InputDecoration(
                              labelText: "Opening Balance",
                              labelStyle: subheadline,
                              hintText: "Opening Balance",
                              hintStyle: subheadline,
                              border: InputBorder.none,
                            ),
                          )),
                      Container(
                        width: width * .40,
                        decoration: const BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            // color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: DropdownButton<Titel>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            "Select Title",
                            style: subheadline,
                          ),
                          value: Titeldropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: title.map((Titel title) {
                            return DropdownMenuItem<Titel>(
                              value: title,
                              child: Text("${title.title_name}".toString()),
                            );
                          }).toList(),
                          onChanged: (Titel? newValue) {
                            setState(() {
                              Titeldropdownvalue = newValue!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                    width: width * .40,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: Container(),
                      hint: Text(
                        "Select Country",
                        style: subheadline,
                      ),
                      value: countrydropdown,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: country.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          countrydropdown = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                      width: width * .40,
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
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
                      width: width * .40,
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        value: cityDropdown,
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
                            cityDropdown = newValue!;
                          });
                        },
                      )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Text(
                    "Address :",
                    style: subheadline3,
                  ),
                  SizedBox(
                    height: height * .01,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          //
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      ),
                      child: TextField(
                        controller: address,
                        cursorColor: lightblackcolor,
                        minLines: 1,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                          ),
                          hintText: "Address",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        controller: zipcode,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                          ),
                          hintText: "ZIP Code",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        controller: remarks,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                          ),
                          hintText: "Remarks",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                        ),
                      )),
                  SizedBox(
                    height: height * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: width * .20,
                          child: CupertinoButton(
                            onPressed: () {
                              // _formKey.currentState?.validate();
                              CreateSupplier();
                              Get.back();
                              // Get.to(SupplierDetails(),
                              //     duration: Duration(milliseconds: 500),
                              //     transition: Transition.rightToLeft);
                            },
                            child: Text("Submit"),
                            color: primarycolor,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            pressedOpacity: 0.6,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      Container(
                          width: width * .20,
                          child: CupertinoButton(
                            onPressed: () {},
                            child: Text("Cancle"),
                            color: lightblackcolor,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            pressedOpacity: 0.6,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                ],
              ),
            )));
  }
}
