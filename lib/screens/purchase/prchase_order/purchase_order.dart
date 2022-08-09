import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';

import '../../../constants/style.dart';
import '../../item/add_item_form.dart';

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({Key? key}) : super(key: key);

  @override
  State<PurchaseOrder> createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  String data = "payment";
  String? customerdropdownvalue;
  String? itemdropdownvalue;
  String? unitdropdownvalue;
  String? itemsizedropdownvalue;
  String? itemcolordropdownvalue;
  String? posdropdownvalue;
  String? salesTypedropdownvalue;
  String? salesOrderdropdownvalue;
  String? Challandropdownvalue;
  String? itemCentredropdownvalue;
  String? custTypedropdownvalue;
  String paymentmodedropdown = "Cash";
  var customer = [
    'Cash',
    'MOM & Me',
    'Miss.',
    'Mrs.',
  ];

  var pos = [
    'Uttar Pradesh',
    'Haryana',
  ];

  var salesType = ['Direct', 'Sale Order', 'Challan'];

  var saleOrder = [
    'Choose One',
  ];

  var challan = [
    'Choose One',
  ];

  var itemCentre = [
    'Main',
  ];

  var custType = ['Retail'];

  var item = [
    'Item Name',
    'Item Name1',
    'Item Name2',
    'Item Name3',
  ];

  var itemsize = ['S', 'XS', 'M', 'XM', 'L', 'XL'];

  var unit = [
    'PCS',
  ];

  var itemColor = ['CHARCOAL BLACK'];

  var paymentmode = [
    'Cash',
    'Credit',
    'Cheque',
    'Card',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datePicked = DateTime.now();
    datePicked1 = DateTime.now();
    datePicked2 = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Purchase Order"),
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
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Supplier",
                              style: subheadline3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                                      "Select Supplier",
                                      style: subheadline,
                                    ),
                                    value: customerdropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: customer.map((String items) {
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
                                        customerdropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    width: width * .08,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.lightBlueAccent),
                                    child: IconButton(
                                      onPressed: () {
                                        Get.to(SupplierForm(),
                                            transition: Transition.rightToLeft);
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      iconSize: 20,
                                    ))
                              ],
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
                              "Mobile No.",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
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
                            Text(
                              "PO No",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
                                ),
                                child: TextFormField(
                                  initialValue: "KAFDGG12412",
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
                              Text(
                                "PO Date",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .58,
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
                                        "${datePicked1?.day}"
                                        "/"
                                        "${datePicked1?.month}"
                                        "/"
                                        "${datePicked1?.year}",
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showDObPicker1();
                                          },
                                          icon: Icon(Icons.date_range))
                                    ],
                                  )),
                            ]),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Expected Date",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .58,
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
                                        "${datePicked?.day}"
                                        "/"
                                        "${datePicked?.month}"
                                        "/"
                                        "${datePicked?.year}",
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showDObPicker();
                                          },
                                          icon: Icon(Icons.date_range))
                                    ],
                                  )),
                            ]),
                      ]))),
              Card(
                  elevation: 2,
                  shadowColor: primarycolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(width: 0.4, color: lightblackcolor),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Container(
                            height: height * .04,
                            width: width,
                            decoration: BoxDecoration(
                              color: lightblackcolor,
                            ),
                            child: Center(
                                child: Text(
                              "Details",
                              textAlign: TextAlign.center,
                            ))),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SKU/Barcode",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
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
                            Text(
                              "Item",
                              style: subheadline3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                                      "Select Item",
                                      style: subheadline,
                                    ),
                                    value: itemdropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: item.map((String items) {
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
                                        itemdropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    width: width * .08,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.lightBlueAccent),
                                    child: IconButton(
                                      onPressed: () {
                                        Get.to(AddItem(),
                                            transition: Transition.rightToLeft);
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      iconSize: 20,
                                    ))
                              ],
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
                              "Select Unit",
                              style: subheadline3,
                            ),
                            Container(
                              width: width * .58,
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
                                  "Select Unit",
                                  style: subheadline,
                                ),
                                value: unitdropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: unit.map((String items) {
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
                                    unitdropdownvalue = newValue!;
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
                              "Item Color",
                              style: subheadline3,
                            ),
                            Container(
                              width: width * .58,
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
                                  "Select Item Color",
                                  style: subheadline,
                                ),
                                value: itemcolordropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: itemColor.map((String items) {
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
                                    itemcolordropdownvalue = newValue!;
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
                              "Item Size",
                              style: subheadline3,
                            ),
                            Container(
                              width: width * .58,
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
                                  "Select Item Size",
                                  style: subheadline,
                                ),
                                value: itemcolordropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: itemColor.map((String items) {
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
                                    itemcolordropdownvalue = newValue!;
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
                              "Qty",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
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
                            Text(
                              "Price",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: const Border(
                                      bottom: BorderSide(
                                          color: lightblackcolor, width: 1)),
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
                          height: height * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: width * .20,
                                child: CupertinoButton(
                                  onPressed: () {
                                    // Get.back();
                                  },
                                  child: Text("Add"),
                                  color: primarycolor,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  pressedOpacity: 0.6,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Container(
                          height: height * .50,
                          child: ListView.builder(
                              itemCount: 1,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Item Color :"),
                                                Text("NA"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Item Size :"),
                                                Text("NA"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Quantity :"),
                                                Text("NA"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Unit Type :"),
                                                Text("NA"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Amount :"),
                                                Text("NA"),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Action"),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.delete,
                                                        color:
                                                            Color(0xffAB2328)))
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                          ]),
                                    ));
                              }),
                        )
                      ]))),
              Card(
                  elevation: 2,
                  shadowColor: primarycolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(width: 0.4, color: lightblackcolor),
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Text(
                          "Remarks",
                          style: subheadline3,
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Container(
                            height: height * .10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: lightblackcolor, width: 0.4)),
                            child: TextFormField(
                              maxLines: null,
                              minLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: InputBorder.none),
                            ))
                      ]))),
              SizedBox(
                height: height * .02,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  "Total",
                  style: subheadline3,
                ),
                Container(
                    width: width * .58,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: lightblackcolor, width: 1)),
                    child: TextFormField(
                      maxLines: null,
                      minLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          border: InputBorder.none),
                    ))
              ]),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: width * .20,
                      child: CupertinoButton(
                        onPressed: () {
                          // Get.back();
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
            ])));
  }

  var _selectedDate;
  DateTime? datePicked;

  Future<void> _showDObPicker() async {
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

  var _selectedDate1;
  DateTime? datePicked1;

  Future<void> _showDObPicker1() async {
    datePicked1 = await showDatePicker(
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
      _selectedDate1 = DateFormat("dd-MM-yyyy").format(datePicked1!);
    });
  }

  var _selectedDate2;
  DateTime? datePicked2;

  Future<void> _showDObPicker2() async {
    datePicked2 = await showDatePicker(
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
      _selectedDate2 = DateFormat("dd-MM-yyyy").format(datePicked2!);
    });
  }
}
