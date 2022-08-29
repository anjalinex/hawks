import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Repository/ApiServices.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/customer/customer_form.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import '../../Model/viewCustomerDetails.dart';
import '../../constants/style.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({Key? key}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
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
    ApiServices().ViewCustomer();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarycolor,
        title: Text("Customer Details"),
      ),
      body: RefreshIndicator(
          color: primarycolor,
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 1), () {
              ApiServices().ViewCustomer();
            });
            setState(() {});
          },
          child: Padding(
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
                                    child: Icon(Icons.clear,
                                        color: lightblackcolor),
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
                          Get.to(CustomerDetails(),
                              transition: Transition.rightToLeft);
                        },
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Expanded(
                    child: FutureBuilder<ViewCustomerDetails>(
                        future: ApiServices().ViewCustomer(),
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
                                                  Text("Customer Name :"),
                                                  Expanded(
                                                      child: Text(
                                                    "${data?.customerName}",
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
                                                  Text(
                                                    "Customer Address :",
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    "${data?.address}",
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
                                                      textAlign:
                                                          TextAlign.right,
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
                                                    Text("e-mail :"),
                                                    Expanded(
                                                        child: Text(
                                                      "${data?.email}",
                                                      textAlign:
                                                          TextAlign.right,
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
                                                  Text("Action"),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
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
                                                                  .DeleteCustomerDetails(
                                                                      "${data?.id}");
                                                              setState(() {
                                                                ApiServices()
                                                                    .ViewCustomer();
                                                              });
                                                            });
                                                          },
                                                          icon: Icon(
                                                              Icons.delete,
                                                              color: Color(
                                                                  0xffAB2328)))
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ]),
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
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: primarycolor,
          onPressed: () {
            Get.to(CustomerForm(),
                duration: Duration(milliseconds: 300),
                transition: Transition.rightToLeft);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
