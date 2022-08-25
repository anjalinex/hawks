import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/sales_return.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Model/models.dart';
import '../../../Model/view_create_purchase.dart';
import '../../../Repository/ApiServices.dart';
import '../../../constants/style.dart';
import '../../../constants/url.dart';

class PurchaseReturn extends StatefulWidget {
  const PurchaseReturn({Key? key}) : super(key: key);

  @override
  State<PurchaseReturn> createState() => _PurchaseReturnState();
}

class _PurchaseReturnState extends State<PurchaseReturn> {
  TextEditingController Address = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController BillNo = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController base_price = TextEditingController();
  TextEditingController dis_amt = TextEditingController();
  TextEditingController Total = TextEditingController();

  String? supplierdropdownvalue;
  String? saletypedropdownvalue;
  String? posDropdown;
  String? itemCenterDropdown;
  String? cusTypedropdown;
  String? itemdropdownvalue;
  String? unitdropdownvalue;
  String? itemsizedropdownvalue;
  String? itemcolordropdownvalue;
  String bill_no = "";

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

  // // Get supplier data By Id
  // List supllierIdData = [];
  // var address;
  // Future<String> getsupllierIdData() async {
  //   http.Response response = await http.post(Uri.parse(view_supplier),
  //       body: {'id': supplierdropdownvalue}).then((response) {
  //     var data = json.decode(response.body);
  //     setState(() {
  //       supllierIdData = data["data"];
  //       // address = supllierIdData[0]["address"];
  //       // posdropdownvalue = supllierIdData[0]["state_id"];
  //       // Address = TextEditingController(text: address);
  //       print("supllierIdData${supllierIdData}");
  //     });
  //     return response;
  //   });
  //   return "success";
  // }

  String? posdropdownvalue;
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

