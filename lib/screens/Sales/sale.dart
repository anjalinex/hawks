import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/viewCustomerDetails.dart';
import 'package:hawks/constants/color.dart';
import 'package:intl/intl.dart';
import '../../Model/models.dart';
import '../../constants/style.dart';
import '../../constants/url.dart';
import '../customer/customer_form.dart';
import '../item/add_item_form.dart';
import 'package:http/http.dart' as http;

class Sale extends StatefulWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  TextEditingController mobileNo = TextEditingController();
  TextEditingController bill_no = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController cut_stock = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController Tras_Veh_No = TextEditingController();
  String data = "payment";
  String? customerdropdownvalue;
  String? itemdropdownvalue;
  String? unitdropdownvalue;
  String? posdropdownvalue;
  String? itemCentredropdownvalue;
  String? salesTypedropdownvalue;
  String? salesOrderdropdownvalue;
  String? custTypedropdownvalue;
  String paymentmodedropdown = "Cash";

  List<ViewCustomerDetails> CustomerDetails = [];

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
        cut_stock = TextEditingController(text: Stock);
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
  var mobile_no, credit_limits, Address;
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
        Address = CustomerDataById[0]["address"];
        mobileNo = TextEditingController(text: mobile_no);
        address = TextEditingController(text: Address);
        print(CustomerDataById);
      });
      return response;
    });
    return "success";
  }

  var pos = [
    'Uttar Pradesh',
    'Haryana',
  ];

  var salesType = ['Direct', 'Sale Order', 'Challan'];

  var saleOrder = [
    'Choose One',
  ];

  var itemCentre = [
    'Main',
  ];

  var custType = ['Retail'];

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
    getcustomerData();
    datePicked = DateTime.now();
    getcustomerData();
    getStateData();
    getItemsizeData();
    getItemColorData();
    getitemData();
    getItemIdData();
    unitdropdown = unit[0];
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Sale"),
        ),
        body: RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              getcustomerData();
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
                      "Credit Limit  ",
                      style: subheadline3,
                    ),
                    credit_limits == null
                        ? Text(
                            "0.00",
                            style: subheadline3,
                          )
                        : Text(
                            credit_limits,
                            style: subheadline3,
                          ),
                    SizedBox(
                      width: width * .04,
                    ),
                    Text(
                      "Dues  ",
                      style: subheadline3,
                    ),
                    Text(
                      "0.00",
                      style: subheadline3,
                    ),
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
                                  "Select Sales\nType",
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
                            SizedBox(
                              height: height * .01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sales Order",
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
                                      "Select Order",
                                      style: subheadline,
                                    ),
                                    value: salesOrderdropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: saleOrder.map((String items) {
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
                                        salesOrderdropdownvalue = newValue!;
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
                                  "Item Centre",
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
                                      "Select Centre",
                                      style: subheadline,
                                    ),
                                    value: itemCentredropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: itemCentre.map((String items) {
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
                                        itemCentredropdownvalue = newValue!;
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
                                  "Tras.Veh.No",
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
                                      controller: Tras_Veh_No,
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
                                  "Cust.Type",
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
                                      "Select Cust Type",
                                      style: subheadline,
                                    ),
                                    value: custTypedropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: custType.map((String items) {
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
                                        custTypedropdownvalue = newValue!;
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
                                    height: height * .10,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: address,
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
                                    Container(
                                        width: width * .08,
                                        height: height * .04,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.lightBlueAccent),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.to(AddItem(),
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
                                  "Cur.Stock",
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
                                      controller: cut_stock,
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
                                      onPressed: () {},
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
                            Container(
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("SN :"),
                                                    Text("${index + 1}")
                                                  ],
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
                                                    Text("Unit :"),
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
                                                    Text("Item Code :"),
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
                                                    Text("Ret Qty :"),
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
                                                    Text("Total :"),
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
                                                            color: Color(
                                                                0xffAB2328)))
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
                                    height: height * .30,
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
                                                      ? Column(
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  height * .02,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Due Date:",
                                                                  style:
                                                                      subheadline3,
                                                                ),
                                                                Container(
                                                                    width:
                                                                        width *
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
                                                                              size: 20,
                                                                            ))
                                                                      ],
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        )
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
                                      "Received",
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
                                      "Return",
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
                                        width: width * .58,
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
