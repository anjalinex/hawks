import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/create_salereturn.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';
import '../../../constants/style.dart';

class CreatePurchaseReturn1 extends StatefulWidget {
  const CreatePurchaseReturn1({Key? key}) : super(key: key);

  @override
  State<CreatePurchaseReturn1> createState() => _CreatePurchaseReturn1State();
}

class _CreatePurchaseReturn1State extends State<CreatePurchaseReturn1> {

  final TextEditingController _search = TextEditingController();
  String? dropdownvalue;
  String? itemnamedropdownvalue;
  String? unitdropdown;
  String? itemcolordropdown;
  String? itemsizedropdown;
  var supplier = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  var items = [
    '123424325saf',
    'qe1424355455',
  ];

  var unit = [
    'PCS',
  ];

  var itemColor = ['CHARCOAL BLACK'];

  var itemsize = ['S', 'XS', 'M', 'XM', 'L', 'XL'];
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
            child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: height * .02,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: width * .30,
                              child: CupertinoButton(
                                onPressed: () {
                                  Get.dialog(AlertDialog(
                                    content: StatefulBuilder(
                                      // You need this, notice the parameters below:
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Bill Details",
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: Icon(Icons.clear))
                                                ],
                                              ),
                                              Container(
                                                  width: width * .35,
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
                                                      contentPadding:
                                                      const EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                      hintText:
                                                      "Search Bill No./Customer Name",
                                                      hintStyle: subheadline,
                                                      border: InputBorder.none,
                                                    ),
                                                  )),
                                              Container(
                                                  width: width * .35,
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
                                                        _selectedDate != null
                                                            ? _selectedDate.toString()
                                                            : 'Date Wise',
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _showDObPicker();
                                                            });
                                                          },
                                                          icon: Icon(Icons.date_range))
                                                    ],
                                                  )),
                                              SizedBox(
                                                height: height * .02,
                                              ),
                                              Container(
                                                  width: width * .20,
                                                  child: CupertinoButton(
                                                    child: Text("Search"),
                                                    color: Colors.teal,
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    pressedOpacity: 0.6,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20)),
                                                    onPressed: () {},
                                                  )),
                                            ],
                                          );
                                        }),
                                    backgroundColor: Colors.white,
                                  ));
                                },
                                child: Text("Show Bill"),
                                color: primarycolor,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                pressedOpacity: 0.6,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: width * .45,
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
                                  contentPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  hintText: "SKU/Barcode",
                                  hintStyle: subheadline,
                                  border: InputBorder.none,
                                ),
                              )),
                          Container(
                            width: width * .45,
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
                                "Select Item",
                                style: subheadline,
                              ),
                              value: itemnamedropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  itemnamedropdownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * .45,
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
                                "Select Unit",
                                style: subheadline,
                              ),
                              value: unitdropdown,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: unit.map((String items) {
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
                          Container(
                            width: width * .45,
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
                                "Select Color",
                                style: subheadline,
                              ),
                              value: itemcolordropdown,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: itemColor.map((String items) {
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
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width * .45,
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
                                  "Select Size",
                                  style: subheadline,
                                ),
                                value: itemcolordropdown,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: itemColor.map((String items) {
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
                            Container(
                                width: width * .45,
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
                                    contentPadding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    hintText: "Qty",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ]),
                      SizedBox(
                        height: height * .02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: width * .45,
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
                                  contentPadding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  hintText: "Price",
                                  hintStyle: subheadline,
                                  border: InputBorder.none,
                                ),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: primarycolor),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                iconSize: 25,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      ListView.builder(
                          itemCount: 5,
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
                                          MainAxisAlignment.spaceBetween,
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
                                          MainAxisAlignment.spaceBetween,
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
                                          MainAxisAlignment.spaceBetween,
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
                                          MainAxisAlignment.spaceBetween,
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
                                          MainAxisAlignment.spaceBetween,
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
                                          MainAxisAlignment.spaceBetween,
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
                                          MainAxisAlignment.spaceBetween,
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
                          }),
                    ],
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: width * .30,
                          child: CupertinoButton(
                            onPressed: () {
                              // _formKey.currentState?.validate();
                              // Get.to(SupplierDetails(),
                              //     duration: Duration(milliseconds: 500),
                              //     transition: Transition.rightToLeft);
                            },
                            child: Text("Update"),
                            color: primarycolor,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            pressedOpacity: 0.6,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      Container(
                          width: width * .30,
                          child: CupertinoButton(
                            onPressed: () {},
                            child: Text("Cancle"),
                            color: lightblackcolor,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            pressedOpacity: 0.6,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                ]))),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: primarycolor,
            onPressed: () {
              Get.to(CreateSaleReturn(), transition: Transition.rightToLeft);
            },
            child: Icon(Icons.add),
          ),
        ));
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
