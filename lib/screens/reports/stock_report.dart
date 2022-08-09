import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/customer/customer_form.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';
import '../../constants/style.dart';

class StockReport extends StatefulWidget {
  const StockReport({Key? key}) : super(key: key);

  @override
  State<StockReport> createState() => _StockReportState();
}

class _StockReportState extends State<StockReport> {
  final TextEditingController _search = TextEditingController();
  String? branchdropdownvalue;
  String? itemdropdownvalue;
  String? categorydropdownvalue;
  String? sizedropdownvalue;
  String? colordropdownvalue;
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

  var category = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  var size = ['S', 'M', 'L', 'XL', '1X', '2X', '3X', '4X'];

  var color = [
    'RUBINE PINK',
    'CHARCOAL BLACK',
    'LAVENDER',
    'BROWN',
    'GREY',
    'LIGHT BEIGE',
    'PURPALE',
    'OFF WHITE',
    'RED',
    'PEACH',
    'ROYAL BLUE',
    'NAVY',
    'MAROON',
    'PEARL WHITE',
    'IMPERIAL BLUE',
    'BEIGE',
    'ORANGE',
    'YELLOW',
    'BLACK',
    'GREEN',
    'BLACK GREY',
    'BLACK WINE',
    'BLUE',
    'FUSHIA',
    'ROSE GREEN',
    'GREY MUSTARD',
    'ICE BLUE',
    'LEMON',
    'LILAC',
    'MAROOM',
    'MUSTARD',
    'OLIVE',
    'PINK',
    'PINK GREEN',
    'ROSE PINK',
    'SHAMBREY',
    'WINE',
    'IVERY',
    'SAND',
    'WHITE',
    'ROSE BLACK',
    'ONION',
    'APPLE',
    'ROSE',
    'SAGE',
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
          title: Text("Stock Report"),
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
                    "Category",
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
                        "Select Category",
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
                    "Barcode",
                    style: subheadline3,
                  ),
                  Container(
                      width: width * .58,
                      height: height * .04,
                      decoration: BoxDecoration(
                        border: const Border(
                            bottom:
                                BorderSide(color: lightblackcolor, width: 1)),
                      ),
                      child: TextField(
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 5),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Size",
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
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            "Select Size",
                            style: subheadline,
                          ),
                          value: sizedropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: size.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              sizedropdownvalue = newValue!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Color",
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
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            "Select Color",
                            style: subheadline,
                          ),
                          value: colordropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: color.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              colordropdownvalue = newValue!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
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
                                  children: [
                                    Text("SN :"),
                                    Text("${index + 1}")
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Item Name	 :"),
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
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Color :"),
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
                                    Text("Size :"),
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
                                      Text("Opening Stock	:"),
                                      Text("NA"),
                                    ]),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Op. Stock Value :"),
                                      Text("NA"),
                                    ]),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("In Stock :"),
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
                                    Text("Out Stock :"),
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
                                    Text("Current Stock :"),
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
                                    Text("Pur. Price :"),
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
                                    Text("Pur. Total :"),
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
                                    Text("MRP :"),
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
                                    Text("MRP Total :"),
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
