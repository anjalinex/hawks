import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/screens/item/item_color_details.dart';
import 'package:hawks/screens/item/item_size_details.dart';
import '../../Model/category_model.dart';
import '../../Model/models.dart';
import '../../constants/color.dart';
import '../../constants/style.dart';
import '../../constants/url.dart';
import '../supplier/supplier_form.dart';
import 'package:http/http.dart' as http;

class EditItem extends StatefulWidget {
  String itemName, Itemsize, Itemcolor, Unit, Sku, purchaseprice;
  EditItem(this.itemName, this.Sku, this.Itemsize, this.Itemcolor, this.Unit,
      this.purchaseprice,
      {Key? key})
      : super(key: key);

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController item_name = TextEditingController();
  TextEditingController sku = TextEditingController();
  TextEditingController hsn = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController minimum_stock = TextEditingController();
  TextEditingController opening_stock = TextEditingController();
  TextEditingController opening_amount = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController in_stock = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController Discount = TextEditingController();
  TextEditingController purchase_price = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController sales_price_withtax = TextEditingController();
  TextEditingController sales_margin_criteria = TextEditingController();
  TextEditingController sales_margin = TextEditingController();
  TextEditingController sales_price_withouttax = TextEditingController();
  TextEditingController min_sale_price = TextEditingController();
  TextEditingController best_price = TextEditingController();
  TextEditingController discount_purchase = TextEditingController();

  String? sale = "Sale on MRP";
  String? discount = "Amount";
  bool value = false;
  String? itemsizedropdown;

  late TaxCategory taxdropdown = TaxCategory(1, 'Exempt');
  List<TaxCategory> taxCategory = <TaxCategory>[
    TaxCategory(1, 'Exempt'),
    TaxCategory(2, 'GST'),
    TaxCategory(3, 'Nill Rated'),
    TaxCategory(4, 'Non GST'),
  ];

  late GST gstdropdown = GST(1, "5%");
  List<GST> gst = <GST>[
    GST(1, '5%'),
    GST(2, '12%'),
    GST(3, '14%'),
    GST(4, '18%'),
  ];
  late GST1 gstdropdown1 = GST1(1, "0%");
  List<GST1> gst1 = <GST1>[
    GST1(1, '0%'),
  ];

  late Unit unitdropdown = Unit(1, "PCS");
  List<Unit> unit = <Unit>[
    Unit(1, 'PCS'),
    Unit(2, 'SET'),
  ];

