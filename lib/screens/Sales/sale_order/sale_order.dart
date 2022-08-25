import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:intl/intl.dart';

import '../../../constants/style.dart';
import '../../customer/customer_form.dart';
import '../../item/add_item_form.dart';

class SalesOrder extends StatefulWidget {
  const SalesOrder({Key? key}) : super(key: key);

  @override
  State<SalesOrder> createState() => _SalesOrderState();
}

class _SalesOrderState extends State<SalesOrder> {
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
  String? saleTypedropdownvalue;
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

  var salesType = ['Direct', 'Quotation'];

  var saleOrder = [
    'Choose One',
  ];

  var challan = [
    'Choose One',
  ];

  var itemCentre = [
    'Main',
  ];

  var saleType = [
    'GST',
    'Excempt',
    'Import',
    'Nil Rated',
    'Unreg(RCM)',
    'Zero Rated',
  ];

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
    'Card',
    'Cheque',
    'Credit',
    'Online Payment',
    'Other'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datePicked = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Sales Order"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(children: [
              SizedBox(
                height: height * .02,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Credit Limit  ",
                  style: subheadline3,
                ),
                Text(
                  "0.00",
                  style: subheadline3,
                )
              ]),
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
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sales Type",
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
                                  "Select Sales Type",
                                  style: subheadline,
                                ),
                                value: salesTypedropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: salesType.map((String items) {
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
                                    salesTypedropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
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
                              "POS",
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
                                  "Select POS",
                                  style: subheadline,
                                ),
                                value: posdropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: pos.map((String items) {
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
                                    posdropdownvalue = newValue!;
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
                              "Customer",
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
                                      "Select Customer",
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
                                        Get.to(CustomerForm(),
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
                              "Sale Type",
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
                                  "Select Sale Type",
                                  style: subheadline,
                                ),
                                value: saleTypedropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: saleType.map((String items) {
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
                                    saleTypedropdownvalue = newValue!;
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
                              "Bill No",
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
                                "Bill Date",
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
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Date",
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
                              "Item Details",
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
                              "Stock",
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
                                  onPressed: () {},
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
                        dataList(context)
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(
                                color: bordercolor,
                                padding: EdgeInsets.all(5),
                                onPressed: () {
                                  setState(() {
                                    data = "payment";
                                  });
                                },
                                child: Text("Payment Mode")),
                            CupertinoButton(
                                color: bordercolor,
                                padding: EdgeInsets.all(5),
                                onPressed: () {
                                  setState(() {
                                    data = 'remarks';
                                  });
                                },
                                child: Text("Remarks")),
                            CupertinoButton(
                                color: bordercolor,
                                padding: EdgeInsets.all(5),
                                onPressed: () {
                                  setState(() {
                                    data = "invoice";
                                  });
                                },
                                child: Text("Invoice History"))
                          ],
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        data == "invoice"
                            ? Container(
                                // height: height * .30,
                                child: ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                      Text("Customer :"),
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
                                                      Text("Item :"),
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
                                                      Text("MRP :"),
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
                                                      Text("Discount :"),
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
                                                      Text("Account :"),
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
                                                      Text("Date :"),
                                                      Text("NA"),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * .01,
                                                  ),
                                                ]),
                                          ));
                                    }),
                              )
                            : data == "remarks"
                                ? Container(
                                    height: height * .10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: lightblackcolor,
                                            width: 0.4)),
                                    child: TextFormField(
                                      maxLines: null,
                                      minLines: null,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(left: 10),
                                          border: InputBorder.none),
                                    ))
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(children: [
                                            Text("Payment Mode"),
                                            Container(
                                              width: width * .20,
                                              height: height * .04,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: lightblackcolor,
                                                        width: 1)),
                                              ),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                underline: Container(),
                                                value: paymentmodedropdown,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: paymentmode
                                                    .map((String items) {
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
                                                    paymentmodedropdown =
                                                        newValue!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ]),
                                          Column(children: [
                                            Text("Reference No."),
                                            Container(
                                              width: width * .20,
                                              height: height * .04,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: lightblackcolor,
                                                        width: 1)),
                                              ),
                                              child: Container(
                                                  width: width * .58,
                                                  height: height * .04,
                                                  decoration: BoxDecoration(
                                                    border: const Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                lightblackcolor,
                                                            width: 1)),
                                                  ),
                                                  child: TextField(
                                                    cursorColor:
                                                        lightblackcolor,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 5),
                                                      border: InputBorder.none,
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                          Column(children: [
                                            Text("Amount"),
                                            Container(
                                              width: width * .20,
                                              height: height * .04,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: lightblackcolor,
                                                        width: 1)),
                                              ),
                                              child: Container(
                                                  width: width * .58,
                                                  height: height * .04,
                                                  decoration: BoxDecoration(
                                                    border: const Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                lightblackcolor,
                                                            width: 1)),
                                                  ),
                                                  child: TextFormField(
                                                    initialValue: "0",
                                                    textAlign: TextAlign.center,
                                                    cursorColor:
                                                        lightblackcolor,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 5),
                                                      border: InputBorder.none,
                                                    ),
                                                  )),
                                            ),
                                          ]),
                                        ],
                                      ),
                                      paymentmodedropdown == "Cheque"
                                          ? Column(children: [
                                              SizedBox(height: height * .02),
                                              Text(
                                                "Cheque Details:-",
                                                style: subheadline3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Cheque No:",
                                                    style: subheadline3,
                                                  ),
                                                  Container(
                                                      width: width * .58,
                                                      height: height * .04,
                                                      decoration: BoxDecoration(
                                                        border: const Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    lightblackcolor,
                                                                width: 1)),
                                                      ),
                                                      child: TextField(
                                                        cursorColor:
                                                            lightblackcolor,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 5),
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(height: height * .01),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Bank Name:",
                                                      style: subheadline3,
                                                    ),
                                                    Container(
                                                        width: width * .58,
                                                        height: height * .04,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: const Border(
                                                              bottom: BorderSide(
                                                                  color:
                                                                      lightblackcolor,
                                                                  width: 1)),
                                                        ),
                                                        child: TextField(
                                                          cursorColor:
                                                              lightblackcolor,
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    bottom: 5),
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        )),
                                                  ]),
                                            ])
                                          : paymentmodedropdown == "Card"
                                              ? Column(children: [
                                                  SizedBox(
                                                      height: height * .02),
                                                  Text(
                                                    "Card Details:-",
                                                    style: subheadline3,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Card No:",
                                                        style: subheadline3,
                                                      ),
                                                      Container(
                                                          width: width * .58,
                                                          height: height * .04,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: const Border(
                                                                bottom: BorderSide(
                                                                    color:
                                                                        lightblackcolor,
                                                                    width: 1)),
                                                          ),
                                                          child: TextField(
                                                            cursorColor:
                                                                lightblackcolor,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom:
                                                                          5),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * .01),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Bank Name:",
                                                          style: subheadline3,
                                                        ),
                                                        Container(
                                                            width: width * .58,
                                                            height:
                                                                height * .04,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: const Border(
                                                                  bottom: BorderSide(
                                                                      color:
                                                                          lightblackcolor,
                                                                      width:
                                                                          1)),
                                                            ),
                                                            child: TextField(
                                                              cursorColor:
                                                                  lightblackcolor,
                                                              decoration:
                                                                  InputDecoration(
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        bottom:
                                                                            5),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                            )),
                                                      ]),
                                                ])
                                              : paymentmodedropdown == "Credit"
                                                  ? Column(children: [
                                                      SizedBox(
                                                        height: height * .02,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text("Due Date"),
                                                          Container(
                                                              width:
                                                                  width * .30,
                                                              height:
                                                                  height * .04,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                      border:
                                                                          Border(
                                                                bottom:
                                                                    BorderSide(
                                                                  color:
                                                                      lightblackcolor,
                                                                  width: 1.0,
                                                                ),
                                                              )),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                    "${datePicked?.day}"
                                                                    "/"
                                                                    "${datePicked?.month}"
                                                                    "/"
                                                                    "${datePicked?.year}",
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        _showDObPicker();
                                                                      },
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        size:
                                                                            20,
                                                                      ))
                                                                ],
                                                              )),
                                                        ],
                                                      ),
                                                    ])
                                                  : Container(),
                                      Container(
                                        // height: height * .30,
                                        child: ListView.builder(
                                            itemCount: 1,
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  shadowColor: primarycolor,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height:
                                                                height * .01,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Mode :"),
                                                              Text("NA"),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * .01,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Ref.No :"),
                                                              Text("NA"),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * .01,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Bank :"),
                                                              Text("NA"),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * .01,
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
                                                            height:
                                                                height * .01,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Action :"),
                                                              Text("NA"),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * .01,
                                                          ),
                                                        ]),
                                                  ));
                                            }),
                                      ),
                                    ],
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
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "More Details",
                              style: subheadline3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Receivable",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .50,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
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
                                  "Currency Received",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .50,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
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
                                  "Total",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .50,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(bottom: 5),
                                        border: InputBorder.none,
                                      ),
                                    )),
                              ],
                            ),
                          ]))),
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

  Widget dataList(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: height * .30,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("SN :"), Text("${index + 1}")],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text("Return No :"),
                        //     Expanded(child: Text("NA")),
                        //   ],
                        // ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item Name :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Unit :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item Color :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Current Stock :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item Size :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item Code :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Qty :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Our Price :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("MRP :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Discount(%) :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Dicount(Amount) :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery Date :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Action"),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete,
                                    color: Color(0xffAB2328)))
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                      ]),
                ));
          }),
    );
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

  var _DeliveryDate;
  DateTime? DeliverydatePicked;

  Future<void> _DeliveryshowPicker() async {
    DeliverydatePicked = await showDatePicker(
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
      _DeliveryDate = DateFormat("dd-MM-yyyy").format(DeliverydatePicked!);
    });
  }
}
