import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/view_create_purchase.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/item/add_item_form.dart';
import 'package:hawks/screens/purchase/create_purchase.dart';
import 'package:hawks/screens/purchase/prchase_order/purchase_order.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';
import '../../Model/models.dart';
import '../../Repository/ApiServices.dart';
import '../../constants/style.dart';
import '../../constants/url.dart';
import '../customer/customer_form.dart';
import 'package:http/http.dart' as http;

class Purchase extends StatefulWidget {
  const Purchase({Key? key}) : super(key: key);

  @override
  State<Purchase> createState() => _PurchaseState();
}

class _PurchaseState extends State<Purchase> {
  final _formKey = GlobalKey<FormState>();
  void _processData() {
    _formKey.currentState?.reset();
  }

  bool? isLoading = false;
  TextEditingController mobileNo = TextEditingController();
  TextEditingController sup_inv_no = TextEditingController();
  TextEditingController bill_no = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController total1 = TextEditingController();
  String poselection = "Direct";
  String data = "payment";
  String? supplierdropdownvalue;
  String? posdropdownvalue;
  String? ponodropdownvalue;
  String? itemCentredropdownvalue;
  String paymentmodedropdown = "Cash";

  late PurcType purcTypedropdownvalue = PurcType(1, 'GST');
  List<PurcType> purctype = <PurcType>[
    PurcType(1, 'GST'),
    PurcType(2, 'Exempt'),
    PurcType(3, 'Import'),
    PurcType(4, 'Nill Rated'),
    PurcType(5, 'Unreg(RCM)'),
    PurcType(6, 'Zero Rated'),
  ];

