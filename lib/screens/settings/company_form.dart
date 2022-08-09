import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawks/Model/models.dart';
import 'package:hawks/Repository/ApiServices.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../constants/color.dart';
import '../../constants/style.dart';
import '../../constants/url.dart';

class CompanyForm extends StatefulWidget {
  const CompanyForm({Key? key}) : super(key: key);

  @override
  State<CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final TextEditingController company_namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController gst_nocontroller = TextEditingController();
  final TextEditingController poscontroller = TextEditingController();
  final TextEditingController contact_nocontroller = TextEditingController();
  final TextEditingController zipcodecontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController localitycontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();

  String? countrydropdownvalue;
  String? statedropdownvalue;
  String? citydropdownvalue;
  String? languagedropdown;
  String? dateformatedropdown;

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

  late TypeofCom TypeofCompdropdown = TypeofCom(1, 'Registered');
  List<TypeofCom> typeofCom = <TypeofCom>[
    TypeofCom(1, 'Registered'),
    TypeofCom(2, 'Un-Registered'),
    TypeofCom(3, 'Composition'),
    TypeofCom(4, 'UIN-Holder'),
  ];

  Future CreateCompany() async {
    var request = http.MultipartRequest('POST', Uri.parse(createCompany));
    request.fields.addAll({
      'company_name': 'test',
      'email': 'test@gmail.co',
      'gst_no': 'ABC9874561230',
      'pos': '1',
      'contact_no': '7410258963',
      'est_year': '2021',
      'country_id': '1',
      'state_id': '1',
      'city_id': '1',
      'zipcode': '741258',
      'username': 'testest',
      'locality': 'test',
      'language': 'hindi',
      'address': 'gurugram',
      'date': '1'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  var country = [
    'India',
    'Nepal',
    'USA',
    'Australia',
    'Japan',
  ];

  var state = [
    'Haryana',
    'Bihar',
    'Uttar Pradesh',
  ];

  var city = [
    'Gurgaon',
    'Noida',
  ];

  var language = [
    'Hindi',
    'English',
  ];

  var dateFormate = ['dd/MM/yyyy', 'dd/MM/yy', 'd/M/yy'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datePicked = DateTime.now();
    TypeofCompdropdown = typeofCom[0];
    countrydropdownvalue = country[0];
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
          title: Text("Add Company"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(children: [
              SizedBox(
                height: height * .02,
              ),
              Card(
                  elevation: 2,
                  shadowColor: primarycolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(width: 0.4, color: lightblackcolor),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                              height: height * .04,
                              decoration: BoxDecoration(color: lightblackcolor),
                              child: Center(
                                child: Text(
                                  "Company Details",
                                  style: subheadline3,
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Company Name",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextField(
                                    controller: company_namecontroller,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "GSTIN No.",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextField(
                                    controller: gst_nocontroller,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email (Login Id)",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextField(
                                    controller: emailcontroller,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Type of Comp.",
                                style: subheadline3,
                              ),
                              Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: DropdownButton<TypeofCom>(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text(
                                    "Select Type of company",
                                    style: subheadline,
                                  ),
                                  value: TypeofCompdropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: typeofCom.map((TypeofCom? typeofCom) {
                                    return DropdownMenuItem<TypeofCom>(
                                      value: typeofCom,
                                      child: Text(
                                        "${typeofCom?.TypeofCom_name}",
                                        style: subheadline3,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (TypeofCom? newValue) {
                                    setState(() {
                                      TypeofCompdropdown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contact No.",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextField(
                                    controller: contact_nocontroller,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Username",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextField(
                                    controller: usernamecontroller,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Est. Year:",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: lightblackcolor,
                                      width: 1.0,
                                    ),
                                  )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${datePicked?.year}",
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showDObPicker();
                                          },
                                          icon: Icon(
                                            Icons.date_range,
                                            size: 20,
                                          ))
                                    ],
                                  )),
                            ],
                          ),
                        ],
                      ))),
              Card(
                  elevation: 2,
                  shadowColor: primarycolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(width: 0.4, color: lightblackcolor),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                              height: height * .04,
                              decoration: BoxDecoration(color: lightblackcolor),
                              child: Center(
                                child: Text(
                                  "Company Address",
                                  style: subheadline3,
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Country",
                                style: subheadline3,
                              ),
                              Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text(
                                    "--Select Country--",
                                    style: subheadline,
                                  ),
                                  value: countrydropdownvalue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: country.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: subheadline3,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      countrydropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "State",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: DropdownButton(
                                      isExpanded: true,
                                      underline: Container(),
                                      value: statedropdownvalue,
                                      hint: Text(
                                        "Select State",
                                        style: loginhinttext,
                                      ),
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
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
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "City",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
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
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ZIP Code",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextField(
                                    controller: zipcodecontroller,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Locality",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextField(
                                    controller: localitycontroller,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Language",
                                style: subheadline3,
                              ),
                              Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text(
                                    "Select Language",
                                    style: subheadline,
                                  ),
                                  value: languagedropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: language.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: subheadline3,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      languagedropdown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Address",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .50,
                                  height: height * .04,
                                  decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: lightblackcolor, width: 1)),
                                  ),
                                  child: TextFormField(
                                    minLines: null,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(bottom: 5),
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date Format",
                                style: subheadline3,
                              ),
                              Container(
                                width: width * .50,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text(
                                    "Select Format",
                                    style: subheadline,
                                  ),
                                  value: dateformatedropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: dateFormate.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: subheadline3,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dateformatedropdown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: width * .20,
                      child: CupertinoButton(
                        onPressed: () {
                          ApiServices().Createcompany(
                              company_namecontroller.text,
                              emailcontroller.text,
                              gst_nocontroller.text,
                              "${TypeofCompdropdown.TypeofCom_name}",
                              contact_nocontroller.text,
                              _selectedDate,
                              "1",
                              "${statedropdownvalue}",
                              "${citydropdownvalue}",
                              zipcodecontroller.text,
                              usernamecontroller.text,
                              localitycontroller.text,
                              languagedropdown!,
                              addresscontroller.text,
                              dateformatedropdown!);
                          // _formKey.currentState?.validate();
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
                height: height * .02,
              )
            ])));
  }

  var _selectedDate;
  DateTime? datePicked;

  Future<void> _showDObPicker() async {
    datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: primarycolor),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        });

    setState(() {
      _selectedDate = DateFormat("yyyy").format(datePicked!);
    });
  }
}
