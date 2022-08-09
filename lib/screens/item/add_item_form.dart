import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final TextEditingController item_name = TextEditingController();
  final TextEditingController sku = TextEditingController();
  final TextEditingController hsn = TextEditingController();
  final TextEditingController barcode = TextEditingController();
  final TextEditingController minimum_stock = TextEditingController();
  final TextEditingController opening_stock = TextEditingController();
  final TextEditingController opening_amount = TextEditingController();
  final TextEditingController in_stock = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController mrp = TextEditingController();
  final TextEditingController Discount = TextEditingController();
  final TextEditingController purchase_price = TextEditingController();

  String? sale = "Sale on MRP";
  String? discount = "Amount";
  bool value = false;
  String? unitdropdown;
  String? itemsizedropdown;
  String? itemcolordropdown;

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

  //Category
  String? categoryDropdownValue;
  List categorydata = []; //edited line
  Future<String> getCityData() async {
    http.Response response =
        await http.post(Uri.parse(view_category)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        categorydata = data["data"];
        print(categorydata);
      });
      return response;
    });
    return "success";
  }

  Future CreateCustomer() async {
    var request = http.MultipartRequest('POST', Uri.parse(createitems_details));
    request.fields.addAll({
      'category_id': '2',
      'item_name': item_name.text,
      'sku': sku.text,
      'hsn': hsn.text,
      'barcode': barcode.text,
      'unit_id': '2',
      'itme_size_id': '1',
      'item_color_id': '1',
      'tax_category': 'GST',
      'gst': '2',
      'minimum_stock': minimum_stock.text,
      'opening_stock': opening_stock.text,
      'opening_amount': opening_amount.text,
      'in_stock': '2',
      'description': " ",
      'sales': '0',
      'mrp': mrp.text,
      'discount': Discount.text,
      'amount': '100',
      'sales_price_withtax': '5',
      'sales_margin_criteria': '20',
      'sales_margin': '20',
      'sales_price_withouttax': '20',
      'min_sale_price': '20',
      'best_price': '5',
      'discount_purchase': '5',
      'purchase_price': '10'
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  var items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  var units = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  var itemsize = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  var itemcolor = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gstdropdown = gst[0];
    gstdropdown1 = gst1[0];
    taxdropdown = taxCategory[0];
  }

  @override
  Widget build(BuildContext context) {
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
                  Container(
                      width: width * .58,
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
                          "Select City",
                          style: loginhinttext,
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: categorydata.map((items) {
                          return DropdownMenuItem(
                            value: items['id'].toString(),
                            child: Text(items['name'].toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            categoryDropdownValue = newValue!;
                          });
                        },
                      )),
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
                        child: DropdownButton(
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            "--Select Unit--",
                            style: subheadline,
                          ),
                          value: unitdropdown,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: units.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
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
                        hint: Text(
                          "--Select Option--",
                          style: subheadline,
                        ),
                        value: itemsizedropdown,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemsize.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            itemsizedropdown = newValue!;
                          });
                        },
                      ),
                    ),
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
                        hint: Text(
                          "--Select Option--",
                          style: subheadline,
                        ),
                        value: itemcolordropdown,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemcolor.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            itemcolordropdown = newValue!;
                          });
                        },
                      ),
                    ),
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
                      "Select Title",
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
                taxdropdown == "GST"
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
}
