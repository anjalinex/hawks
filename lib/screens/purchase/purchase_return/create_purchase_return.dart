import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/sales_return.dart';
import 'package:intl/intl.dart';
import '../../../constants/style.dart';
import 'create_purchase_return1.dart';

class CreatePurchaseReturn extends StatefulWidget {
  const CreatePurchaseReturn({Key? key}) : super(key: key);

  @override
  State<CreatePurchaseReturn> createState() => _CreatePurchaseReturnState();
}

class _CreatePurchaseReturnState extends State<CreatePurchaseReturn> {
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Create Purchase Return"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
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
                      "Select Customer",
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
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  "Address :",
                  style: subheadline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        //
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      cursorColor: lightblackcolor,
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                          left: 10,
                        ),
                        hintText: "Address",
                        hintStyle: subheadline,
                        border: InputBorder.none,
                      ),
                    )),
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
                          _selectedDate != null
                              ? _selectedDate.toString()
                              : 'DD-MM-YY',
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
                  height: height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Bill No."),
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
                            Get.to(CreatePurchaseReturn1(),
                                transition: Transition.rightToLeft);
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
