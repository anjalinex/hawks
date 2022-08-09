import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/sales_return.dart';
import 'package:intl/intl.dart';
import '../../constants/style.dart';
import '../item/add_item_form.dart';

class CreateSaleReturn extends StatefulWidget {
  const CreateSaleReturn({Key? key}) : super(key: key);

  @override
  State<CreateSaleReturn> createState() => _CreateSaleReturnState();
}

class _CreateSaleReturnState extends State<CreateSaleReturn> {
  String? customerdropdownvalue;
  String? GSTTypedropdown;
  String? saletypedropdownvalue;
  String? posDropdown;
  String? itemCenterDropdown;
  String? cusTypedropdown;
  String? itemdropdownvalue;
  String? unitdropdownvalue;
  String? itemsizedropdownvalue;
  String? itemcolordropdownvalue;
  String bill_no = "KAVI1586OS2";
  var customer = [
    'Cash',
    'MOM & Me',
    'Miss.',
    'Mrs.',
  ];

  var GSTType = [
    'GST',
    'Non GST',
    'Excempt',
    'Nil Rated',
    'Zero Rated',
  ];

  var saleType = [
    'Direct',
    'Sale order',
    'Challan',
  ];

  var pos = [
    'Direct',
    'Sale order',
    'Challan',
  ];

  var itemCenter = [
    'Main',
  ];

  var CusType = [
    'Retail',
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
          title: Text("Sales Return"),
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
                              "Customer",
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
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address :",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: lightblackcolor,
                                    width: 1.0,
                                  ),
                                ),
                                child: TextFormField(
                                  cursorColor: lightblackcolor,
                                  minLines: null,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 5, left: 5),
                                    border: InputBorder.none,
                                  ),
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
                              "Mobile No.",
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
                                child: TextField(
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    labelText: "Mobile No.",
                                    labelStyle: subheadline,
                                    hintText: "Mobile No.",
                                    hintStyle: subheadline,
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
                                "POS",
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
                                    "Select POS",
                                    style: subheadline,
                                  ),
                                  value: posDropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: pos.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      posDropdown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "GST Type",
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
                                    "Select GST Type",
                                    style: subheadline,
                                  ),
                                  value: GSTTypedropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: GSTType.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      GSTTypedropdown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Item Centre",
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
                                    "Select Item Centre",
                                    style: subheadline,
                                  ),
                                  value: itemCenterDropdown,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: itemCenter.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      itemCenterDropdown = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: height * .02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bill No.",
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
                                child: Text(
                                  bill_no,
                                  textAlign: TextAlign.center,
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
                              "Select Bill No.",
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
                                child: Text(
                                  bill_no,
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      ]))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: width * .20,
                      child: CupertinoButton(
                        child: Text("Show Bill"),
                        color: primarycolor,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        pressedOpacity: 0.6,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        onPressed: () {
                          // Get.to(SalesReturn(),
                          //     transition: Transition.rightToLeft);
                        },
                      )),
                ],
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
                        datalist(context)
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
                            Text(
                              "Total",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Excl",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "GST",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand Total",
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
                      ])))
            ])));
  }

  Widget datalist(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
                            Text("Sold Qty :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ret Qty :"),
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
}
