import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/models.dart';
import 'package:hawks/Repository/ApiServices.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/color.dart';
import '../../constants/style.dart';
import '../../constants/url.dart';

class EditCompanyForm extends StatefulWidget {
  // String company_name,
  //     id,
  //     email,
  //     gst_no,
  //     contact_no,
  //     zipcode,
  //     username,
  //     locality,
  //     address;
  EditCompanyForm(
      // this.company_name, this.email, this.gst_no, this.zipcode,
      // this.username, this.locality, this.address, this.contact_no, this.id,
      {Key? key})
      : super(key: key);

  @override
  State<EditCompanyForm> createState() => _EditCompanyFormState();
}

class _EditCompanyFormState extends State<EditCompanyForm> {
  TextEditingController company_namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController gst_nocontroller = TextEditingController();
  TextEditingController contact_nocontroller = TextEditingController();
  TextEditingController zipcodecontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController localitycontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

  String? countrydropdownvalue;
  String? statedropdownvalue;
  String? citydropdownvalue;

  String? company_name,
      id,
      email,
      gst_no,
      contact_no,
      zipcode,
      username,
      locality,
      address;

  getdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      company_name = prefs.getString("companyName");
      email = prefs.getString("email");
      gst_no = prefs.getString("gstNo");
      contact_no = prefs.getString("contactNo");
      zipcode = prefs.getString("zipcode");
      username = prefs.getString("username");
      locality = prefs.getString("locality");
      address = prefs.getString("address");
    });
    print(company_name);
  }

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
  List citydata = [];
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

  late Language languagedropdown = Language(1, 'Hindi');
  List<Language> language = <Language>[
    Language(1, 'Hindi'),
    Language(2, 'English'),
    Language(3, 'French'),
    Language(4, 'Italian'),
    Language(5, 'Arabic'),
    Language(6, 'Afrikaans'),
    Language(7, 'Bengali'),
    Language(8, 'Chinese (Simplified)'),
    Language(9, 'Chinese (Traditional)'),
    Language(10, 'German'),
    Language(11, 'Greek'),
  ];

  late DateFormate dateformatedropdown = DateFormate(1, 'dd/MM/yyyy');
  List<DateFormate> dateFormate = <DateFormate>[
    DateFormate(1, 'dd/MM/yyyy'),
    DateFormate(2, 'dd/MM/yy'),
    DateFormate(3, 'd/M/yy'),
    DateFormate(4, 'yyyy-MM-dd'),
  ];

  //CreateCompany
  Future CreateCompany() async {
    var request = http.MultipartRequest('POST', Uri.parse(createCompany));
    request.fields.addAll({
      'company_name': company_namecontroller.text,
      'email': emailcontroller.text,
      'gst_no': gst_nocontroller.text,
      'pos': '1',
      'contact_no': contact_nocontroller.text,
      'est_year': _selectedDate,
      'country_id': '101',
      'state_id': "${statedropdownvalue}",
      'city_id': "${citydropdownvalue}",
      'zipcode': zipcodecontroller.text,
      'username': usernamecontroller.text,
      'locality': localitycontroller.text,
      'language': "${languagedropdown.Language_name}",
      'address': addresscontroller.text,
      'date': "${dateformatedropdown.dateformate_name}",
    });

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);

    if (response.statusCode == 200) {
      print(respStr);
      var encoded = json.decode(respStr);
      Fluttertoast.showToast(
          msg: encoded["message"],
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

  //EditCompany
  Future EditCompany() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    var request = http.MultipartRequest('POST', Uri.parse(edit_company));
    request.fields.addAll({
      'id': "${id}",
      'company_name': company_namecontroller.text,
      'email': emailcontroller.text,
      'gst_no': gst_nocontroller.text,
      'pos': '1',
      'contact_no': contact_nocontroller.text,
      'est_year': "${_selectedDate}",
      'country_id': '1',
      'state_id': "${statedropdownvalue}",
      'city_id': "${citydropdownvalue}",
      'zipcode': zipcodecontroller.text,
      'username': usernamecontroller.text,
      'locality': localitycontroller.text,
      'language': "${languagedropdown.Language_name}",
      'address': addresscontroller.text,
      'date': "${dateformatedropdown}"
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
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datePicked = DateTime.now();
    TypeofCompdropdown = typeofCom[0];
    countrydropdownvalue = country[0];
    languagedropdown = language[0];
    dateformatedropdown = dateFormate[0];
    getStateData();
    getCityData();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    company_namecontroller = TextEditingController(text: company_name);
    emailcontroller = TextEditingController(text: email);
    gst_nocontroller = TextEditingController(text: gst_no);
    contact_nocontroller = TextEditingController(text: contact_no);
    zipcodecontroller = TextEditingController(text: zipcode);
    usernamecontroller = TextEditingController(text: username);
    localitycontroller = TextEditingController(text: locality);
    addresscontroller = TextEditingController(text: address);

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
                                child: DropdownButton<Language>(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text(
                                    "Select Language",
                                    style: subheadline,
                                  ),
                                  value: languagedropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: language.map((Language? language) {
                                    return DropdownMenuItem<Language>(
                                      value: language,
                                      child: Text(
                                        "${language?.Language_name}",
                                        style: subheadline3,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (Language? newValue) {
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
                                    controller: addresscontroller,
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
                                child: DropdownButton<DateFormate>(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: Text(
                                    "Select DateFormat",
                                    style: subheadline,
                                  ),
                                  value: dateformatedropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: dateFormate
                                      .map((DateFormate? dateFormate) {
                                    return DropdownMenuItem<DateFormate>(
                                      value: dateFormate,
                                      child: Text(
                                        "${dateFormate?.dateformate_name}",
                                        style: subheadline3,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (DateFormate? newValue) {
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
                          EditCompany();
                          Get.back();
                          // ApiServices().Createcompany(
                          //     company_namecontroller.text,
                          //     emailcontroller.text,
                          //     gst_nocontroller.text,
                          //     "${TypeofCompdropdown.TypeofCom_name}",
                          //     contact_nocontroller.text,
                          //     _selectedDate,
                          //     "1",
                          //     "${statedropdownvalue}",
                          //     "${citydropdownvalue}",
                          //     zipcodecontroller.text,
                          //     usernamecontroller.text,
                          //     localitycontroller.text,
                          //     languagedropdown.Language_id,
                          //     addresscontroller.text,
                          //     dateformatedropdown!);
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
