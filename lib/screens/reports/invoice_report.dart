import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/customer/customer_form.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:intl/intl.dart';
import '../../constants/style.dart';

class InvoiceReport extends StatefulWidget {
  const InvoiceReport({Key? key}) : super(key: key);

  @override
  State<InvoiceReport> createState() => _InvoiceReportState();
}

class _InvoiceReportState extends State<InvoiceReport> {
  final TextEditingController _search = TextEditingController();
  String? dropdownvalue;
  var supplier = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todatePicked = DateTime.now();
    fromdatePicked = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Invoice Report"),
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
              Text(
                "Search By",
                style: subheadline3,
              ),
              SizedBox(
                height: height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Customer",
                    style: subheadline3,
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
                        "Select Customer",
                        style: subheadline,
                      ),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: supplier.map((String items) {
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "From",
                        style: subheadline3,
                      ),
                      SizedBox(width: width * .04,),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${fromdatePicked?.day}"
                                    "/"
                                    "${fromdatePicked?.month}"
                                    "/"
                                    "${fromdatePicked?.year}",
                                style: subheadline3,
                              ),
                              IconButton(
                                  onPressed: () {
                                    _showDatePicker1();
                                  },
                                  icon: Icon(Icons.date_range)),
                            ]
                        ),)
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To",
                        style: subheadline3,
                      ),
                      SizedBox(width: width * .04,),
                      Container(
                          width: width * .30,
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
                                "${todatePicked?.day}"
                                    "/"
                                    "${todatePicked?.month}"
                                    "/"
                                    "${todatePicked?.year}",
                                style: subheadline3,
                              ),
                              IconButton(
                                  onPressed: () {
                                    _showDatePicker1();
                                  },
                                  icon: Icon(Icons.date_range))
                            ],
                          ))
                    ]),
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
                        onPressed: () {},
                        child: Text("Submit"),
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
              // SizedBox(
              //   height: height * .02,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       width: width * .80,
              //       decoration: BoxDecoration(
              //         // border: Border.all(
              //         //   color: lightblackcolor,
              //         //   width: 1.0,
              //         // ),
              //         // borderRadius: BorderRadius.circular(30)
              //       ),
              //       child: TextField(
              //         controller: _search,
              //         cursorColor: lightblackcolor,
              //         decoration: InputDecoration(
              //             hintText: "Search...",
              //             hintStyle: subheadline,
              //             border: InputBorder.none,
              //             // prefixIcon: Icon(Icons.search,color: Colors.grey.shade300,),
              //             // suffixIcon: Icon(Icons.filter,color: Colors.grey.shade300,)
              //             suffixIcon: _search.text.isNotEmpty &&
              //                 _search.text.length >= 1
              //                 ? GestureDetector(
              //               onTap: () {
              //                 setState(() {
              //                   WidgetsBinding.instance
              //                       .addPostFrameCallback(
              //                           (_) => _search.clear());
              //                 });
              //               },
              //               child:
              //               Icon(Icons.clear, color: lightblackcolor),
              //             )
              //                 : null),
              //         onChanged: (value) {
              //           setState(() {});
              //         },
              //       ),
              //     ),
              //     // Icon(Icons.search,color: lightblackcolor,)
              //     Container(
              //       height: height * .05,
              //       width: width * .10,
              //       child: FloatingActionButton(
              //         backgroundColor: primarycolor,
              //         onPressed: () {
              //         },
              //         child: Icon(
              //           Icons.search,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // Divider(thickness: 2,),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Invoice :"),
                                    Text("Show",
                                        style: TextStyle(color: Colors.teal)),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Thermal Invoice :"),
                                    Text("Show",
                                        style: TextStyle(color: Colors.teal)),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Short Thermal Invoice :"),
                                    Text("Show",
                                        style: TextStyle(color: Colors.teal)),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Customer Name :"),
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
                                      Text("Mobile No. :"),
                                      Text("NA"),
                                    ]),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Bill No. :"),
                                      Text("NA"),
                                    ]),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Bill Date :"),
                                    Text("NA"),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                              ]),
                          // )
                        ));
                  }),
            ],
          ),
        ));
  }

  DateTime? fromdatePicked;
  var _selectedDate;
  Future<void> _showDatePicker() async {
    fromdatePicked = await showDatePicker(
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
      _selectedDate = DateFormat("dd-MM-yyyy").format(fromdatePicked!);
    });
  }

  DateTime? todatePicked;
  var _selectedDate1;
  Future<void> _showDatePicker1() async {
    todatePicked = await showDatePicker(
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
      _selectedDate1 = DateFormat("dd-MM-yyyy").format(todatePicked!);
    });
  }
}
