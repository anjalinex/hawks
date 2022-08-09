import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:hawks/constants/color.dart';
import 'package:intl/intl.dart';

import '../../constants/style.dart';
import '../supplier/supplier_form.dart';

class CustomerCrDr extends StatefulWidget {
  const CustomerCrDr({Key? key}) : super(key: key);

  @override
  State<CustomerCrDr> createState() => _CustomerCrDrState();
}

class _CustomerCrDrState extends State<CustomerCrDr> {
  // bool Cheque = false;
  // bool online_transfer = false;
  // bool cash = true;

  String? gender = "cash";
  String? customerdropdownvalue;
  var customer = [
    'Cash',
    'MOM & Me',
    'Miss.',
    'Mrs.',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datePicked = DateTime.now();
    cheuqedatePicked = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Customer CR/DR"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(children: [
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Entry No.",
                    style: subheadline3,
                  ),
                  Container(
                    width: width * .50,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextFormField(
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expected Date",
                    style: subheadline3,
                  ),
                  Container(
                      width: width * .50,
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${datePicked?.day}"
                            "/"
                            "${datePicked?.month}"
                            "/"
                            "${datePicked?.year}",
                            style: subheadline3,
                          ),
                          IconButton(
                              onPressed: () {
                                _showDatePicker();
                              },
                              icon: Icon(Icons.date_range))
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customer",
                    style: subheadline3,
                  ),
                  Container(
                    width: width * .50,
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
                        "Select Customer",
                        style: subheadline,
                      ),
                      value: customerdropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: customer.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          customerdropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: "cheque",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          }),
                      Text(
                        "cheque",
                        style: subheadline3,
                      ),
                    ],
                  ),
                  Row(children: [
                    Radio(
                        value: "online Transfer",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    Text(
                      "Online Transfer",
                      style: subheadline3,
                    ),
                  ]),
                  Row(children: [
                    Radio(
                        value: "cash",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    Text(
                      "Cash",
                      style: subheadline3,
                    ),
                  ])
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              gender == "cheque"
                  ? Container(
                      child: Column(
                      children: [
                        Container(
                            child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: lightblackcolor,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "Bank Details",
                                      style: subheadline,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Cheque Number",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .50,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Cheque Date",
                                            style: subheadline3,
                                          ),
                                          Container(
                                              width: width * .50,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                bottom: BorderSide(
                                                  color: lightblackcolor,
                                                  width: 1.0,
                                                ),
                                              )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${cheuqedatePicked?.day}"
                                                    "/"
                                                    "${cheuqedatePicked?.month}"
                                                    "/"
                                                    "${cheuqedatePicked?.year}",
                                                    style: subheadline3,
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        _showDatePicker1();
                                                      },
                                                      icon: Icon(
                                                          Icons.date_range))
                                                ],
                                              ))
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bank Name",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .50,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Narration",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLength: null,
                                              maxLines: null,
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          height: height * .02,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: lightblackcolor,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sub Total",
                                        style: subheadline3,
                                      ),
                                      Text(
                                        "Amount",
                                        style: subheadline3,
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: subheadline3,
                                      ),
                                      Container(
                                        width: width * .50,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: lightblackcolor,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: TextFormField(
                                          cursorColor: lightblackcolor,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Paid",
                                        style: subheadline3,
                                      ),
                                      Container(
                                        width: width * .50,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: lightblackcolor,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: TextFormField(
                                          cursorColor: lightblackcolor,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Current Balance",
                                        style: subheadline3,
                                      ),
                                      Container(
                                        width: width * .50,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: lightblackcolor,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: TextFormField(
                                          cursorColor: lightblackcolor,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
                  : gender == "online Transfer"
                      ? Container(
                          child: Column(
                          children: [
                            Container(
                                child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: lightblackcolor,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Bank Details",
                                          style: subheadline,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Transaction Number",
                                                style: subheadline3,
                                              ),
                                              Container(
                                                width: width * .45,
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                  bottom: BorderSide(
                                                    color: lightblackcolor,
                                                    width: 1.0,
                                                  ),
                                                )),
                                                child: TextFormField(
                                                  cursorColor: lightblackcolor,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              )
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Transaction Date",
                                                style: subheadline3,
                                              ),
                                              Container(
                                                  width: width * .45,
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                    bottom: BorderSide(
                                                      color: lightblackcolor,
                                                      width: 1.0,
                                                    ),
                                                  )),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${cheuqedatePicked?.day}"
                                                        "/"
                                                        "${cheuqedatePicked?.month}"
                                                        "/"
                                                        "${cheuqedatePicked?.year}",
                                                        style: subheadline3,
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            _showDatePicker1();
                                                          },
                                                          icon: Icon(
                                                              Icons.date_range))
                                                    ],
                                                  ))
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Bank Name",
                                                style: subheadline3,
                                              ),
                                              Container(
                                                width: width * .45,
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                  bottom: BorderSide(
                                                    color: lightblackcolor,
                                                    width: 1.0,
                                                  ),
                                                )),
                                                child: TextFormField(
                                                  cursorColor: lightblackcolor,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              )
                                            ]),
                                        SizedBox(
                                          height: height * .02,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Narration",
                                                style: subheadline3,
                                              ),
                                              Container(
                                                width: width * .45,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: lightblackcolor,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLength: null,
                                                  maxLines: null,
                                                  cursorColor: lightblackcolor,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              )
                                            ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                            SizedBox(
                              height: height * .02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: lightblackcolor,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Sub Total",
                                            style: subheadline3,
                                          ),
                                          Text(
                                            "Amount",
                                            style: subheadline3,
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .45,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Paid",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .45,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Current Balance",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .45,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
                      : Container(
                          child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: lightblackcolor,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Sub Total",
                                            style: subheadline3,
                                          ),
                                          Text(
                                            "Amount",
                                            style: subheadline3,
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .50,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Paid",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .50,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Current Balance",
                                            style: subheadline3,
                                          ),
                                          Container(
                                            width: width * .50,
                                            decoration: const BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: lightblackcolor,
                                                width: 1.0,
                                              ),
                                            )),
                                            child: TextFormField(
                                              cursorColor: lightblackcolor,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                        ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
              SizedBox(
                height: height * .02,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Amount",
                  style: subheadline3,
                ),
                Container(
                  width: width * .50,
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: TextFormField(
                    cursorColor: lightblackcolor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                )
              ]),
              SizedBox(
                height: height * .02,
              ),
              Center(
                  child: Container(
                      width: width * .20,
                      child: CupertinoButton(
                        onPressed: () {},
                        child: Text("Save"),
                        color: primarycolor,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ))),
              SizedBox(
                height: height * .02,
              ),
            ])));
  }

  DateTime? datePicked;
  var _selectedDate;
  Future<void> _showDatePicker() async {
    datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
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
      _selectedDate = DateFormat("dd-MM-yyyy").format(datePicked!);
    });
  }

  DateTime? cheuqedatePicked;
  var _selectedDate1;
  Future<void> _showDatePicker1() async {
    cheuqedatePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
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
      _selectedDate1 = DateFormat("dd-MM-yyyy").format(cheuqedatePicked!);
    });
  }
}
