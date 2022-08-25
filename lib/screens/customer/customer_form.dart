import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:hawks/constants/url.dart';
import 'package:hawks/screens/customer/customer_details.dart';
import 'package:http/http.dart' as http;
import '../../Model/models.dart';
import '../../constants/color.dart';
import '../../constants/style.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({Key? key}) : super(key: key);

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final TextEditingController customer_name = TextEditingController();
  final TextEditingController mobile_no = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController gst_no = TextEditingController();
  final TextEditingController birthday = TextEditingController();
  final TextEditingController anniversary = TextEditingController();
  final TextEditingController opening_balance = TextEditingController();
  final TextEditingController credit_days = TextEditingController();
  final TextEditingController creadit_limit = TextEditingController();
  final TextEditingController billing_address = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController zipcode = TextEditingController();

  String? dropdownvalue;
  String? countrydropdown;
  String? statedropdownvalue;
  String? cityDropdown;

  late Titel Titeldropdownvalue = Titel(1, "Dr.");
  List<Titel> title = <Titel>[
    Titel(1, 'Dr.'),
    Titel(2, 'Er.'),
    Titel(3, 'Miss.'),
    Titel(4, 'Mrs.'),
  ];

  Future CreateCustomer() async {
    var request = http.MultipartRequest('POST', Uri.parse(create_customer));
    request.fields.addAll({
      'customer_name': customer_name.text,
      'mobile_no': mobile_no.text,
      'email': email.text,
      'gst_no': gst_no.text,
      'birthday': birthday.text,
      'anniversary': '',
      'opening_balance': opening_balance.text,
      'title': "${Titeldropdownvalue.title_id}",
      'credit_days': credit_days.text,
      'creadit_limit': creadit_limit.text,
      'billing_address': billing_address.text,
      'country_id': '101',
      'state_id': "${statedropdownvalue}",
      'city_id': "${cityDropdown}",
      'address': address.text,
      'zipcode': zipcode.text
    });

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
          title: Text("Create Customer"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: ListView(
            children: [
              SizedBox(
                height: height * .02,
              ),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      //                   <--- left side
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextField(
                    controller: customer_name,
                    cursorColor: lightblackcolor,
                    decoration: InputDecoration(
                      labelText: "Customer Name",
                      labelStyle: subheadline,
                      hintText: "Customer Name",
                      hintStyle: subheadline,
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
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextField(
                    controller: mobile_no,
                    cursorColor: lightblackcolor,
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
                  decoration: BoxDecoration(
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
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      //                   <--- left side
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
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      //                   <--- left side
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextField(
                    controller: birthday,
                    cursorColor: lightblackcolor,
                    decoration: InputDecoration(
                      labelText: "Birthday",
                      labelStyle: subheadline,
                      hintText: "Birthday",
                      hintStyle: subheadline,
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
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextField(
                    controller: anniversary,
                    cursorColor: lightblackcolor,
                    decoration: InputDecoration(
                      labelText: "Anniversary",
                      labelStyle: subheadline,
                      hintText: "Anniversary",
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
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          //                   <--- left side
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
              Row(
                children: [
                  Text(
                    "Multiple Address",
                    style: subheadline3,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add))
                ],
              ),
              Container(
                width: width * .40,
                decoration: BoxDecoration(
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
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      hintText: "Address",
                      hintStyle: subheadline,
                      border: InputBorder.none,
                    ),
                  )),
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
                    controller: billing_address,
                    cursorColor: lightblackcolor,
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      hintText: "Billing Address",
                      hintStyle: subheadline,
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
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextField(
                    controller: zipcode,
                    cursorColor: lightblackcolor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      hintText: "ZIP Code",
                      hintStyle: subheadline,
                      labelText: "ZIP Code",
                      labelStyle: subheadline,
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
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextField(
                    controller: credit_days,
                    cursorColor: lightblackcolor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      hintText: "Credit Days",
                      hintStyle: subheadline,
                      labelText: "Credit Days",
                      labelStyle: subheadline,
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
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextField(
                    controller: creadit_limit,
                    cursorColor: lightblackcolor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 10,
                      ),
                      hintText: "Credit limit",
                      hintStyle: subheadline,
                      labelText: "Credit limit",
                      labelStyle: subheadline,
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
                        onPressed: () async {
                          await CreateCustomer().then((value) => Get.back());
                          //Get.back();
                        },
                        child: Text("Save"),
                        color: primarycolor,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        pressedOpacity: 0.6,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                  Container(
                      width: width * .20,
                      child: CupertinoButton(
                        onPressed: () {},
                        child: Text("Cancel"),
                        color: lightblackcolor,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        pressedOpacity: 0.6,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ))
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
            ],
          ),
        ));
  }
}
