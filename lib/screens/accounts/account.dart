import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import '../../constants/style.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  String? balancedropdown;

  var balance = [
    'Cr.',
    'Dr.'
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Account"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                SizedBox(
                  height: height * .02,
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
                                    Text("SN."),
                                    Text("${index + 1}"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Name"),
                                    Text("Anjali"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Alias"),
                                    Text(" "),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Parent Group	"),
                                    Text("Cash-in-hand"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Opening Balance (CR/DR)"),
                                    Text(" "),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Action"),
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: bordercolor,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    })
              ],
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: primarycolor,
            onPressed: () async {
              await _showDecline(context);
            },
            child: Icon(Icons.add),
          ),
        ));
  }

  String? dropdownvalue;
  var items = [
    'direct',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  Future<void> _showDecline(BuildContext context) async {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add Account Name"),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.clear)),
                  ],
                ),
                content:  Column(
                  mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Name"),
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
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Name",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Alias"),
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
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Alias",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Print Name"),
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
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Print Name",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Group",
                              style: subheadline3,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .30,
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: lightblackcolor,
                                  width: 1.0,
                                ),
                              )),
                              child: DropdownButton(
                                isExpanded: true,
                                underline: Container(
                                  color: Colors.white,
                                ),
                                // hint: Text("Select Item Center"),
                                value: dropdownvalue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Opening\nBalance"),
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
                                  cursorColor: lightblackcolor,
                                  decoration: InputDecoration(
                                    hintText: "Print Name",
                                    hintStyle: subheadline,
                                    border: InputBorder.none,
                                  ),
                                )),
                            Container(
                              width: width * .10,
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
                                  "Cr",
                                  style: subheadline,
                                ),
                                value: balancedropdown,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: balance.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    balancedropdown = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new Container(
                      width: width * .15,
                      child: CupertinoButton(
                        child: Text("Submit"),
                        color: bordercolor,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        pressedOpacity: 0.6,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        onPressed: () {
                          Get.back();
                        },
                      )),
                  Container(
                      width: width * .15,
                      child: CupertinoButton(
                        child: Text("Cancel"),
                        color: redcolor,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        pressedOpacity: 0.6,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        onPressed: () {
                          Get.back();
                        },
                      )),
                ]);
          },
        );
      },
    );
  }
}
