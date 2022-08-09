// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:hawks/constants/color.dart';
// import 'package:hawks/screens/Sales/create_salereturn.dart';
// import 'package:hawks/screens/item/add_item_form.dart';
// import 'package:hawks/screens/supplier/supplier_form.dart';
// import 'package:intl/intl.dart';
// import '../../../constants/style.dart';
// import 'create_purchase_order.dart';
//
//
// class PurchaseOrderDetails extends StatefulWidget {
//   const PurchaseOrderDetails({Key? key}) : super(key: key);
//
//   @override
//   State<PurchaseOrderDetails> createState() => _PurchaseOrderDetailsState();
// }
//
// class _PurchaseOrderDetailsState extends State<PurchaseOrderDetails> {
//
//   final TextEditingController _search = TextEditingController();
//   String? dropdownvalue;
//   String? itemnamedropdownvalue;
//   String? unitdropdown;
//   String? itemcolordropdown;
//   String? itemsizedropdown;
//   var supplier = [
//     'Item1',
//     'Item2',
//     'Item3',
//     'Item4',
//   ];
//
//   var items = [
//     '123424325saf',
//     'qe1424355455',
//   ];
//
//   var unit = [
//     'PCS',
//   ];
//
//   var itemColor = ['CHARCOAL BLACK'];
//
//   var itemsize = ['S', 'XS', 'M', 'XM', 'L', 'XL'];
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: primarycolor,
//           title: Text("Purchase Order Details"),
//         ),
//         body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             child: SingleChildScrollView(
//                 child: Column(children: [
//                   SizedBox(
//                     height: height * .02,
//                   ),
//                   Column(
//                     children: [
//                       SizedBox(
//                         height: height * .02,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               width: width * .38,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                       color: lightblackcolor,
//                                       width: 1.0,
//                                     ),
//                                   )),
//                               child: TextField(
//                                 cursorColor: lightblackcolor,
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 10,
//                                   ),
//                                   hintText: "SKU/Barcode",
//                                   hintStyle: subheadline,
//                                   border: InputBorder.none,
//                                 ),
//                               )),
//                           Container(
//                             width: width * .38,
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                   bottom: BorderSide(
//                                     color: lightblackcolor,
//                                     width: 1.0,
//                                   ),
//                                 )),
//                             child: DropdownButton(
//                               isExpanded: true,
//                               underline: Container(),
//                               hint: Text(
//                                 "Select Item",
//                                 style: subheadline,
//                               ),
//                               value: itemnamedropdownvalue,
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                               items: items.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   itemnamedropdownvalue = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                           Container(
//                               width: width * .10,
//                               height: height * .05,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.lightBlueAccent),
//                               child: IconButton(
//                                 onPressed: () {
//                                   Get.to(AddItem(),
//                                       transition: Transition.rightToLeft);
//                                 },
//                                 icon: Icon(
//                                   Icons.add,
//                                   color: Colors.white,
//                                 ),
//                                 iconSize: 20,
//                               ))
//                         ],
//                       ),
//                       SizedBox(
//                         height: height * .02,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: width * .45,
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                   bottom: BorderSide(
//                                     color: lightblackcolor,
//                                     width: 1.0,
//                                   ),
//                                 )),
//                             child: DropdownButton(
//                               isExpanded: true,
//                               underline: Container(),
//                               hint: Text(
//                                 "Select Unit",
//                                 style: subheadline,
//                               ),
//                               value: unitdropdown,
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                               items: unit.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   unitdropdown = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                           Container(
//                             width: width * .45,
//                             decoration: const BoxDecoration(
//                                 border: Border(
//                                   bottom: BorderSide(
//                                     color: lightblackcolor,
//                                     width: 1.0,
//                                   ),
//                                 )),
//                             child: DropdownButton(
//                               isExpanded: true,
//                               underline: Container(),
//                               hint: Text(
//                                 "Alt. Unit",
//                                 style: subheadline,
//                               ),
//                               value: unitdropdown,
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                               items: unit.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Text(items),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   unitdropdown = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height * .02,
//                       ),
//                       Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: width * .45,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                       color: lightblackcolor,
//                                       width: 1.0,
//                                     ),
//                                   )),
//                               child: DropdownButton(
//                                 isExpanded: true,
//                                 underline: Container(),
//                                 hint: Text(
//                                   "Select Color",
//                                   style: subheadline,
//                                 ),
//                                 value: itemcolordropdown,
//                                 icon: const Icon(Icons.keyboard_arrow_down),
//                                 items: itemColor.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     itemcolordropdown = newValue!;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Container(
//                               width: width * .45,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                       color: lightblackcolor,
//                                       width: 1.0,
//                                     ),
//                                   )),
//                               child: DropdownButton(
//                                 isExpanded: true,
//                                 underline: Container(),
//                                 hint: Text(
//                                   "Select Size",
//                                   style: subheadline,
//                                 ),
//                                 value: itemsizedropdown,
//                                 icon: const Icon(Icons.keyboard_arrow_down),
//                                 items: itemsize.map((String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(items),
//                                   );
//                                 }).toList(),
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     itemsizedropdown = newValue!;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ]),
//                       SizedBox(
//                         height: height * .02,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               width: width * .45,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                       color: lightblackcolor,
//                                       width: 1.0,
//                                     ),
//                                   )),
//                               child: TextField(
//                                 cursorColor: lightblackcolor,
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 10,
//                                   ),
//                                   hintText: "Stock",
//                                   hintStyle: subheadline,
//                                   border: InputBorder.none,
//                                 ),
//                               )),
//                           Container(
//                               width: width * .45,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                       color: lightblackcolor,
//                                       width: 1.0,
//                                     ),
//                                   )),
//                               child: TextField(
//                                 cursorColor: lightblackcolor,
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 10,
//                                   ),
//                                   hintText: "Qty",
//                                   hintStyle: subheadline,
//                                   border: InputBorder.none,
//                                 ),
//                               )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height * .02,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               width: width * .45,
//                               decoration: const BoxDecoration(
//                                   border: Border(
//                                     bottom: BorderSide(
//                                       color: lightblackcolor,
//                                       width: 1.0,
//                                     ),
//                                   )),
//                               child: TextField(
//                                 cursorColor: lightblackcolor,
//                                 decoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.only(
//                                     left: 10,
//                                   ),
//                                   hintText: "Price",
//                                   hintStyle: subheadline,
//                                   border: InputBorder.none,
//                                 ),
//                               )),
//                           Container(
//                               width: width * .10,
//                               height: height * .05,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: Colors.lightBlueAccent),
//                               child: IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   Icons.add,
//                                   color: Colors.white,
//                                 ),
//                                 iconSize: 20,
//                               ))
//                         ],
//                       ),
//                       SizedBox(
//                         height: height * .02,
//                       ),
//                       Divider(
//                         thickness: 2,
//                       ),
//                       SizedBox(
//                         height: height * .02,
//                       ),
//                       ListView.builder(
//                           itemCount: 5,
//                           shrinkWrap: true,
//                           physics: BouncingScrollPhysics(),
//                           scrollDirection: Axis.vertical,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Card(
//                                 elevation: 2,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 shadowColor: primarycolor,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(10),
//                                   child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("SN :"),
//                                             Text("${index + 1}")
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         // Row(
//                                         //   mainAxisAlignment:
//                                         //       MainAxisAlignment.spaceBetween,
//                                         //   children: [
//                                         //     Text("Return No :"),
//                                         //     Expanded(child: Text("NA")),
//                                         //   ],
//                                         // ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Item Name :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Unit :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Item Color :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Item Size :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Current Stock :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Item Code :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Qty :"),
//                                             Container(
//                                                 width: width * .10,
//                                                 alignment: Alignment.center,
//                                                 child: TextFormField(
//                                                   initialValue: "NA",
//                                                   decoration: InputDecoration(
//                                                       contentPadding:
//                                                       EdgeInsets.only(
//                                                           left: 20)),
//                                                 ))
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Our Price :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("MRP :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Delivery Date :"),
//                                             Text("NA"),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text("Action"),
//                                             IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(Icons.delete,
//                                                     color: Color(0xffAB2328)))
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: height * .01,
//                                         ),
//                                       ]),
//                                 ));
//                           }),
//                     ],
//                   ),
//                   SizedBox(
//                     height: height * .04,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                           width: width * .30,
//                           child: CupertinoButton(
//                             onPressed: () {
//                               // _formKey.currentState?.validate();
//                               // Get.to(SupplierDetails(),
//                               //     duration: Duration(milliseconds: 500),
//                               //     transition: Transition.rightToLeft);
//                             },
//                             child: Text("Update"),
//                             color: primarycolor,
//                             padding: EdgeInsets.only(left: 10, right: 10),
//                             pressedOpacity: 0.6,
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                           )),
//                       Container(
//                           width: width * .30,
//                           child: CupertinoButton(
//                             onPressed: () {},
//                             child: Text("Cancle"),
//                             color: lightblackcolor,
//                             padding: EdgeInsets.only(left: 10, right: 10),
//                             pressedOpacity: 0.6,
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                           ))
//                     ],
//                   ),
//                   SizedBox(
//                     height: height * .04,
//                   ),
//                 ]))),
//         floatingActionButtonLocation:
//         FloatingActionButtonLocation.miniEndDocked,
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: FloatingActionButton(
//             backgroundColor: primarycolor,
//             onPressed: () {
//               Get.to(CreatePurchaseOrder(),
//                   transition: Transition.rightToLeft);
//             },
//             child: Icon(Icons.add),
//           ),
//         ));
//   }
// }
