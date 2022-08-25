import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/viewcompanydetails.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/Sales/create_salereturn.dart';
import 'package:hawks/screens/settings/company_form.dart';
import 'package:hawks/screens/settings/edit_company.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Repository/ApiServices.dart';
import '../../constants/style.dart';
import '../supplier/supllier_details.dart';

class ManageSetting extends StatefulWidget {
  const ManageSetting({Key? key}) : super(key: key);

  @override
  State<ManageSetting> createState() => _ManageSettingState();
}

class _ManageSettingState extends State<ManageSetting> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiServices().Viewcompany();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Manage Settings"),
        ),
        body: RefreshIndicator(
        color: primarycolor,
        onRefresh: () async {
        await Future.delayed(Duration(seconds: 1), () {
        ApiServices().Viewcompany();
        });
        setState(() {});
        },
        child:Padding(
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
                  child: FutureBuilder<ViewCompanyDetails>(
                      future: ApiServices().Viewcompany(),
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
                                                Text("Company Name :"),
                                                Text("${data?.companyName}"),
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
                                                  Text("${data?.gstNo}"),
                                                ]),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text("Contact :"),
                                                  Text("${data?.contactNo}"),
                                                ]),
                                            SizedBox(
                                              height: height * .01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("Email / Username :"),
                                                Text("${data?.email}"),
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height: height * .01,
                                            // ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     Text("Website :"),
                                            //     Text("${data?.gstNo}"),
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
                                                Text("Address :"),
                                                Text("${data?.address}"),
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height: height * .01,
                                            // ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     Text("Branch :"),
                                            //     Text("NA"),
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
                                                Text("Actions :"),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                        onPressed: () async {
                                                          final prefs = await SharedPreferences.getInstance();
                                                         var id = prefs.setString("id", "${data?.id}");
                                                          var companyName = prefs.setString("companyName", "${data?.companyName}");
                                                          var email = prefs.setString("email", "${data?.email}");
                                                          var contactNo = prefs.setString("contactNo", "${data?.contactNo}");
                                                          var username = prefs.setString("username", "${data?.username}");
                                                          var address = prefs.setString("address", "${data?.address}");
                                                          var locality = prefs.setString("locality", "${data?.locality}");
                                                          var zipcode = prefs.setString("zipcode", "${data?.zipcode}");
                                                          var gstNo = prefs.setString("gstNo", "${data?.gstNo}");
                                                          Get.to(
                                                              EditCompanyForm(
                                                            // "${data?.id}",
                                                            // "${data?.companyName}",
                                                            // "${data?.email}",
                                                            // "${data?.contactNo}",
                                                            // "${data?.username}",
                                                            // "${data?.address}",
                                                            // "${data?.locality}",
                                                            // "${data?.zipcode}",
                                                            // "${data?.gstNo}",
                                                          ));
                                                        },
                                                        icon: Icon(Icons.edit,
                                                            color:
                                                                bordercolor)),
                                                    IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ApiServices()
                                                                .DeleteCompanyDetails(
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
        )
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: primarycolor,
            onPressed: () {
              Get.to(CompanyForm(),
                  duration: Duration(milliseconds: 200),
                  transition: Transition.rightToLeft);
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
