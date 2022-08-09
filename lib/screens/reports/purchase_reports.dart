import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/customer/customer_form.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';
import '../../constants/style.dart';

class PurchaseReports extends StatefulWidget {
  const PurchaseReports({Key? key}) : super(key: key);

  @override
  State<PurchaseReports> createState() => _PurchaseReportsState();
}

class _PurchaseReportsState extends State<PurchaseReports> {
  String? branchdropdownvalue;
  String? itemdropdownvalue;
  String? userwisedropdownvalue;
  String? supplierwisedownvalue;
  var branches = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  var items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  var userwise = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  var supplierwise = [
    'ABC PVT LTD',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todatePicked = DateTime.now();
    fromdatePicked = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Purchase Report"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Branch Wise",
                    style: subheadline3,
                  ),
                  Container(
                    width: width * .58,
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
                        "Select Branch",
                        style: subheadline,
                      ),
                      value: branchdropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: branches.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          branchdropdownvalue = newValue!;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ItemWise",
                    style: subheadline3,
                  ),
                  Container(
                    width: width * .58,
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
                        "Select Item",
                        style: subheadline,
                      ),
                      value: itemdropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          itemdropdownvalue = newValue!;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Supplier Wise",
                    style: subheadline3,
                  ),
                  Container(
                    width: width * .58,
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
                        "Select Supplier",
                        style: subheadline,
                      ),
                      value: supplierwisedownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: supplierwise.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          supplierwisedownvalue = newValue!;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "User Wise",
                    style: subheadline3,
                  ),
                  Container(
                    width: width * .58,
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
                        "Select User",
                        style: subheadline,
                      ),
                      value: userwisedropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: userwise.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          userwisedropdownvalue = newValue!;
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "From",
                          style: subheadline3,
                        ),
                        SizedBox(
                          width: width * .04,
                        ),
                        Container(
                          width: width * .35,
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
                                  "${fromdatePicked?.day}"
                                  "/"
                                  "${fromdatePicked?.month}"
                                  "/"
                                  "${fromdatePicked?.year}",
                                  style: subheadline3,
                                ),
                                IconButton(
                                    onPressed: () {
                                      _showDatePicker1();
                                    },
                                    icon: Icon(Icons.date_range)),
                              ]),
                        )
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "To",
                          style: subheadline3,
                        ),
                        SizedBox(
                          width: width * .04,
                        ),
                        Container(
                            width: width * .30,
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
                                  "${todatePicked?.day}"
                                  "/"
                                  "${todatePicked?.month}"
                                  "/"
                                  "${todatePicked?.year}",
                                  style: subheadline3,
                                ),
                                IconButton(
                                    onPressed: () {
                                      _showDatePicker1();
                                    },
                                    icon: Icon(Icons.date_range))
                              ],
                            ))
                      ]),
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: width * .20,
                      child: CupertinoButton(
                        onPressed: () {},
                        child: Text("Search"),
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
              ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: primarycolor,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("Date :"), Text("NA")],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Bill No :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Supplier Name :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Contact No :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Item Name :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("SKU :"),
                                      Text("NA"),
                                    ]),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Qty :"),
                                      Text("NA"),
                                    ]),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Price :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("GST(%) :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("GST(Amt) :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Amount :"),
                                    Text("NA"),
                                  ],
                                ),
                              ]),
                          // )
                        ));
                  }),
            ],
          ),
        ));
  }

  DateTime? fromdatePicked;
  var _selectedDate;
  Future<void> _showDatePicker() async {
    fromdatePicked = await showDatePicker(
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
      _selectedDate = DateFormat("dd-MM-yyyy").format(fromdatePicked!);
    });
  }

  DateTime? todatePicked;
  var _selectedDate1;
  Future<void> _showDatePicker1() async {
    todatePicked = await showDatePicker(
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
      _selectedDate1 = DateFormat("dd-MM-yyyy").format(todatePicked!);
    });
  }
}
