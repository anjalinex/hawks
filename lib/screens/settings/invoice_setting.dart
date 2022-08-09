import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/viewInvoiceDetails.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/create_salereturn.dart';
import 'package:hawks/screens/settings/company_form.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import '../../Repository/ApiServices.dart';
import '../../constants/style.dart';
import '../supplier/supllier_details.dart';
import 'add _invoice_setting.dart';

class InvoiceSetting extends StatefulWidget {
  const InvoiceSetting({Key? key}) : super(key: key);

  @override
  State<InvoiceSetting> createState() => _InvoiceSettingState();
}

class _InvoiceSettingState extends State<InvoiceSetting> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServices().ViewInvoice();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Invoice Settings"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              SizedBox(
                height: height * .02,
              ),
              Text(
                "Search",
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
                      onPressed: () {},
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
                  child: FutureBuilder<ViewInvoiceDetails>(
                      future: ApiServices().ViewInvoice(),
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
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     Text("User :"),
                                            //     Text("${data}"),
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Invoice Type :"),
                                                  Text("${data?.invoiceType}"),
                                                ]),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Invoice Format :"),
                                                  Text(
                                                      "${data?.invoiceFormat}"),
                                                ]),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Name :"),
                                                Text("${data?.invoiceName}"),
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
                                                Text("T&C 1 :"),
                                                Text(
                                                    "${data?.termsCondition1}"),
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
                                                Text("T&C 2 :"),
                                                Text(
                                                    "${data?.termsCondition2}"),
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
                                                Text("T&C 3 :"),
                                                Text(
                                                    "${data?.termsCondition3}"),
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
                                                Text("T&C 3 :"),
                                                Text(
                                                    "${data?.termsCondition4}"),
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
                                                Text("IFSC :"),
                                                Text("${data?.ifscCode}"),
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
                                                Text("Account No :"),
                                                Text("${data?.accountNo}"),
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
                                                Text("Actions :"),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {},
                                                        icon: Icon(Icons.edit,
                                                            color:
                                                                bordercolor)),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ApiServices()
                                                                .DeleteInvoiceDetails(
                                                                    "${data?.id}");
                                                            setState(() {});
                                                          });
                                                        },
                                                        icon: Icon(Icons.delete,
                                                            color: redcolor))
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * .02,
                                            ),
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
              Get.to(AddInvoiceSetting(),
                  duration: Duration(milliseconds: 200),
                  transition: Transition.rightToLeft);
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
