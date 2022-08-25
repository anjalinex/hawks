import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/ViewPurchaseorder.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';
import '../../../Model/models.dart';
import '../../../Repository/ApiServices.dart';
import '../../../constants/style.dart';
import '../../../constants/url.dart';
import '../../item/add_item_form.dart';
import 'package:http/http.dart' as http;

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({Key? key}) : super(key: key);

  @override
  State<PurchaseOrder> createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {
  final _formKey = GlobalKey<FormState>();
  void _processData() {
    _formKey.currentState?.reset();
  }

  bool? isLoading = false;
  TextEditingController mobileNo = TextEditingController();
  TextEditingController po_no = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController total1 = TextEditingController();
  String data = "payment";
  String? supplierdropdownvalue;
  String? customerdropdownvalue;
  String? unitdropdownvalue;
  String? itemSizedropdown;
  String? itemcolordropdown;
  String paymentmodedropdown = "Cash";

  //Get Supplier Data
  List supllierData = [];
  Future<String> getsupllierData() async {
    http.Response response =
        await http.get(Uri.parse(view_supplier_details)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        supllierData = data["data"];
        print(supllierData);
      });
      return response;
    });
    return "success";
  }

  //get item Data by Id
  List ItemIdData = [];
  var a, b, total = 0;
  var skubarcode, req_qty, pricedata;
  Future<String> getItemIdData() async {
    http.Response response = await http.post(Uri.parse(view_item),
        body: {'id': itemdropdownvalue}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        ItemIdData = data["data"];
        skubarcode = ItemIdData[0]["sku"];
        itemSizedropdown = ItemIdData[0]["itme_size_id"];
        itemcolordropdown = ItemIdData[0]["item_color_id"];
        req_qty = "${1}";
        pricedata = ItemIdData[0]["sales_margin"];
        a = int.parse(req_qty!);
        b = int.parse(pricedata!);
        setState(() {
          total = (a! * b!);
        });
        barcode = TextEditingController(text: skubarcode);
        qty = TextEditingController(text: req_qty);
        price = TextEditingController(text: pricedata);
        total1 = TextEditingController(text: "${total}");
        print("ItemIdData${ItemIdData}");
      });
      return response;
    });
    return "success";
  }

  getTotalPrice() {
    setState(() {
      qty = TextEditingController(text: req_qty);
      price = TextEditingController(text: pricedata);
      total1 = TextEditingController(text: "${total}");
    });
  }

  cleardata() {
    mobileNo.clear();
    po_no.clear();
    qty.clear();
    barcode.clear();
    price.clear();
    total1.clear();
    supplierdropdownvalue = null;
    itemdropdownvalue = null;
    itemcolordropdown = null;
    itemSizedropdown = null;
    _selectedDate1 = DateTime.now();
    _selectedDate = DateTime.now();
  }

  // Get supplier data By Id
  List supllierIdData = [];
  String? mobile_no;
  Future<String> getsupllierIdData() async {
    http.Response response = await http.post(Uri.parse(view_supplier),
        body: {'id': supplierdropdownvalue}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        supllierIdData = data["data"];
        mobile_no = supllierIdData[0]["mobile_no"];
        mobileNo = TextEditingController(text: mobile_no);
        print("supllierIdData${supllierIdData}");
      });
      return response;
    });
    return "success";
  }

  //get Item Data
  String? itemdropdownvalue;
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

  Future CreatePurchaseOrder() async {
    print(data);
    var response = await http.post(Uri.parse(purchase_order), body: {
      's_id': '${supplierdropdownvalue}',
      'mobile_no': mobileNo.text,
      'po_no': po_no.text,
      'po_date': _selectedDate1,
      'expected_date': _selectedDate,
      'barcode': barcode.text,
      'item_id': '${itemdropdownvalue}',
      'select_unit': '${unitdropdown.unit_id}',
      'item_color': '${itemcolordropdown}',
      'item_size': '${itemSizedropdown}',
      'qty': qty.text,
      'price': price.text
    });
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

  var itemCentre = [
    'Main',
  ];

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
    getsupllierData();
    getitemData();
    getItemsizeData();
    getItemColorData();
    getTotalPrice();
    // ApiServices().ViewPurchaseorder();
    unitdropdown = unit[0];
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
        body: RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              getsupllierData();
              getItemIdData();
              ApiServices().ViewPurchaseorder();
              setState(() {});
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      SizedBox(
                        height: height * .02,
                      ),
                      Card(
                          elevation: 2,
                          shadowColor: primarycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side:
                                BorderSide(width: 0.4, color: lightblackcolor),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                      color: lightblackcolor,
                                                      width: 1)),
                                            ),
                                            child: DropdownButton(
                                                isExpanded: true,
                                                underline: Container(),
                                                value: supplierdropdownvalue,
                                                hint: Text(
                                                  "Select Supplier",
                                                  style: loginhinttext,
                                                ),
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items:
                                                    supllierData.map((items) {
                                                  return DropdownMenuItem(
                                                    value:
                                                        items['id'].toString(),
                                                    child: Text(
                                                        items['supplier_name']
                                                            .toString()),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    supplierdropdownvalue =
                                                        newValue!;
                                                    getsupllierIdData();
                                                    setState(() {});
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
                                                Get.to(SupplierForm(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  color: lightblackcolor,
                                                  width: 1)),
                                        ),
                                        child: TextFormField(
                                          controller: po_no,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            side:
                                BorderSide(width: 0.4, color: lightblackcolor),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                    value:
                                                        items['id'].toString(),
                                                    child: Text(
                                                        items['item_name']
                                                            .toString()),
                                                  );
                                                }).toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    itemdropdownvalue =
                                                        newValue!;
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                color: lightblackcolor,
                                                width: 1)),
                                      ),
                                      child: DropdownButton<Unit>(
                                        isExpanded: true,
                                        underline: Container(),
                                        hint: Text(
                                          "Select Unit",
                                          style: subheadline,
                                        ),
                                        value: unitdropdown,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                child: Text(items['color_name']
                                                    .toString()),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                child: Text(items['size_name']
                                                    .toString()),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          controller: total1,
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
                                            CreatePurchaseOrder();
                                            _formKey.currentState?.reset();
                                            cleardata();
                                            setState(() {
                                              isLoading = true;
                                            });
                                          },
                                          child: Text("Add"),
                                          color: primarycolor,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          pressedOpacity: 0.6,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                isLoading == true
                                    ? _viewdata(context)
                                    : Container(),
                              ]))),
                      Card(
                          elevation: 2,
                          shadowColor: primarycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side:
                                BorderSide(width: 0.4, color: lightblackcolor),
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
                              ]))),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Total",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: lightblackcolor, width: 1)),
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
                                  _processData();
                                  print("data");
                                },
                                child: Text("Save"),
                                color: primarycolor,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                pressedOpacity: 0.6,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          Container(
                              width: width * .20,
                              child: CupertinoButton(
                                onPressed: () {},
                                child: Text("Cancel"),
                                color: lightblackcolor,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                pressedOpacity: 0.6,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                    ])))));
  }

  Widget _viewdata(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: FutureBuilder<ViewPurchaseOrder>(
            future: ApiServices().ViewPurchaseorder(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount:1,
                    itemBuilder: (context, index) {
                      var data = snapshot.data?.data[index];
                      print(data?.price);
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
                                      Text("Item Size :"),
                                      Text("${data?.itemsize}"),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Quantity :"),
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
                                      Text("Unit Type :"),
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
                                      Text("Amount :"),
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

  var _selectedDate1;
  DateTime? datePicked1;

  Future<void> _showDObPicker1() async {
    datePicked1 = await showDatePicker(
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
      _selectedDate1 = DateFormat("yyyy-MM-dd").format(datePicked1!);
    });
  }

  var _selectedDate2;
  DateTime? datePicked2;

  Future<void> _showDObPicker2() async {
    datePicked2 = await showDatePicker(
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
      _selectedDate2 = DateFormat("yyyy-MM-dd").format(datePicked2!);
    });
  }
}
