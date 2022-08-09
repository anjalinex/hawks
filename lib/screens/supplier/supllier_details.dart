import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/view_supplier.dart';
import 'package:hawks/Repository/ApiServices.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';

import '../../constants/style.dart';

class SupplierDetails extends StatefulWidget {
  const SupplierDetails({Key? key}) : super(key: key);

  @override
  State<SupplierDetails> createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
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
    ApiServices().ViewSupplier();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Supplier Details"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
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
                width: width * .02,
              ),
              DropdownButton(
                isExpanded: true,
                underline: Container(),
                hint: Text(
                  "Select Title",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width * .80,
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: lightblackcolor,
                        //   width: 1.0,
                        // ),
                        // borderRadius: BorderRadius.circular(30)
                        ),
                    child: TextField(
                      controller: _search,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                          hintText: "Search...",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                          // prefixIcon: Icon(Icons.search,color: Colors.grey.shade300,),
                          // suffixIcon: Icon(Icons.filter,color: Colors.grey.shade300,)
                          suffixIcon: _search.text.isNotEmpty &&
                                  _search.text.length >= 1
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                              (_) => _search.clear());
                                    });
                                  },
                                  child:
                                      Icon(Icons.clear, color: lightblackcolor),
                                )
                              : null),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  // Icon(Icons.search,color: lightblackcolor,)
                  Container(
                    height: height * .05,
                    width: width * .10,
                    child: FloatingActionButton(
                      backgroundColor: primarycolor,
                      onPressed: () {
                        Get.to(SupplierDetails(),
                            transition: Transition.rightToLeft);
                      },
                      child: Icon(
                        Icons.search,
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: height * .02,
              ),
              Expanded(
                  child: FutureBuilder<ViewSupplierDetails>(
                      future: ApiServices().ViewSupplier(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data?.data.length,
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
                                                Expanded(
                                                    child: Text(
                                                  "${data?.supplierName}",
                                                  textAlign: TextAlign.right,
                                                )),
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
                                                  Text("Mobile No. :"),
                                                  Expanded(
                                                      child: Text(
                                                    "${data?.mobileNo}",
                                                    textAlign: TextAlign.right,
                                                  )),
                                                ]),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("City :"),
                                                  Expanded(
                                                      child: Text(
                                                    "${data?.city}",
                                                    textAlign: TextAlign.right,
                                                  )),
                                                ]),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("ZIP Code :"),
                                                Expanded(
                                                    child: Text(
                                                  "${data?.zipcode}",
                                                  textAlign: TextAlign.right,
                                                )),
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
                                                Text("GSTIN No. :"),
                                                Expanded(
                                                    child: Text(
                                                  "${data?.gstNo}",
                                                  textAlign: TextAlign.right,
                                                )),
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
                                                Text("Create Date :"),
                                                Expanded(
                                                    child: Text(
                                                  "${data?.createdAt}",
                                                  textAlign: TextAlign.right,
                                                )),
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
                                                Text("Action"),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(Icons.edit,
                                                            color:
                                                                Colors.cyan)),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ApiServices()
                                                                .DeleteSupplierDetails(
                                                                    "${data?.id}");
                                                            setState(() {});
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color:
                                                              Color(0xffAB2328),
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            )
                                          ]),
                                      // )
                                    ));
                              });
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: primarycolor,
                          ));
                        }
                      }))
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: primarycolor,
            onPressed: () {
              Get.to(SupplierForm(),
                  duration: Duration(milliseconds: 300),
                  transition: Transition.rightToLeft);
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
