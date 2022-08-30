import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:intl/intl.dart';

import '../../../Model/models.dart';
import '../../../Model/viewsalesorder.dart';
import '../../../Repository/ApiServices.dart';
import '../../../constants/style.dart';
import '../../../constants/url.dart';
import '../../customer/customer_form.dart';
import '../../item/add_item_form.dart';
import 'package:http/http.dart' as http;

class SalesOrder extends StatefulWidget {
  const SalesOrder({Key? key}) : super(key: key);

  @override
  State<SalesOrder> createState() => _SalesOrderState();
}

class _SalesOrderState extends State<SalesOrder> {
  final _formKey = GlobalKey<FormState>();
  void _processData() {
    _formKey.currentState?.reset();
  }

  bool? isLoading = false;
  TextEditingController mobileNo = TextEditingController();
  TextEditingController bill_no = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();

  String data = "payment";
  String? customerdropdownvalue;
  String? itemdropdownvalue;
  String? posdropdownvalue;
  String? itemCentredropdownvalue;
  String paymentmodedropdown = "Cash";

  //Get Customer Data
  List customerData = [];
  Future<String> getcustomerData() async {
    http.Response response =
        await http.get(Uri.parse(view_customer_details)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        customerData = data["data"];
        print(customerData);
      });
      return response;
    });
    return "success";
  }

  //State Data
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

  //get Item Data
  List itemData = [];
  Future<String> getitemData() async {
    http.Response response =
        await http.get(Uri.parse(view_item_details)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        itemData = data["data"];
      });
      return response;
    });
    return "success";
  }

  //get item by Id
  List ItemIdData = [];
  var req_qty, expected_date, pricedata, skubarcode, Stock;
  Future<String> getItemIdData() async {
    http.Response response = await http.post(Uri.parse(view_item),
        body: {'id': itemdropdownvalue}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        ItemIdData = data["data"];
        skubarcode = ItemIdData[0]["sku"];
        itemSizedropdown = ItemIdData[0]["itme_size_id"];
        itemcolordropdown = ItemIdData[0]["item_color_id"];
        Stock = ItemIdData[0]["minimum_stock"];
        req_qty = "${1}";
        pricedata = ItemIdData[0]["mrp"];
        barcode = TextEditingController(text: skubarcode);
        stock = TextEditingController(text: Stock);
        qty = TextEditingController(text: req_qty);
        price = TextEditingController(text: pricedata);
        print("ItemIdData${ItemIdData}");
      });
      return response;
    });
    return "success";
  }

  //Customer Data
  List CustomerDataById = [];
  var mobile_no, credit_limits;
  Future<String> getCustomerDataById() async {
    http.Response response =
        await http.post(Uri.parse(view_customer_byid), body: {
      "id": customerdropdownvalue,
    }).then((response) {
      var data = json.decode(response.body);
      setState(() {
        CustomerDataById = data["data"];
        mobile_no = CustomerDataById[0]["mobile_no"];
        posdropdownvalue = CustomerDataById[0]["state_id"];
        credit_limits = CustomerDataById[0]["creadit_limit"];
        mobileNo = TextEditingController(text: mobile_no);
        print(CustomerDataById);
      });
      return response;
    });
    return "success";
  }

  late Unit unitdropdown = Unit(1, "PCS");
  List<Unit> unit = <Unit>[
    Unit(1, 'PCS'),
    Unit(2, 'SET'),
  ];

  //itemColor
  String? itemcolordropdown;
  List itemcolor = []; //edited line
  Future<String> getItemColorData() async {
    http.Response response =
        await http.get(Uri.parse(view_itemcolor)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        itemcolor = data["data"];
        print(itemcolor);
      });
      return response;
    });
    return "success";
  }

  //itemSize
  String? itemSizedropdown;
  List itemSize = []; //edited line
  Future<String> getItemsizeData() async {
    http.Response response =
        await http.get(Uri.parse(view_itemsize)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        itemSize = data["data"];
        print(itemSize);
      });
      return response;
    });
    return "success";
  }

  late SaleType saleTypedropdown = SaleType(1, "GST");
  List<SaleType> saleType = <SaleType>[
    SaleType(1, 'GST'),
    SaleType(2, 'Excempt'),
    SaleType(3, 'Import'),
    SaleType(4, 'Nil Rated'),
    SaleType(5, 'Unreg(RCM)'),
    SaleType(6, 'Zero Rated'),
  ];

  late SalesType salesTypedropdown = SalesType(1, "Direct");
  List<SalesType> salesType = <SalesType>[
    SalesType(1, 'Direct'),
  ];

  //Add SaleOrder
  Future addSaleOrder() async {
    var data = {
      'sales_type': "${salesTypedropdown.SalesType_id}",
      'mobile_no': mobileNo.text,
      'pos': posdropdownvalue,
      'customer_id': customerdropdownvalue,
      'sale_type': "${saleTypedropdown.SaleType_id}",
      'bill_no': bill_no.text,
      'bill_date': _selectedDate == null ? "${DateTime.now()}" : _selectedDate,
      'barcode': barcode.text,
      'item_id': itemdropdownvalue,
      'unit_id': "${unitdropdown.unit_id}",
      'item_color_id': itemcolordropdown,
      'itme_size_id': itemSizedropdown,
      'stock': stock.text,
      'qty': qty.text,
      'price': price.text,
      'delivery_date':
          _DeliveryDate == null ? "${DateTime.now()}" : _DeliveryDate
    };
    print(data);
    var response = await http.post(Uri.parse(create_sales_order), body: data);
    var dataresponse = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  claerData() {
    mobileNo.clear();
    posdropdownvalue == null;
    customerdropdownvalue == null;
    saleTypedropdown = saleType[0];
    datePicked = DateTime.now();
    DeliverydatePicked = DateTime.now();
    barcode.clear();
    itemdropdownvalue == null;
    unitdropdown = unit[0];
    itemcolordropdown == null;
    itemSizedropdown == null;
    stock.clear();
    qty.clear();
    price.clear();
  }

  var itemCentre = [
    'Main',
  ];

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
    DeliverydatePicked = DateTime.now();
    getcustomerData();
    getStateData();
    getItemsizeData();
    getItemColorData();
    getitemData();
    getItemIdData();
    unitdropdown = unit[0];
    saleTypedropdown = saleType[0];
    salesTypedropdown = salesType[0];
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
        body: RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              getcustomerData();
              getItemIdData();
              getitemData();
              getCustomerDataById();
              ApiServices().ViewcreatePurchase();
              setState(() {});
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ListView(children: [
                  SizedBox(
                    height: height * .02,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "Credit Limit: ",
                      style: subheadline3,
                    ),
                    credit_limits != null
                        ? Text(
                            credit_limits,
                            style: subheadline3,
                          )
                        : Text(
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
                                  child: DropdownButton<SalesType>(
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text(
                                      "Select Sale Type",
                                      style: subheadline,
                                    ),
                                    value: salesTypedropdown,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: salesType.map((SalesType salesType) {
                                      return DropdownMenuItem<SalesType>(
                                        value: salesType,
                                        child: Text(
                                            "${salesType.SalesType_name}"
                                                .toString()),
                                      );
                                    }).toList(),
                                    onChanged: (SalesType? newValue) {
                                      setState(() {
                                        salesTypedropdown = newValue!;
                                        print(salesTypedropdown.SalesType_id);
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
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
                                      controller: mobileNo,
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
                                  "POS",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
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
                                        value: posdropdownvalue,
                                        hint: Text(
                                          "Select State",
                                          style: subheadline,
                                        ),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: statedata.map((items) {
                                          return DropdownMenuItem(
                                            value: items['id'].toString(),
                                            child:
                                                Text(items['name'].toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            posdropdownvalue = newValue!;
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
                                                  color: lightblackcolor,
                                                  width: 1)),
                                        ),
                                        child: DropdownButton(
                                            isExpanded: true,
                                            underline: Container(),
                                            value: customerdropdownvalue,
                                            hint: Text(
                                              "Select Customer",
                                              style: subheadline,
                                            ),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: customerData.map((items) {
                                              return DropdownMenuItem(
                                                value: items['id'].toString(),
                                                child: Text(
                                                    items['customer_name']
                                                        .toString()),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                customerdropdownvalue =
                                                    newValue!;
                                                getCustomerDataById();
                                                print(customerdropdownvalue);
                                              });
                                            })),
                                    Container(
                                        width: width * .08,
                                        height: height * .04,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.lightBlueAccent),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.to(CustomerForm(),
                                                transition:
                                                    Transition.rightToLeft);
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
                                  child: DropdownButton<SaleType>(
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text(
                                      "Select Sale Type",
                                      style: subheadline,
                                    ),
                                    value: saleTypedropdown,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: saleType.map((SaleType saleType) {
                                      return DropdownMenuItem<SaleType>(
                                        value: saleType,
                                        child: Text("${saleType.SaleType_name}"
                                            .toString()),
                                      );
                                    }).toList(),
                                    onChanged: (SaleType? newValue) {
                                      setState(() {
                                        saleTypedropdown = newValue!;
                                        print(saleTypedropdown.SaleType_id);
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
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextFormField(
                                      controller: bill_no,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          datePicked == null
                                              ? Text("${DateTime.now()}")
                                              : Text(
                                                  "${datePicked?.year}"
                                                  "/"
                                                  "${datePicked?.month}"
                                                  "/"
                                                  "${datePicked?.day}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          DeliverydatePicked == null
                                              ? Text(
                                                  "${DateTime.now()}",
                                                )
                                              : Text(
                                                  "${DeliverydatePicked?.year}"
                                                  "/"
                                                  "${DeliverydatePicked?.month}"
                                                  "/"
                                                  "${DeliverydatePicked?.day}",
                                                ),
                                          IconButton(
                                              onPressed: () {
                                                _DeliveryshowPicker();
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
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
                                      controller: barcode,
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
                                                  color: lightblackcolor,
                                                  width: 1)),
                                        ),
                                        child: DropdownButton(
                                            isExpanded: true,
                                            underline: Container(),
                                            value: itemdropdownvalue,
                                            hint: Text(
                                              "Select Item",
                                              style: subheadline,
                                            ),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: itemData.map((items) {
                                              return DropdownMenuItem(
                                                value: items['id'].toString(),
                                                child: Text(items['item_name']
                                                    .toString()),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                itemdropdownvalue = newValue!;
                                                print(itemdropdownvalue);
                                                getItemIdData();
                                              });
                                            })),
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
                                  child: DropdownButton<Unit>(
                                    isExpanded: true,
                                    underline: Container(),
                                    hint: Text(
                                      "Select Unit",
                                      style: subheadline,
                                    ),
                                    value: unitdropdown,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: unit.map((Unit unit) {
                                      return DropdownMenuItem<Unit>(
                                        value: unit,
                                        child: Text(
                                            "${unit.unit_name}".toString()),
                                      );
                                    }).toList(),
                                    onChanged: (Unit? newValue) {
                                      setState(() {
                                        unitdropdown = newValue!;
                                        print(unitdropdown.unit_id);
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
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: DropdownButton(
                                        isExpanded: true,
                                        underline: Container(),
                                        value: itemcolordropdown,
                                        hint: Text(
                                          "Select Item Color",
                                          style: loginhinttext,
                                        ),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: itemcolor.map((items) {
                                          return DropdownMenuItem(
                                            value: items['id'].toString(),
                                            child: Text(
                                                items['color_name'].toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            itemcolordropdown = newValue!;
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
                                  "Item Size",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
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
                                        value: itemSizedropdown,
                                        hint: Text(
                                          "Select Item Size",
                                          style: loginhinttext,
                                        ),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: itemSize.map((items) {
                                          return DropdownMenuItem(
                                            value: items['id'].toString(),
                                            child: Text(
                                                items['size_name'].toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            itemSizedropdown = newValue!;
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
                                  "Stock",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
                                      controller: stock,
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
                                  "Qty",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
                                      controller: qty,
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
                                  "Price",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: TextField(
                                      controller: price,
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
                              height: height * .02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: width * .20,
                                    child: CupertinoButton(
                                      onPressed: () {
                                        addSaleOrder();
                                        _formKey.currentState?.reset();
                                        claerData();
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                      child: Text("Add"),
                                      color: primarycolor,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      pressedOpacity: 0.6,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            isLoading == true ? dataList(context) : Container()
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                            color:
                                                                lightblackcolor,
                                                            width: 1)),
                                                  ),
                                                  child: DropdownButton(
                                                    isExpanded: true,
                                                    underline: Container(),
                                                    value: paymentmodedropdown,
                                                    icon: const Icon(Icons
                                                        .keyboard_arrow_down),
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
                                                    onChanged:
                                                        (String? newValue) {
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
                                                            color:
                                                                lightblackcolor,
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
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 5),
                                                          border:
                                                              InputBorder.none,
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
                                                            color:
                                                                lightblackcolor,
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
                                                        textAlign:
                                                            TextAlign.center,
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
                                                ),
                                              ]),
                                            ],
                                          ),
                                          paymentmodedropdown == "Cheque"
                                              ? Column(children: [
                                                  SizedBox(
                                                      height: height * .02),
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
                                                              width:
                                                                  width * .58,
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
                                                              style:
                                                                  subheadline3,
                                                            ),
                                                            Container(
                                                                width:
                                                                    width * .58,
                                                                height: height *
                                                                    .04,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: const Border(
                                                                      bottom: BorderSide(
                                                                          color:
                                                                              lightblackcolor,
                                                                          width:
                                                                              1)),
                                                                ),
                                                                child:
                                                                    TextField(
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
                                                  : paymentmodedropdown ==
                                                          "Credit"
                                                      ? Column(children: [
                                                          SizedBox(
                                                            height:
                                                                height * .02,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("Due Date"),
                                                              Container(
                                                                  width: width *
                                                                      .30,
                                                                  height:
                                                                      height *
                                                                          .04,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                          border:
                                                                              Border(
                                                                    bottom:
                                                                        BorderSide(
                                                                      color:
                                                                          lightblackcolor,
                                                                      width:
                                                                          1.0,
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
                                                                            Icons.date_range,
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
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection: Axis.vertical,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Card(
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      shadowColor: primarycolor,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Mode :"),
                                                                  Text("NA"),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Ref.No :"),
                                                                  Text("NA"),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Bank :"),
                                                                  Text("NA"),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Amount :"),
                                                                  Text("NA"),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      "Action :"),
                                                                  Text("NA"),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: height *
                                                                    .01,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                ]))));
  }

  Widget dataList(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: FutureBuilder<ViewSalesOrderDetails>(
            future: ApiServices().ViewSalesOrder(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var data = snapshot.data?.data![index];
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
                                      Text("Item Name :"),
                                      Text("${data?.itemName}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Unit :"),
                                      Text("${data?.unit}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Item Color :"),
                                      Text("${data?.itemcolor}"),
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
                                      Text("${data?.stock}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Item Size :"),
                                      Text("${data?.itemsize}"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Qty :"),
                                      Text("${data?.qty}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Price :"),
                                      Text("${data?.price}"),
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
                                      Text("Discount(%) :"),
                                      Text("${data?.discountPurchase}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Dicount(Amount) :"),
                                      Text("${data?.discountPurchase}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Amount After Discount :"),
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
                                      Text("Amount After Discount :"),
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
                                      Text("Delivery Date :"),
                                      Text("${data?.deliveryDate}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                    });
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: primarycolor,
                ));
              }
            }));
  }

  var _selectedDate;
  DateTime? datePicked;

  Future<void> _showDObPicker() async {
    datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime(2050, 1, 1),
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
      _selectedDate = DateFormat("yyyy-MM-dd").format(datePicked!);
    });
  }

  var _DeliveryDate;
  DateTime? DeliverydatePicked;

  Future<void> _DeliveryshowPicker() async {
    DeliverydatePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime(2050, 1, 1),
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
      _DeliveryDate = DateFormat("yyyy-MM-dd").format(DeliverydatePicked!);
    });
  }
}
