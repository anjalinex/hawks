import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/viewItem_details.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/screens/customer/customer_details.dart';
import 'package:hawks/screens/customer/customer_form.dart';
import 'package:hawks/screens/item/add_item_form.dart';
import 'package:hawks/screens/item/edit_item.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import '../../Repository/ApiServices.dart';
import '../../constants/style.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
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
    ApiServices().ViewItem();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: Text("Item List"),
        ),
        body: RefreshIndicator(
            color: primarycolor,
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1), () {
                ApiServices().ViewItem();
              });
              setState(() {});
            },
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Stack(children: [
                  ListView(children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      "Search By",
                      style: subheadline3,
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
                          decoration: BoxDecoration(),
                          child: TextField(
                            controller: _search,
                            cursorColor: lightblackcolor,
                            decoration: InputDecoration(
                                hintText: "Search...",
                                hintStyle: subheadline,
                                border: InputBorder.none,
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
                    Divider(
                      thickness: 2,
                    ),
                    Expanded(
                        child: FutureBuilder<ViewItemDetails>(
                            future: ApiServices().ViewItem(),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                      Text("Category :"),
                                                      Text("NA"),
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
                                                      Text("Item Name :"),
                                                      Text("${data?.itemName}"),
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
                                                        Text("SKU :"),
                                                        Text("${data?.sku}"),
                                                      ]),
                                                  SizedBox(
                                                    height: height * .01,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text("Unit :"),
                                                        Text("${data?.unit}"),
                                                      ]),
                                                  SizedBox(
                                                    height: height * .01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text("Item Size :"),
                                                      Text("${data?.itemsize}"),
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
                                                      Text("Item Color :"),
                                                      Text(
                                                          "${data?.itemcolor}"),
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
                                                      Text("Purchase Price :"),
                                                      Text(
                                                          "${data?.purchasePrice}"),
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
                                                      Text("MRP :"),
                                                      Text(
                                                          "${data?.mrp}"),
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
                                                      Text("Dis.MRP :"),
                                                      Text(
                                                          "${data?.discount}"),
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
                                                      Text("Sale Price :"),
                                                      Text(
                                                          "${data?.salesPriceWithtax}"),
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
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                // setState(() {
                                                                //   ApiServices()
                                                                //       .DeleteSupplierDetails(
                                                                //       "${data?.}");
                                                                //   setState(() {});
                                                                // });
                                                                Get.to(EditItem(
                                                                  "${data?.itemName}",
                                                                  "${data?.sku}",
                                                                  "${data?.purchasePrice}",
                                                                  "${data?.unit}",
                                                                  "${data?.itemcolor}",
                                                                  "${data?.itemsize}",
                                                                ));
                                                              },
                                                              icon: Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .cyan)),
                                                          IconButton(
                                                              onPressed: () {},
                                                              icon: Icon(
                                                                  Icons.delete,
                                                                  color: Color(
                                                                      0xffAB2328)))
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
                  ]),
                ]))),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: primarycolor,
            onPressed: () {
              Get.to(AddItem(), transition: Transition.rightToLeft);
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