  //Category
  String? categoryDropdownValue;
  List categorydata = []; //edited line
  Future<String> getCategoryData() async {
    http.Response response =
        await http.get(Uri.parse(view_category)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        categorydata = data["data"];
        print(categorydata);
      });
      return response;
    });
    return "success";
  }

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

  //AddItem
  Future CreateItem() async {
    var request = http.MultipartRequest('POST', Uri.parse(createitems_details));
    request.fields.addAll({
      'category_id': "${categoryDropdownValue}",
      'item_name': item_name.text,
      'sku': sku.text,
      'hsn': hsn.text,
      'barcode': barcode.text,
      'unit_id': "${unitdropdown.unit_name}",
      'itme_size_id': "${itemsizedropdown}",
      'item_color_id': "${itemcolordropdown}",
      'tax_category': "${taxdropdown.taxcategory_name}",
      'gst': "${gstdropdown.GST_name}",
      'minimum_stock': minimum_stock.text,
      'opening_stock': opening_stock.text,
      'opening_amount': opening_amount.text,
      'in_stock': in_stock.text,
      'description': description.text,
      'sales': "${sale}",
      'mrp': mrp.text,
      'discount': Discount.text,
      'amount': amount.text,
      'sales_price_withtax': sales_price_withtax.text,
      'sales_margin_criteria': sales_margin_criteria.text,
      'sales_margin': sales_margin.text,
      'sales_price_withouttax': sales_price_withouttax.text,
      'min_sale_price': min_sale_price.text,
      'best_price': best_price.text,
      'discount_purchase': discount_purchase.text,
      'purchase_price': purchase_price.text
    });
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);

    if (response.statusCode == 200) {
      print(respStr);
      var encoded = json.decode(respStr);
      print(encoded["data"]);
      Fluttertoast.showToast(
          msg: "Your Data has been added successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gstdropdown = gst[0];
    gstdropdown1 = gst1[0];
    taxdropdown = taxCategory[0];
    unitdropdown = unit[0];
    getCategoryData();
    getItemColorData();
    getItemsizeData();
  }

  @override
  Widget build(BuildContext context) {
    item_name = TextEditingController(text: widget.itemName);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text("Add Item"),
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
                    "Category",
                    style: subheadline3,
                  ),
                  Row(
                    children: [
                      Container(
                          width: width * .50,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: lightblackcolor,
                              width: 1.0,
                            ),
                          )),
                          child: DropdownButton(
                              isExpanded: true,
                              underline: Container(),
                              value: categoryDropdownValue,
                              hint: Text(
                                "Select Category",
                                style: loginhinttext,
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: categorydata.map((items) {
                                return DropdownMenuItem(
                                  value: items['id'].toString(),
                                  child: Text(items['category'].toString()),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  categoryDropdownValue = newValue!;
                                  getCategoryData();
                                });
                              })),
                      Container(
                          width: width * .08,
                          height: height * .04,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.lightBlueAccent),
                          child: IconButton(
                            onPressed: () async {
                              await _showDecline(context);
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            iconSize: 20,
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Item Name",
                  style: subheadline3,
                ),
                Container(
                    width: width * .58,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      controller: item_name,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "SKU",
                  style: subheadline3,
                ),
                Container(
                    width: width * .58,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      controller: sku,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "HSN",
                  style: subheadline3,
                ),
                Container(
                    width: width * .58,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      controller: hsn,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ))
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Barcode",
                  style: subheadline3,
                ),
                Container(
                    width: width * .58,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      controller: barcode,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ))
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Unit",
                    style: subheadline3,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * .50,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
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
                              child: Text("${unit.unit_name}".toString()),
                            );
                          }).toList(),
                          onChanged: (Unit? newValue) {
                            setState(() {
                              unitdropdown = newValue!;
                            });
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: primarycolor,
                          ))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Item Size",
                  style: subheadline3,
                ),
                Row(
                  children: [
                    Container(
                        width: width * .50,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            value: itemsizedropdown,
                            hint: Text(
                              "Select Size",
                              style: loginhinttext,
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: itemSize.map((items) {
                              return DropdownMenuItem(
                                value: items['id'].toString(),
                                child: Text(items['size_name'].toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                itemsizedropdown = newValue!;
                                getCategoryData();
                              });
                            })),
                    IconButton(
                        onPressed: () {
                          Get.to(ItemSize(),
                              transition: Transition.noTransition);
                        },
                        icon: Icon(
                          Icons.add,
                          color: primarycolor,
                        ))
                  ],
                ),
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Item Color",
                  style: subheadline3,
                ),
                Row(
                  children: [
                    Container(
                        width: width * .50,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            value: itemcolordropdown,
                            hint: Text(
                              "Select State",
                              style: loginhinttext,
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: itemcolor.map((items) {
                              return DropdownMenuItem(
                                value: items['id'].toString(),
                                child: Text(items['color_name'].toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                itemcolordropdown = newValue!;
                                getCategoryData();
                              });
                            })),
                    IconButton(
                        onPressed: () {
                          Get.to(ItemColor(),
                              transition: Transition.noTransition);
                        },
                        icon: Icon(
                          Icons.add,
                          color: primarycolor,
                        ))
                  ],
                ),
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Tax Category",
                  style: subheadline3,
                ),
                Container(
                  width: width * .58,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: lightblackcolor,
                      width: 1.0,
                    ),
                  )),
                  child: DropdownButton<TaxCategory>(
                    isExpanded: true,
                    underline: Container(),
                    hint: Text(
                      "Select Tax",
                      style: subheadline,
                    ),
                    value: taxdropdown,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: taxCategory.map((TaxCategory taxCategory) {
                      return DropdownMenuItem<TaxCategory>(
                        value: taxCategory,
                        child:
                            Text("${taxCategory.taxcategory_name}".toString()),
                      );
                    }).toList(),
                    onChanged: (TaxCategory? newValue) {
                      setState(() {
                        taxdropdown = newValue!;
                      });
                    },
                  ),
                ),
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "GST(%)",
                  style: subheadline3,
                ),
                taxdropdown == 'GST'
                    ? Container(
                        width: width * .58,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: DropdownButton<GST>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            "Select GST",
                            style: subheadline,
                          ),
                          value: gstdropdown,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: gst.map((GST gst) {
                            return DropdownMenuItem<GST>(
                              value: gst,
                              child: Text("${gst.GST_name}".toString()),
                            );
                          }).toList(),
                          onChanged: (GST? newValue) {
                            setState(() {
                              gstdropdown = newValue!;
                            });
                          },
                        ),
                      )
                    : Container(
                        width: width * .58,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: DropdownButton<GST1>(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            "Select GST",
                            style: subheadline,
                          ),
                          value: gstdropdown1,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: gst1.map((GST1 gst1) {
                            return DropdownMenuItem<GST1>(
                              value: gst1,
                              child: Text("${gst1.GST_name1}".toString()),
                            );
                          }).toList(),
                          onChanged: (GST1? newValue) {
                            setState(() {
                              gstdropdown1 = newValue!;
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
                    "Minimum Stock",
                    style: subheadline3,
                  ),
                  Container(
                      width: width * .58,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
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
                    "Opening Stock",
                    style: subheadline3,
                  ),
                  Container(
                      width: width * .58,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
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
                    "Opening Amount",
                    style: subheadline3,
                  ),
                  Container(
                      width: width * .58,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //SizedBox
                  Text(
                    'Sale Without Purchase',
                    style: TextStyle(fontSize: 17.0),
                  ), //Text
                  // SizedBox(width: width * .10), //SizedBox
                  Checkbox(
                    value: this.value,
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ),
                  value == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "InStock",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .10,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: TextFormField(
                                      initialValue: "0",
                                      textAlign: TextAlign.center,
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        )
                      : Container()
                ], //<Widget>[]
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Description",
                    style: subheadline3,
                  ),
                  Container(
                      width: width * .58,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextFormField(
                        maxLines: null,
                        minLines: null,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Radio(
                        value: "Sale on MRP",
                        groupValue: sale,
                        onChanged: (value) {
                          setState(() {
                            sale = value.toString();
                          });
                        }),
                    Text(
                      "Sale on MRP",
                      style: subheadline3,
                    ),
                  ],
                ),
                Row(children: [
                  Radio(
                      value: "Sale on Own Price",
                      groupValue: sale,
                      onChanged: (value) {
                        setState(() {
                          sale = value.toString();
                        });
                      }),
                  Text(
                    "Sale on own price",
                    style: subheadline3,
                  ),
                ]),
              ]),
              Column(children: [
                sale == "Sale on MRP"
                    ? Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "MRP",
                              style: subheadline3,
                            ),
                            Container(
                                width: width * .58,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: lightblackcolor,
                                    width: 1.0,
                                  ),
                                )),
                                child: TextField(
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Discount On MRP",
                                style: subheadline3,
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: "Amount",
                                      groupValue: discount,
                                      onChanged: (value) {
                                        setState(() {
                                          discount = value.toString();
                                        });
                                      }),
                                  Text(
                                    "Amount",
                                    style: subheadline3,
                                  ),
                                ],
                              ),
                              Row(children: [
                                Radio(
                                    value: "Per(%)",
                                    groupValue: discount,
                                    onChanged: (value) {
                                      setState(() {
                                        discount = value.toString();
                                      });
                                    }),
                                Text(
                                  "Per(%)",
                                  style: subheadline3,
                                ),
                              ]),
                            ]),
                        Container(
                            width: width * .20,
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: lightblackcolor,
                                width: 1.0,
                              ),
                            )),
                            child: TextField(
                              cursorColor: lightblackcolor,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Sale Price",
                              style: subheadline3,
                            ),
                            Row(
                              children: [
                                Container(
                                    width: width * .40,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: TextField(
                                      controller: sales_price_withtax,
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    )),
                                Text(
                                  "(Tax Included)",
                                  style: subheadline3,
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sales Margin\nCriteria",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: TextField(
                                      controller: sales_margin_criteria,
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sales Margin",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: TextField(
                                      controller: sales_margin,
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sale Price",
                                  style: subheadline3,
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: width * .40,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: lightblackcolor,
                                            width: 1.0,
                                          ),
                                        )),
                                        child: TextField(
                                          controller: sales_price_withouttax,
                                          cursorColor: lightblackcolor,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        )),
                                    Text(
                                      "(Without Tax)",
                                      style: subheadline3,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Min Sale Price",
                                  style: subheadline3,
                                ),
                                Container(
                                    width: width * .58,
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: lightblackcolor,
                                        width: 1.0,
                                      ),
                                    )),
                                    child: TextField(
                                      controller: min_sale_price,
                                      cursorColor: lightblackcolor,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        )
                      ])
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "MRP",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .58,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: lightblackcolor,
                                      width: 1.0,
                                    ),
                                  )),
                                  child: TextFormField(
                                    controller: mrp,
                                    initialValue: "0",
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        enabled: false),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sales Margin\nCriteria",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .58,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: lightblackcolor,
                                      width: 1.0,
                                    ),
                                  )),
                                  child: TextField(
                                    controller: sales_margin_criteria,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sales Margin",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .58,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: lightblackcolor,
                                      width: 1.0,
                                    ),
                                  )),
                                  child: TextField(
                                    controller: sales_margin,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sale Price",
                                style: subheadline3,
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: width * .40,
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                          color: lightblackcolor,
                                          width: 1.0,
                                        ),
                                      )),
                                      child: TextField(
                                        controller: sales_price_withouttax,
                                        cursorColor: lightblackcolor,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      )),
                                  Text(
                                    "(Without Tax)",
                                    style: subheadline3,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Min Sale Price",
                                style: subheadline3,
                              ),
                              Container(
                                  width: width * .58,
                                  decoration: BoxDecoration(
                                      border: Border(
                                    bottom: BorderSide(
                                      color: lightblackcolor,
                                      width: 1.0,
                                    ),
                                  )),
                                  child: TextField(
                                    controller: min_sale_price,
                                    cursorColor: lightblackcolor,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
              ]),
              SizedBox(
                height: height * .02,
              ),
              Text(
                "Purchase Details",
                style: subheadline1,
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
                      width: width * .58,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: lightblackcolor,
                          width: 1.0,
                        ),
                      )),
                      child: TextField(
                        controller: best_price,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Discount(%)",
                  style: subheadline3,
                ),
                Container(
                    width: width * .58,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      controller: description,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ]),
              SizedBox(
                height: height * .01,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Purchase Price",
                  style: subheadline3,
                ),
                Container(
                    width: width * .58,
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      controller: purchase_price,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
              ]),
              SizedBox(
                height: height * .04,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                    width: width * .20,
                    child: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          CreateItem();
                        });
                        Get.back();
                      },
                      child: Text("Save"),
                      color: primarycolor,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      pressedOpacity: 0.6,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    )),
                SizedBox(
                  width: width * .02,
                ),
                Container(
                    width: width * .20,
                    child: CupertinoButton(
                      onPressed: () {
                        // Get.to(SupplierForm(),
                        //     duration: Duration(milliseconds: 500),
                        //     transition: Transition.rightToLeft);
                      },
                      child: Text("Cancel"),
                      color: lightblackcolor,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      pressedOpacity: 0.6,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ))
              ]),
              SizedBox(
                height: height * .04,
              ),
            ],
          )),
    );
  }

  final TextEditingController category = TextEditingController();
  final TextEditingController category_discription = TextEditingController();

  Future CreateCategory() async {
    var request = http.MultipartRequest('POST', Uri.parse(create_category));
    request.fields.addAll({'category': category.text});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _showDecline(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CREATE CATEGORY"),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.clear)),
                ],
              ),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Category"),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .20),
                            Container(
                                width: MediaQuery.of(context).size.width * .30,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: lightblackcolor,
                                    width: 1.0,
                                  ),
                                )),
                                child: TextField(
                                  controller: category,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Category",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Description"),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * .20),
                            Container(
                                width: MediaQuery.of(context).size.width * .30,
                                decoration: const BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: lightblackcolor,
                                    width: 1.0,
                                  ),
                                )),
                                child: TextField(
                                  controller: category_discription,
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Category_discription",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    )),
              ]),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Save"),
                  onPressed: () {
                    setState(() {
                      CreateCategory();
                      setState(() {});
                    });
                    Get.back();
                  },
                ),
                FlatButton(
                  child: new Text("Cancel"),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