  List billdataBySId = [];
  Future<String> getbilldataBySIdData() async {
    http.Response response = await http.post(Uri.parse(view_supplier_id),
        body: {'s_id': supplierdropdownvalue}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        billdataBySId = data["data"];
        // skubarcode = ItemIdData[0]["sku"];
        // itemsizedropdownvalue = ItemIdData[0]["itme_size_id"];
        // itemcolordropdownvalue = ItemIdData[0]["item_color_id"];
        // barcode = TextEditingController(text: skubarcode);
        print("ItemIdData${billdataBySId}");
      });
      return response;
    });
    return "success";
  }

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

  List billdata = [];
  var Addressdata,
      mobile_no,
      skubarcode,
      billNoData,
      req_qty,
      baseprice,
      totalprice;
  Future<String> getbilldata() async {
    final prefs = await SharedPreferences.getInstance();
    var billNo = prefs.getString("bill_no");
    http.Response response = await http.post(Uri.parse(view_bill_no),
        body: {'bill_no': billNo}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        billdata = data["data"];
        bill_no = billdata[0]["bill_no"];
        supplierdropdownvalue = billdata[0]["s_id"];
        posdropdownvalue = billdata[0]["pos"];
        Addressdata = billdata[0]["address"];
        mobile_no = billdata[0]["mobile"];
        skubarcode = billdata[0]["barcode"];
        _selectedDate = billdata[0]["bill_date"];
        itemdropdownvalue = billdata[0]["item_id"];
        unitdropdown.unit_name = billdata[0]["unit"];
        itemsizedropdownvalue = billdata[0]["itme_size_id"];
        itemcolordropdownvalue = billdata[0]["item_color_id"];
        req_qty = billdata[0]["qty"];
        baseprice = billdata[0]["price"];
        totalprice = billdata[0]["total"];
        Address = TextEditingController(text: Addressdata);
        mobileNo = TextEditingController(text: mobile_no);
        barcode = TextEditingController(text: skubarcode);
        qty = TextEditingController(text: req_qty);
        base_price = TextEditingController(text: baseprice);
        Total = TextEditingController(text: totalprice);
        print("BillData${billdata}");
      });
      return response;
    });
    return "success";
  }

  late GstType GstTypedropdown = GstType(1, 'GST');
  List<GstType> gstType = <GstType>[
    GstType(1, 'GST'),
    GstType(2, 'Non GST'),
    GstType(3, 'Excempt'),
    GstType(4, 'Nil Rated'),
    GstType(4, 'Zero Rated'),
  ];

  cleardata() {
    Address.clear();
    mobileNo.clear();
    posdropdownvalue = null;
    supplierdropdownvalue = null;
    GstTypedropdown = gstType[0];
    BillNo.clear();
    _selectedDate = DateTime.now();
    barcode.clear();
    itemdropdownvalue = null;
    unitdropdown = unit[0];
    itemcolordropdownvalue = null;
    itemsizedropdownvalue = null;
    qty.clear();
    base_price.clear();
    Total.clear();
  }

  Future addPurchaseReturn() async {
    var response = await http.post(Uri.parse(create_purchase_return), body: {
      's_id': "${supplierdropdownvalue}",
      'barcode': barcode.text,
      'address': Address.text,
      'mobile_no': mobileNo.text,
      'pos': "${posdropdownvalue}",
      'gst_type': "${GstTypedropdown.GstType_id}",
      'item_center': "${itemCenterDropdown}",
      'return_bill_no': BillNo.text,
      'purchase_bill_no': bill_no.toString(),
      'bill_date': _selectedDate,
      'item_id': itemdropdownvalue,
      'unit_id': "${unitdropdown.unit_id}",
      'item_color_id': itemcolordropdownvalue,
      'itme_size_id': itemsizedropdownvalue,
      'qty': qty.text,
      'base_price': base_price.text,
      'discount_amount': '10',
      'total': Total.text
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

  var itemCenter = [
    'Main',
  ];

  late Unit unitdropdown = Unit(1, "PCS");
  List<Unit> unit = <Unit>[
    Unit(1, 'PCS'),
    Unit(2, 'SET'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datePicked = DateTime.now();
    itemCenterDropdown = itemCenter[0];
    GstTypedropdown = gstType[0];
    unitdropdown = unit[0];
    getsupllierData();
    getStateData();
    getitemData();
    getItemsizeData();
    getItemColorData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Purchase Return"),
        ),
        body: RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              getsupllierData();
              setState(() {});
            },
            child: Padding(
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
                                  "Supllier",
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
                                        value: supplierdropdownvalue,
                                        hint: Text(
                                          "Select Supplier",
                                          style: subheadline,
                                        ),
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: supllierData.map((items) {
                                          return DropdownMenuItem(
                                            value: items['id'].toString(),
                                            child: Text(items['supplier_name']
                                                .toString()),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            supplierdropdownvalue = newValue!;
                                            print(supplierdropdownvalue);
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
                                  "Address :",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: Address,
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
                                    width: width * .50,
                                    height: height * .04,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: TextField(
                                      controller: mobileNo,
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "POS",
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
                                          value: posdropdownvalue,
                                          hint: Text(
                                            "Select POS",
                                            style: subheadline,
                                          ),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: statedata.map((items) {
                                            return DropdownMenuItem(
                                              value: items['id'].toString(),
                                              child: Text(
                                                  items['name'].toString()),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              posdropdownvalue = newValue!;
                                            });
                                          })),
                                ]),
                            SizedBox(
                              height: height * .01,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "GST Type",
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
                                    child: DropdownButton<GstType>(
                                      isExpanded: true,
                                      underline: Container(),
                                      value: GstTypedropdown,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: gstType.map((GstType? gstType) {
                                        return DropdownMenuItem<GstType>(
                                          value: gstType,
                                          child: Text(
                                            "${gstType?.GstType_name}",
                                            style: subheadline3,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (GstType? newValue) {
                                        setState(() {
                                          GstTypedropdown = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: height * .01,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Item Centre",
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
                                        "Select Item Centre",
                                        style: subheadline,
                                      ),
                                      value: itemCenterDropdown,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
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
                                    width: width * .50,
                                    height: height * .04,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: TextField(
                                      controller: BillNo,
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
                                        hintText: "Bill No.",
                                        hintStyle: subheadline,
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
                                  "Select Bill No.",
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
                                    child: Text(
                                      bill_no,
                                      textAlign: TextAlign.start,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: width * .30,
                          child: CupertinoButton(
                            child: Text("Show Bill"),
                            color: primarycolor,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            pressedOpacity: 0.6,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            onPressed: () async {
                              await _showBill(context);
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
                            SizedBox(
                              height: height * .02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SKU/Barcode",
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
                                  width: width * .50,
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
                                        value: itemcolordropdownvalue,
                                        hint: Text(
                                          "Select Item Color",
                                          style: subheadline,
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
                                            itemcolordropdownvalue = newValue!;
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
                                        value: itemsizedropdownvalue,
                                        hint: Text(
                                          "Select Item Size",
                                          style: subheadline,
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
                                            itemsizedropdownvalue = newValue!;
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
                                  "Qty",
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
                                  "Base Price",
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
                                      controller: base_price,
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
                                  "Dis. Amt",
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
                                      controller: Total,
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
                                      onPressed: () async {
                                        await addPurchaseReturn();
                                        cleardata();
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
                                  "Total Exclude Tax",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total GST",
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Grand Total",
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
                          width: width * .30,
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
                          width: width * .30,
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

  Future<void> _showBill(BuildContext context) async {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              title: Text(
                "Bill No.",
                textAlign: TextAlign.center,
              ),
              content: Container(
                  width: width * .60,
                  child: FutureBuilder<ViewCreatePurchase>(
                      future: ApiServices().ViewcreatePurchase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data?.data.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data?.data[index];
                                return InkWell(
                                    onTap: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      var billNo = prefs.setString(
                                          "bill_no", "${data?.billNo}");
                                      Get.back();
                                      getbilldata();
                                    },
                                    child: Card(
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Supplier Name :"),
                                                    Text(
                                                        "${data?.suppliername}"),
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
                                                    Text("Bill No. :"),
                                                    Text("${data?.billNo}"),
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
                                                    Text("Bill Date :"),
                                                    Text("${data?.billDate}"),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: height * .01,
                                                ),
                                              ]),
                                        )));
                              });
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: primarycolor,
                          ));
                        }
                      })),
              // actions: <Widget>[
              //   // usually buttons at the bottom of the dialog
              //   new FlatButton(
              //     child: new Text("Save"),
              //     onPressed: () {
              //       setState(() {});
              //       Get.back();
              //     },
              //   ),
              //   FlatButton(
              //     child: new Text("Cancel"),
              //     onPressed: () {
              //       Get.back();
              //     },
              //   ),
              // ],
            );
          },
        );
      },
    );
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
                            Text("SKU/Barcode :"),
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
                            Text("Purchase(Qty) :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Return(Qty) :"),
                            Text("NA"),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Base Price :"),
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
                            Text("Discount(Amount) :"),
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
        lastDate: DateTime(2025, 1, 1),
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
