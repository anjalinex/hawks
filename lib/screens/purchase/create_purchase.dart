import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/sales_return.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';
import '../../../constants/style.dart';

class CreatePurchase extends StatefulWidget {
  const CreatePurchase({Key? key}) : super(key: key);
  @override
  State<CreatePurchase> createState() => _CreatePurchaseState();
}

class _CreatePurchaseState extends State<CreatePurchase> {
  String? customerdropdownvalue;
  String? GSTTypedropdown;
  String? saletypedropdownvalue;
  String? posDropdown;
  String? itemCenterDropdown;
  String? cusTypedropdown;
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
    'import',
    'Excempt',
    'Nil Rated'
        'Unreg(RCM)',
    'Zero Rated',
  ];

  var saleType = [
    'Direct',
    'Quotation',
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
          title: Text("Create Purchase"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width * .80,
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
                          "Select Supplier",
                          style: subheadline,
                        ),
                        value: customerdropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: customer.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
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
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
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
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  width: width * .40,
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
                SizedBox(
                  height: height * .02,
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  width: width * .40,
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
                      "Select Purc Type",
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
                SizedBox(
                  height: height * .02,
                ),
                Container(
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
                        labelText: "Sup. Inv. No.",
                        labelStyle: subheadline,
                        hintText: "Sup. Inv. No.",
                        hintStyle: subheadline,
                        border: InputBorder.none,
                      ),
                    )),
                SizedBox(
                  height: height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Bill No."),
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
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  width: width * .40,
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
                      "Select Item Center",
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
                SizedBox(
                  height: height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: width * .20,
                        child: CupertinoButton(
                          child: Text("Submit"),
                          color: primarycolor,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          pressedOpacity: 0.6,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          onPressed: () {
                            Get.back();
                          },
                        )),
                  ],
                )
              ],
            )));
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