  //Get PO nO. Data
  List PoNoData = [];
  Future<String> getPoNoData() async {
    http.Response response =
        await http.get(Uri.parse(view_purchase_order)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        PoNoData = data["data"];
        print(PoNoData);
      });
      return response;
    });
    return "success";
  }

  //Get PO nO. Data
  List podata = [];
  int? a, b, total = 0;
  String? req_qty, expected_date, pricedata;
  Future<String> getpoData() async {
    http.Response response = await http.post(Uri.parse(view_pur_order),
        body: {'po': ponodropdownvalue}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        podata = data["data"];
        supplierdropdownvalue = podata[0]["s_id"];
        req_qty = podata[0]["qty"];
        pricedata = podata[0]["price"];
        mobile_no = podata[0]["mobile"];
        skubarcode = podata[0]["barcode"];
        itemdropdownvalue = podata[0]["item_id"];
        posdropdownvalue = podata[0]["pos"];
        // itemcolordropdown = podata[0]["item_color_id"];
        // itemSizedropdown = podata[0]["itme_size_id"];
        a = int.parse(req_qty!);
        b = int.parse(pricedata!);
        total = (a! * b!);
        mobileNo = TextEditingController(text: mobile_no);
        barcode = TextEditingController(text: skubarcode);
        qty = TextEditingController(text: req_qty);
        total1 = TextEditingController(text: "${total}");
        price = TextEditingController(text: pricedata);
        print(podata);
      });
      return response;
    });
    return "success";
  }

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

  //get item by Id
  List ItemIdData = [];
  String? skubarcode;
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
        pricedata = ItemIdData[0]["mrp"];
        a = int.parse(req_qty!);
        b = int.parse(pricedata!);
        total = (a! * b!);
        barcode = TextEditingController(text: skubarcode);
        qty = TextEditingController(text: req_qty);
        price = TextEditingController(text: pricedata);
        // total1 = TextEditingController(text: "${total}");
        print("ItemIdData${ItemIdData}");
      });
      return response;
    });
    return "success";
  }

  // Get supplier data By Id
  List supllierIdData = [];
  String? mobile_no, state;
  Future<String> getsupllierIdData() async {
    http.Response response = await http.post(Uri.parse(view_supplier),
        body: {'id': supplierdropdownvalue}).then((response) {
      var data = json.decode(response.body);
      setState(() {
        supllierIdData = data["data"];
        mobile_no = supllierIdData[0]["mobile_no"];
        state = supllierIdData[0]["state_id"];
        posdropdownvalue = state;
        print("supllierIdData${supllierIdData}");
        mobileNo = TextEditingController(text: mobile_no);
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

  List statedata = [];
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

  Future addPurchase() async {
    print(data);
    var response = await http.post(Uri.parse(create_purchase), body: {
      's_id': '${supplierdropdownvalue}',
      'inv_no': sup_inv_no.text,
      'sup_inv_date': _selectedDate1,
      'mobile_no': mobileNo.text,
      'barcode': barcode.text,
      'pos': '${posdropdownvalue}',
      'item_center': '${itemCentredropdownvalue}',
      'bill_no': bill_no.text,
      'bill_date': _selectedDate,
      'customer_type': '${purcTypedropdownvalue.PurcType_id}',
      'item_id': '${itemdropdownvalue}',
      'select_unit': '${unitdropdown.unit_id}',
      'item_color': '${itemcolordropdown}',
      'item_size': '${itemSizedropdown}',
      'qty': qty.text,
      'price': price.text,
      'total': total1.text,
      'expire_date': _selectedDate2
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

  clearData() {
    setState(() {
      ponodropdownvalue = null;
      poselection = "Direct";
      supplierdropdownvalue = null;
      mobileNo.clear();
      sup_inv_no.clear();
      posdropdownvalue = null;
      itemCentredropdownvalue = null;
      bill_no.clear();
      purcTypedropdownvalue = purctype[0];
      barcode.clear();
      itemdropdownvalue = null;
      itemSizedropdown = null;
      itemcolordropdown = null;
      qty.clear();
      price.clear();
      total1.clear();
    });
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
    getStateData();
    getitemData();
    getItemsizeData();
    getItemColorData();
    getPoNoData();
    //ApiServices().ViewcreatePurchase();
    unitdropdown = unit[0];
    purcTypedropdownvalue = purctype[0];
    itemCentredropdownvalue = itemCentre[0];
    datePicked = DateTime.now();
    datePicked1 = DateTime.now();
    datePicked2 = DateTime.now();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    qty.dispose();
    mobileNo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Purchase"),
        ),
        body: RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              getsupllierData();
              getItemIdData();
              getPoNoData();
              ApiServices().ViewcreatePurchase();
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Select Purchase Type :",
                              style: subheadline3,
                            ),
                            Row(
                              children: [
                                Radio(
                                    value: "Direct",
                                    groupValue: poselection,
                                    onChanged: (value) {
                                      setState(() {
                                        poselection = value.toString();
                                      });
                                    }),
                                Text(
                                  "Direct",
                                  style: subheadline3,
                                ),
                              ],
                            ),
                            Row(children: [
                              Radio(
                                  value: "PO",
                                  groupValue: poselection,
                                  onChanged: (value) {
                                    setState(() {
                                      poselection = value.toString();
                                    });
                                  }),
                              Text(
                                "PO",
                                style: subheadline3,
                              ),
                            ]),
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PO No",
                            style: subheadline3,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: width * .45,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: lightblackcolor,
                                              width: 1)),
                                    ),
                                    child: poselection == "PO"
                                        ? DropdownButton(
                                            isExpanded: true,
                                            underline: Container(),
                                            value: ponodropdownvalue,
                                            hint: Text(
                                              "Select Po No",
                                              style: loginhinttext,
                                            ),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: PoNoData.map((items) {
                                              return DropdownMenuItem(
                                                value:
                                                    items['po_no'].toString(),
                                                child: Text(
                                                    items['po_no'].toString()),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                ponodropdownvalue = newValue!;
                                                print(ponodropdownvalue);
                                                getpoData();
                                              });
                                            })
                                        : DropdownButton(
                                            isExpanded: true,
                                            underline: Container(),
                                            value: ponodropdownvalue,
                                            hint: Text(
                                              "Select Po No",
                                              style: loginhinttext,
                                            ),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: PoNoData.map((items) {
                                              return DropdownMenuItem(
                                                value: items['po_no'],
                                                child: Text(
                                                    items['po_no'].toString()),
                                              );
                                            }).toList(),
                                            onChanged: null)),
                                Container(
                                    width: width * .08,
                                    height: height * .04,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.lightBlueAccent),
                                    child: IconButton(
                                      onPressed: () {
                                        Get.to(PurchaseOrder(),
                                            transition: Transition.rightToLeft);
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      iconSize: 20,
                                    ))
                              ])
                        ],
                      ),
                      SizedBox(
                        height: height * .01,
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
                                            width: width * .42,
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
                                                    print(
                                                        supplierdropdownvalue);
                                                    getsupllierIdData();
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
                                        width: width * .50,
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
                                      "Sup.Inv.No.",
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
                                          controller: sup_inv_no,
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
                                        "Sup.Inv.Date",
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
                                                "${datePicked1?.year}"
                                                "/"
                                                "${datePicked1?.month}"
                                                "/"
                                                "${datePicked1?.day}",
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
                                      "POS",
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
                                            value: posdropdownvalue,
                                            hint: Text(
                                              "Select State",
                                              style: loginhinttext,
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
                                      "Item Centre",
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
                                        hint: Text(
                                          "Select Centre",
                                          style: subheadline,
                                        ),
                                        value: itemCentredropdownvalue,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: itemCentre.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Bill No",
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
                                      "Purc Type",
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
                                      child: DropdownButton<PurcType>(
                                        isExpanded: true,
                                        underline: Container(),
                                        hint: Text(
                                          "Select Purc Type",
                                          style: subheadline,
                                        ),
                                        value: purcTypedropdownvalue,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items:
                                            purctype.map((PurcType purctype) {
                                          return DropdownMenuItem<PurcType>(
                                            value: purctype,
                                            child: Text(
                                                "${purctype.PurcType_name}"
                                                    .toString()),
                                          );
                                        }).toList(),
                                        onChanged: (PurcType? newValue) {
                                          setState(() {
                                            purcTypedropdownvalue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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
                                      "Item Details",
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
                                            width: width * .42,
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
                                      width: width * .50,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Price",
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
                                        child:
                                            // Text("${pricedata}")
                                            TextField(
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
                                        width: width * .50,
                                        height: height * .04,
                                        decoration: BoxDecoration(
                                          border: const Border(
                                              bottom: BorderSide(
                                                  color: lightblackcolor,
                                                  width: 1)),
                                        ),
                                        child:
                                            //Text("${total1}")
                                            TextField(
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
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Expire Date",
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
                                              "${datePicked2?.year}"
                                              "/"
                                              "${datePicked2?.month}"
                                              "/"
                                              "${datePicked2?.day}",
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _showDObPicker2();
                                                },
                                                icon: Icon(Icons.date_range))
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: width * .20,
                                        child: CupertinoButton(
                                          onPressed: () {
                                            addPurchase();
                                            _formKey.currentState?.reset();
                                            clearData();
                                            isLoading = true;
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
                                isLoading == true
                                    ? _viewData(context)
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CupertinoButton(
                                        // style: ElevatedButton.styleFrom(
                                        //   primary: bordercolor,
                                        // ),
                                        color: bordercolor,
                                        padding: EdgeInsets.all(2),
                                        onPressed: () {
                                          setState(() {
                                            data = "payment";
                                          });
                                        },
                                        child: Text(
                                          "Payment Mode",
                                          style: subheadline5,
                                        )),
                                    CupertinoButton(
                                        // style: ElevatedButton.styleFrom(
                                        //   primary: bordercolor,
                                        // ),
                                        color: bordercolor,
                                        padding: EdgeInsets.all(2),
                                        onPressed: () {
                                          setState(() {
                                            data = 'remarks';
                                          });
                                        },
                                        child: Text("Remarks")),
                                    CupertinoButton(
                                        color: bordercolor,
                                        padding: EdgeInsets.all(2),
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
                                        height: height * .50,
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
                                                              Text(
                                                                  "Supp. Name :"),
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
                                                              Text("Item :"),
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
                                                              Text("MRP :"),
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
                                                              Text(
                                                                  "Discount :"),
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
                                                              Text("Date :"),
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
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(left: 10),
                                                  border: InputBorder.none),
                                            ))
                                        : Column(
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(children: [
                                                      Text("Payment Mode"),
                                                      Container(
                                                        width: width * .20,
                                                        height: height * .04,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color:
                                                                      lightblackcolor,
                                                                  width: 1)),
                                                        ),
                                                        child: DropdownButton(
                                                          isExpanded: true,
                                                          underline:
                                                              Container(),
                                                          value:
                                                              paymentmodedropdown,
                                                          icon: const Icon(Icons
                                                              .keyboard_arrow_down),
                                                          items: paymentmode
                                                              .map((String
                                                                  items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child: Text(
                                                                items,
                                                                style:
                                                                    subheadline3,
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (String?
                                                              newValue) {
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
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                              bottom: BorderSide(
                                                                  color:
                                                                      lightblackcolor,
                                                                  width: 1)),
                                                        ),
                                                        child: Container(
                                                            width: width * .20,
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
                                                      ),
                                                    ]),
                                                    Column(
                                                      children: [
                                                        Text("Reference Date"),
                                                        Container(
                                                            width: width * .30,
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
                                                                      .start,
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
                                                                    icon: Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      size: 20,
                                                                    ))
                                                              ],
                                                            )),
                                                      ],
                                                    )
                                                  ]),
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
                                                      SizedBox(
                                                          height: height * .01),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Amount:",
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
                                                    ])
                                                  : paymentmodedropdown ==
                                                          "Card"
                                                      ? Column(children: [
                                                          SizedBox(
                                                              height:
                                                                  height * .02),
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
                                                                style:
                                                                    subheadline3,
                                                              ),
                                                              Container(
                                                                  width: width *
                                                                      .58,
                                                                  height:
                                                                      height *
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
                                                                              bottom: 5),
                                                                      border: InputBorder
                                                                          .none,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  height * .01),
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
                                                                        width *
                                                                            .58,
                                                                    height:
                                                                        height *
                                                                            .04,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: const Border(
                                                                          bottom: BorderSide(
                                                                              color: lightblackcolor,
                                                                              width: 1)),
                                                                    ),
                                                                    child:
                                                                        TextField(
                                                                      cursorColor:
                                                                          lightblackcolor,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding:
                                                                            EdgeInsets.only(bottom: 5),
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                    )),
                                                              ]),
                                                          SizedBox(
                                                              height:
                                                                  height * .01),
                                                          Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "Amount:",
                                                                  style:
                                                                      subheadline3,
                                                                ),
                                                                Container(
                                                                    width:
                                                                        width *
                                                                            .58,
                                                                    height:
                                                                        height *
                                                                            .04,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: const Border(
                                                                          bottom: BorderSide(
                                                                              color: lightblackcolor,
                                                                              width: 1)),
                                                                    ),
                                                                    child:
                                                                        TextField(
                                                                      cursorColor:
                                                                          lightblackcolor,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding:
                                                                            EdgeInsets.only(bottom: 5),
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                    )),
                                                              ])
                                                        ])
                                                      : Container(),
                                            ],
                                          )
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
                                          "Currency\nReceived",
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
                                            child: Text("${total}")
                                            // TextField(
                                            //   cursorColor: lightblackcolor,
                                            //   decoration: InputDecoration(
                                            //     contentPadding:
                                            //         EdgeInsets.only(bottom: 5),
                                            //     border: InputBorder.none,
                                            //   ),
                                            // )
                                            ),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              )),
                          Container(
                              width: width * .30,
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

  Widget _viewData(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: FutureBuilder<ViewCreatePurchase>(
            future: ApiServices().ViewcreatePurchase(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      var data = snapshot.data?.data[index];
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
                                      Text("Ret Qty :"),
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
                                      Text("Total :"),
                                      Text("${data?.total}"),
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
