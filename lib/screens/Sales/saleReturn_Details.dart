import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/create_salereturn.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import '../../constants/style.dart';
import '../supplier/supllier_details.dart';

class SalesReturnDetails extends StatefulWidget {
  const SalesReturnDetails({Key? key}) : super(key: key);

  @override
  State<SalesReturnDetails> createState() => _SalesReturnDetailsState();
}

class _SalesReturnDetailsState extends State<SalesReturnDetails> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Sale Return"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              SizedBox(
                height: height * .02,
              ),
              Text(
                "Return No.",
                style: subheadline3,
              ),
              SizedBox(
                height: height * .02,
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
                        Get.to(CreateSaleReturn(),
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
              // Container(
              //   decoration: BoxDecoration(
              //       border: Border.all(
              //         color: lightblackcolor,
              //         width: 1.0,
              //       ),
              //       borderRadius: BorderRadius.circular(30)),
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 10),
              //     child: TextField(
              //       controller: _search,
              //       cursorColor: lightblackcolor,
              //       decoration: InputDecoration(
              //           hintText: "Search...",
              //           hintStyle: subheadline,
              //           border: InputBorder.none,
              //         prefixIcon: Icon(Icons.search,color: Colors.grey.shade300,),
              //            suffixIcon: Icon(Icons.filter,color: Colors.grey.shade300,)
              //           // suffixIcon:
              //           // _search.text.isNotEmpty &&
              //           //         _search.text.length >= 1
              //           //     ? GestureDetector(
              //           //         onTap: () {
              //           //           setState(() {
              //           //             WidgetsBinding.instance
              //           //                 .addPostFrameCallback(
              //           //                     (_) => _search.clear());
              //           //           });
              //           //         },
              //           //         child: Icon(Icons.clear,
              //           //             color: Colors.black38),
              //           //       )
              //           //     : null
              //       ),
              //       onChanged: (value) {
              //         setState(() {});
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: height * .02,
              ),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Container(
              //           width: width * .30,
              //           child: CupertinoButton(
              //             onPressed: () {
              //               // Get.to(SupplierForm(),
              //               //     duration: Duration(milliseconds: 500),
              //               //     transition: Transition.rightToLeft);
              //             },
              //             child: Text("Filter"),
              //             color: primarycolor,
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             pressedOpacity: 0.6,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(20)),
              //           )),
              //       SizedBox(
              //         width: width * .02,
              //       ),
              //       Container(
              //           width: width * .30,
              //           child: CupertinoButton(
              //             onPressed: () {
              //               // Get.to(SupplierForm(),
              //               //     duration: Duration(milliseconds: 500),
              //               //     transition: Transition.rightToLeft);
              //             },
              //             child: Text("Clear"),
              //             color: lightblackcolor,
              //             padding: EdgeInsets.only(left: 10, right: 10),
              //             pressedOpacity: 0.6,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(20)),
              //           ))
              //     ]),
              ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return
                        // Container(
                        //   height: height * .25,
                        //   decoration: BoxDecoration(
                        //       border: Border(
                        //         left: BorderSide(
                        //           color: lightblackcolor,
                        //           width: 1.0,
                        //         ),
                        //       )
                        //   ),
                        //   child:
                        Card(
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
                                        Text("Return No :"),
                                        Expanded(child: Text("NA")),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Return Date	:"),
                                          Text("NA"),
                                        ]),
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Order No :"),
                                          Text("NA"),
                                        ]),
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
                                        Text("Unit. :"),
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
                                        Text("Returned Qty :"),
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
                                        Text("Status :"),
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
                                        Text("Remarks :"),
                                        Text("NA"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                  ]),
                              // )
                            ));
                  }),
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
              Get.to(CreateSaleReturn(),
                  duration: Duration(milliseconds: 200),
                  transition: Transition.rightToLeft);
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
