// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:hawks/constants/color.dart';
// import 'package:hawks/constants/style.dart';
// import 'package:hawks/screens/Sales/customer_cr_dr.dart';
// import 'package:hawks/screens/Sales/saleReturn_Details.dart';
// import 'package:hawks/screens/Sales/sale_order/sale_order_details.dart';
// import 'package:hawks/screens/Sales/sales_details.dart';
// import 'package:hawks/screens/Sales/sales_return.dart';
// import 'package:hawks/screens/customer/customer_details.dart';
// import 'package:hawks/screens/dashboard.dart';
// import 'package:hawks/screens/item/item_color_details.dart';
// import 'package:hawks/screens/item/item_details.dart';
// import 'package:hawks/screens/item/item_size_details.dart';
// import 'package:hawks/screens/purchase/create_purchase.dart';
// import 'package:hawks/screens/purchase/prchase_order/purchase_order_details.dart';
// import 'package:hawks/screens/purchase/purchase_details.dart';
// import 'package:hawks/screens/purchase/purchase_return/purchase_return_details.dart';
// import 'package:hawks/screens/purchase/supllier_cr_dr.dart';
// import 'package:hawks/screens/reports/invoice_report.dart';
// import 'package:hawks/screens/sales_screen.dart';
// import 'package:hawks/screens/supplier/supllier_details.dart';
//
// class DrawerList extends StatefulWidget {
//   const DrawerList({Key? key}) : super(key: key);
//
//   @override
//   State<DrawerList> createState() => _DrawerListState();
// }
//
// class _DrawerListState extends State<DrawerList> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primarycolor,
//         centerTitle: true,
//         title: const Text('SALES'),
//         leading: CupertinoButton(
//             onPressed: () {
//               Get.to(SalesScreen(),
//                   duration: Duration(milliseconds: 300),
//                   transition: Transition.rightToLeft);
//             },
//             child: const Icon(
//               CupertinoIcons.clear,
//               color: Colors.white,
//             )),
//         actions: [
//           CupertinoButton(
//               onPressed: () {
//                 Get.to(SalesScreen(),
//                     duration: Duration(milliseconds: 300),
//                     transition: Transition.rightToLeft);
//               },
//               child: const Icon(
//                 CupertinoIcons.home,
//                 color: Colors.white,
//               )),
//         ],
//       ),
//       body: SingleChildScrollView(
//           child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Column(children: [
//                 SizedBox(
//                   height: height * .02,
//                 ),
//                 ListTile(
//                   leading: const Icon(
//                     Icons.dashboard,
//                     color: primarycolor,
//                   ),
//                   title: Text(
//                     'Dashboard',
//                     style: subheadline3,
//                   ),
//                   onTap: () {
//                     Get.to(Dashboard(),
//                         duration: Duration(milliseconds: 300),
//                         transition: Transition.rightToLeft);
//                   },
//                 ),
//                 ExpansionPanelList.radio(
//                     elevation: 0,
//                     animationDuration: const Duration(milliseconds: 600),
//                     children: [
//                       ExpansionPanelRadio(
//                           value: 1,
//                           headerBuilder: (_, isExpanded) => Container(
//                                   child: ListTile(
//                                 leading: const Icon(
//                                   Icons.settings,
//                                   color: primarycolor,
//                                 ),
//                                 title: Text(
//                                   "Setting",
//                                   style: subheadline3,
//                                 ),
//                                 subtitle: Text(
//                                   "Manage Company, Invoice",
//                                   style: subheadline2,
//                                 ),
//                               )),
//                           body: Column(children: [
//                             InkWell(
//                               onTap: () {
//                                 // Get.to(CustomerDetails(),
//                                 //     duration: Duration(
//                                 //         milliseconds:
//                                 //             500), //duration of transitions, default 1 sec
//                                 //     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Manage Company',
//                                   Icons.arrow_back_ios_new_sharp),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 // Get.to(CustomerDetails(),
//                                 //     duration: Duration(
//                                 //         milliseconds:
//                                 //             500), //duration of transitions, default 1 sec
//                                 //     transition: Transition.rightToLeft);
//                               },
//                               child: _tile(
//                                   'Manage Invoice', Icons.dashboard_customize),
//                             ),
//                           ]))
//                     ]),
//                 ExpansionPanelList.radio(
//                     elevation: 0,
//                     animationDuration: const Duration(milliseconds: 600),
//                     children: [
//                       ExpansionPanelRadio(
//                           value: 1,
//                           headerBuilder: (_, isExpanded) => Container(
//                                   child: ListTile(
//                                 leading: const Icon(
//                                   Icons.point_of_sale,
//                                   color: primarycolor,
//                                 ),
//                                 title: Text(
//                                   "Master",
//                                   style: subheadline3,
//                                 ),
//                                 subtitle: Text(
//                                   "Create Party, Customer",
//                                   style: subheadline2,
//                                 ),
//                               )),
//                           body: Container(
//                               child: Column(children: [
//                             InkWell(
//                               onTap: () {
//                                 Get.to(SupplierDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Create Supplier', Icons.create),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.to(CustomerDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile(
//                                   'Create Customer', Icons.dashboard_customize),
//                             ),
//                             ExpansionPanelList.radio(
//                                 elevation: 0,
//                                 animationDuration:
//                                     const Duration(milliseconds: 600),
//                                 children: [
//                                   ExpansionPanelRadio(
//                                       value: 1,
//                                       headerBuilder: (_, isExpanded) =>
//                                           Container(
//                                               child: ListTile(
//                                             leading: const Icon(
//                                               Icons.insert_invitation_outlined,
//                                               color: primarycolor,
//                                             ),
//                                             title: Text(
//                                               "Item",
//                                               style: subheadline2,
//                                             ),
//                                             subtitle: Text(
//                                               "Create Item,Size",
//                                               style: subheadline2,
//                                             ),
//                                           )),
//                                       body: Container(
//                                           child: Column(children: [
//                                         InkWell(
//                                           onTap: () {
//                                             Get.to(ItemDetails(),
//                                                 duration:
//                                                     Duration(milliseconds: 300),
//                                                 transition:
//                                                     Transition.rightToLeft);
//                                           },
//                                           child: _tile(
//                                               'Create Item', Icons.create),
//                                         ),
//                                         // InkWell(
//                                         //   onTap: () {
//                                         //     // Get.to(CustomerDetails(),
//                                         //     //     duration: Duration(
//                                         //     //         milliseconds:
//                                         //     //             500), //duration of transitions, default 1 sec
//                                         //     //     transition: Transition.rightToLeft);
//                                         //   },
//                                         //   child: _tile('Create Category/Group',
//                                         //       Icons.create),
//                                         // ),
//                                         InkWell(
//                                           onTap: () {
//                                             // Get.to(CustomerDetails(),
//                                             //     duration: Duration(
//                                             //         milliseconds:
//                                             //             500), //duration of transitions, default 1 sec
//                                             //     transition: Transition.rightToLeft);
//                                           },
//                                           child: _tile('Create Unit',
//                                               Icons.dashboard_customize),
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             Get.to(ItemSize(),
//                                                 duration:
//                                                     Duration(milliseconds: 300),
//                                                 transition:
//                                                     Transition.rightToLeft);
//                                           },
//                                           child: _tile('Create Size',
//                                               Icons.dashboard_customize),
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             Get.to(ItemColor(),
//                                                 duration:
//                                                     Duration(milliseconds: 300),
//                                                 transition:
//                                                     Transition.rightToLeft);
//                                           },
//                                           child: _tile('Create Color',
//                                               Icons.dashboard_customize),
//                                         ),
//                                       ])))
//                                 ]),
//                             // InkWell(
//                             //   onTap: () {
//                             //     Get.to(ItemDetails(),
//                             //         transition: Transition.rightToLeft);
//                             //   },
//                             //   child: _tile('Create Item', Icons.insert_invitation),
//                             // ),
//                           ])))
//                     ]),
//                 ExpansionPanelList.radio(
//                     elevation: 0,
//                     animationDuration: const Duration(milliseconds: 600),
//                     children: [
//                       ExpansionPanelRadio(
//                           value: 1,
//                           headerBuilder: (_, isExpanded) => Container(
//                                   child: ListTile(
//                                 leading: const Icon(
//                                   Icons.point_of_sale,
//                                   color: primarycolor,
//                                 ),
//                                 title: Text(
//                                   "Sale",
//                                   style: subheadline3,
//                                 ),
//                                 subtitle: Text(
//                                   "Sale, Sale Returns",
//                                   style: subheadline2,
//                                 ),
//                               )),
//                           body: Container(
//                               child: Column(children: [
//                             InkWell(
//                               onTap: () {
//                                 Get.to(SalesDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Create Sale', Icons.create),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.to(SalesReturnDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile(
//                                   'Sale Return', Icons.dashboard_customize),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.to(SalesOrderDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Sale Order', Icons.group),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.to(CustomerCrDr(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Customer Cr/Dr', Icons.group),
//                             ),
//                           ])))
//                     ]),
//                 ExpansionPanelList.radio(
//                     elevation: 0,
//                     animationDuration: const Duration(milliseconds: 600),
//                     children: [
//                       ExpansionPanelRadio(
//                           value: 1,
//                           headerBuilder: (_, isExpanded) => Container(
//                                   child: ListTile(
//                                 leading: const Icon(
//                                   Icons.point_of_sale,
//                                   color: primarycolor,
//                                 ),
//                                 title: Text(
//                                   "Purchase",
//                                   style: subheadline3,
//                                 ),
//                                 subtitle: Text(
//                                   "Purchase, Purchase Returns",
//                                   style: subheadline2,
//                                 ),
//                               )),
//                           body: Container(
//                               child: Column(children: [
//                             InkWell(
//                               onTap: () {
//                                 Get.to(PurchaseDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Create Purchase', Icons.create),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.to(PurchaseReturnDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile(
//                                   'Purchase Return', Icons.dashboard_customize),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.to(PurchaseOrderDetails(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Purchase Order', Icons.group),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 Get.to(SupplierCRDR(),
//                                     duration: Duration(milliseconds: 300),
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Supplier CR/DR', Icons.group),
//                             ),
//                           ])))
//                     ]),
//                 // ListTile(
//                 //   leading: const Icon(Icons.party_mode),
//                 //   title: const Text('Party Cr/Dr'),
//                 //   onTap: () {},
//                 // ),
//                 ExpansionPanelList.radio(
//                     elevation: 0,
//                     animationDuration: const Duration(milliseconds: 600),
//                     children: [
//                       ExpansionPanelRadio(
//                           value: 1,
//                           headerBuilder: (_, isExpanded) => Container(
//                                   child: ListTile(
//                                 leading: const Icon(
//                                   Icons.report,
//                                   color: primarycolor,
//                                 ),
//                                 title: Text(
//                                   "Report",
//                                   style: subheadline3,
//                                 ),
//                                 subtitle: Text(
//                                   "Invoice, Stock, Purchase",
//                                   style: subheadline2,
//                                 ),
//                               )),
//                           body: Container(
//                               child: Column(children: [
//                             InkWell(
//                               onTap: () {
//                                 Get.to(InvoiceReport(),
//                                     duration: Duration(
//                                         milliseconds:
//                                             300), //duration of transitions, default 1 sec
//                                     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Invoice', Icons.inventory_outlined),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 // Get.to(CustomerDetails(),
//                                 //     duration: Duration(
//                                 //         milliseconds:
//                                 //             500), //duration of transitions, default 1 sec
//                                 //     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Stock', Icons.price_change),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 // Get.to(SupplierDetails(),
//                                 //     duration: Duration(
//                                 //         milliseconds:
//                                 //             500), //duration of transitions, default 1 sec
//                                 //     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Purchase', Icons.group),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 // Get.to(SupplierDetails(),
//                                 //     duration: Duration(
//                                 //         milliseconds:
//                                 //             500), //duration of transitions, default 1 sec
//                                 //     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Sale', Icons.ac_unit),
//                             ),
//                             InkWell(
//                               onTap: () {
//                                 // Get.to(SupplierDetails(),
//                                 //     duration: Duration(
//                                 //         milliseconds:
//                                 //             500), //duration of transitions, default 1 sec
//                                 //     transition: Transition.rightToLeft);
//                               },
//                               child: _tile('Ledger', Icons.format_size),
//                             ),
//                           ]))),
//                     ]),
//                 ListTile(
//                   leading: const Icon(
//                     Icons.payment,
//                     color: primarycolor,
//                   ),
//                   title: const Text('Hold Bills'),
//                   onTap: () {},
//                 ),
//                 SizedBox(
//                   height: height * .10,
//                 ),
//                 Image(
//                   image: AssetImage("assets/images/help.png"),
//                   height: height * .10,
//                   width: width * .20,
//                   // color: Colors.teal,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '📞  +91-1010999999',
//                       style: subheadline3,
//                     ),
//                     SizedBox(
//                       height: height * .01,
//                     ),
//                     Text(
//                       "✉  support@thehawks.com",
//                       style: subheadline3,
//                     )
//                   ],
//                 ),
//                 // ListTile(
//                 //   leading: Image(image: AssetImage("assets/images/help.png"),
//                 //     height:height * .05,
//                 //   ),
//                 //   title: const Text('📞 +91-7428302221 \n ✉ support@smartcapita.com'),
//                 //   onTap: () {},
//                 // )
//               ]))),
//     );
//   }
//
//   Container _tile(String title, IconData icon) {
//     return Container(
//         child: ListTile(
//       title: Text(
//         title,
//         style: subheadline2,
//       ),
//       leading: Icon(
//         Icons.arrow_back_ios_new_sharp,
//         size: 20,
//         color: lightblackcolor,
//       ),
//     ));
//   }
// }
