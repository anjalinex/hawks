import 'package:flutter/material.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/constants/style.dart';
import 'package:hawks/drawerlist.dart';
import 'package:hawks/screens/accounts/account.dart';
import 'package:hawks/screens/accounts/account_group_list.dart';
import 'package:hawks/screens/customer/customer_details.dart';
import 'package:hawks/screens/customer/customer_form.dart';
import 'package:hawks/screens/item/item_details.dart';
import 'package:hawks/screens/loginpage.dart';
import 'package:get/get.dart';
import 'package:hawks/screens/purchase/prchase_order/purchase_order.dart';
import 'package:hawks/screens/purchase/prchase_order/purchase_order_details.dart';
import 'package:hawks/screens/purchase/purchase.dart';
import 'package:hawks/screens/purchase/purchase_details.dart';
import 'package:hawks/screens/purchase/purchase_return/purchase_return_details.dart';
import 'package:hawks/screens/purchase/supllier_cr_dr.dart';
import 'package:hawks/screens/reports/invoice_report.dart';
import 'package:hawks/screens/settings/invoice_setting.dart';
import 'package:hawks/screens/settings/manage_setting.dart';
import 'package:hawks/screens/supplier/supllier_details.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'Sales/customer_cr_dr.dart';
import 'Sales/sale.dart';
import 'Sales/saleReturn_Details.dart';
import 'Sales/sale_order/sale_order.dart';
import 'Sales/sale_order/sale_order_details.dart';
import 'Sales/sales_details.dart';
import 'dashboard.dart';
import 'item/add_item_form.dart';
import 'item/item_color_details.dart';
import 'item/item_size_details.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController itemName = TextEditingController();
  String? dropdownvalue;
  String? dropdownvalue1;
  String? marterDropdown;
  String reportDropdown = '';
  bool _barcodeVisible = false;
  bool _error = false;
  var items = [
    'direct',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var items1 = [
    'main',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var masters = [
    'Item',
    'Customer',
    'Supplier',
    'Sale Person',
  ];

  var reports = [
    'Invoice Report',
    'Stock',
    'Purchase',
    'Sale',
    'Ledger',
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          title: const Text("SALES"),
          centerTitle: true,
          // leading: IconButton(
          //   onPressed: () {
          //     Get.to(DrawerList());
          //   },
          //   icon: Icon(Icons.menu),
          // ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
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
                        labelText: "Mobile Number",
                        labelStyle: subheadline,
                        hintText: "Mobile Number",
                        hintStyle: subheadline,
                        border: InputBorder.none,
                      ),
                    )),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_box_outlined)),
                    Text(
                      "Add Customer Detail",
                      style: subheadline3,
                    )
                  ],
                ),
                Text(
                  "Select Sale Type",
                  style: subheadline2,
                ),
                DropdownButton(
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
                Text(
                  "Select Item Center",
                  style: subheadline2,
                ),
                DropdownButton(
                  isExpanded: true,
                  underline: Container(
                    color: Colors.white,
                  ),
                  value: dropdownvalue1,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items1.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue1 = newValue!;
                    });
                  },
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      obscureText: _barcodeVisible,
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        labelText: "Barcode/SKU",
                        labelStyle: subheadline,
                        hintText: "Barcode/SKU",
                        hintStyle: subheadline,
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _barcodeVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: lightblackcolor,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _barcodeVisible = !_barcodeVisible;
                            });
                          },
                        ),
                      ),
                    )),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                        controller: itemName,
                        cursorColor: lightblackcolor,
                        decoration: InputDecoration(
                          labelText: "Item Name",
                          labelStyle: subheadline,
                          hintText: "Item Name",
                          hintStyle: subheadline,
                          border: InputBorder.none,
                          suffixIcon: itemName.text.isEmpty
                              ? const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                )
                              : null,
                        ))),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        //                   <--- left side
                        color: lightblackcolor,
                        width: 1.0,
                      ),
                    )),
                    child: TextField(
                      cursorColor: lightblackcolor,
                      decoration: InputDecoration(
                        labelText: "Unit",
                        labelStyle: subheadline,
                        hintText: "Unit",
                        hintStyle: subheadline,
                        border: InputBorder.none,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: width * .45,
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
                            labelText: "Color",
                            labelStyle: subheadline,
                            hintText: "Color",
                            hintStyle: subheadline,
                            border: InputBorder.none,
                          ),
                        )),
                    Container(
                        width: width * .45,
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
                            labelText: "Size",
                            labelStyle: subheadline,
                            hintText: "Size",
                            hintStyle: subheadline,
                            border: InputBorder.none,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: width * .45,
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
                            labelText: "Qty",
                            labelStyle: subheadline,
                            hintText: "Qyt",
                            hintStyle: subheadline,
                            border: InputBorder.none,
                          ),
                        )),
                    Container(
                        width: width * .45,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: TextField(
                          cursorColor: lightblackcolor,
                          decoration: InputDecoration(
                            labelText: "Our Price",
                            labelStyle: subheadline,
                            hintText: "Our Price",
                            hintStyle: subheadline,
                            border: InputBorder.none,
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: width * .45,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: TextField(
                          cursorColor: lightblackcolor,
                          decoration: InputDecoration(
                            labelText: "Discount(%)",
                            labelStyle: subheadline,
                            hintText: "Discount(%)",
                            hintStyle: subheadline,
                            border: InputBorder.none,
                          ),
                        )),
                    Container(
                        width: width * .45,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                            color: lightblackcolor,
                            width: 1.0,
                          ),
                        )),
                        child: TextField(
                          cursorColor: lightblackcolor,
                          decoration: InputDecoration(
                            labelText: "Discount(₹)",
                            labelStyle: subheadline,
                            hintText: "Size",
                            hintStyle: subheadline,
                            border: InputBorder.none,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: primarycolor),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                          iconSize: 35,
                        )),
                    SizedBox(
                      width: width * .02,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: primarycolor),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          iconSize: 35,
                        ))
                  ],
                ),
                SizedBox(
                  height: height * .04,
                ),
              ],
            )),
        drawer: Drawer(
          child: Container(
            child: ListView(children: <Widget>[
              SizedBox(
                height: height * .02,
              ),
              SizedBox(
                  height: height * .18,
                  child: Container(
                    color: primarycolor,
                    child: DrawerHeader(
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.all(0.0),
                      child: Image(
                        image: AssetImage("assets/images/HAWKS.jpg"),
                        height: height * .10,
                        width: width * .20,
                      ),
                    ),
                  )),
              // Image(
              //   image: AssetImage("assets/images/HAWKS.jpg"),
              //   height: height * .10,
              //   width: width * .20,
              // ),
              ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: primarycolor,
                ),
                title: const Text('Dashboard'),
                onTap: () {
                  Get.to(Dashboard(),
                      duration: Duration(milliseconds: 300),
                      transition: Transition.rightToLeft);
                },
              ),
              ExpansionPanelList.radio(
                  elevation: 0,
                  animationDuration: const Duration(milliseconds: 600),
                  children: [
                    ExpansionPanelRadio(
                        value: 1,
                        headerBuilder: (_, isExpanded) => Container(
                                child: ListTile(
                              leading: const Icon(
                                Icons.settings,
                                color: primarycolor,
                              ),
                              title: Text(
                                "Setting",
                                style: subheadline3,
                              ),
                            )),
                        body: Column(children: [
                          InkWell(
                            onTap: () {
                              Get.to(ManageSetting(),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Manage Company',
                                Icons.arrow_back_ios_new_sharp),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(InvoiceSetting(),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile(
                                'Manage Invoice', Icons.dashboard_customize),
                          ),
                        ]))
                  ]),
              ExpansionPanelList.radio(
                  elevation: 0,
                  animationDuration: const Duration(milliseconds: 600),
                  children: [
                    ExpansionPanelRadio(
                        value: 1,
                        headerBuilder: (_, isExpanded) => Container(
                                child: ListTile(
                              leading: const Icon(
                                Icons.point_of_sale,
                                color: primarycolor,
                              ),
                              title: Text(
                                "Master",
                                style: subheadline3,
                              ),
                            )),
                        body: Container(
                            child: Column(children: [
                          InkWell(
                            onTap: () {
                              Get.to(SupplierDetails(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Create Supplier', Icons.create),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(CustomerDetails(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile(
                                'Create Customer', Icons.dashboard_customize),
                          ),
                          ExpansionPanelList.radio(
                              elevation: 0,
                              animationDuration:
                                  const Duration(milliseconds: 600),
                              children: [
                                ExpansionPanelRadio(
                                    value: 1,
                                    headerBuilder: (_, isExpanded) => Container(
                                            child: ListTile(
                                          leading: const Icon(
                                            Icons.arrow_back_ios_new_sharp,
                                            color: primarycolor,
                                            size: 15,
                                          ),
                                          title: Text(
                                            "Item",
                                            style: subheadline4,
                                          ),
                                        )),
                                    body: Container(
                                        child: Column(children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(ItemDetails(),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child:
                                            _tile('Create Item', Icons.create),
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     // Get.to(CustomerDetails(),
                                      //     //     duration: Duration(
                                      //     //         milliseconds:
                                      //     //             500), //duration of transitions, default 1 sec
                                      //     //     transition: Transition.rightToLeft);
                                      //   },
                                      //   child: _tile('Create Category/Group',
                                      //       Icons.create),
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          // Get.to(CustomerDetails(),
                                          //     duration: Duration(
                                          //         milliseconds:
                                          //             500), //duration of transitions, default 1 sec
                                          //     transition: Transition.rightToLeft);
                                        },
                                        child: _tile('Create Unit',
                                            Icons.dashboard_customize),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(ItemSize(),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: _tile('Create Size',
                                            Icons.dashboard_customize),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(ItemColor(),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: _tile('Create Color',
                                            Icons.dashboard_customize),
                                      ),
                                    ])))
                              ]),
                          // InkWell(
                          //   onTap: () {
                          //     Get.to(ItemDetails(),
                          //         transition: Transition.rightToLeft);
                          //   },
                          //   child: _tile('Create Item', Icons.insert_invitation),
                          // ),
                        ])))
                  ]),
              ExpansionPanelList.radio(
                  elevation: 0,
                  animationDuration: const Duration(milliseconds: 600),
                  children: [
                    ExpansionPanelRadio(
                        value: 1,
                        headerBuilder: (_, isExpanded) => Container(
                                child: ListTile(
                              leading: const Icon(
                                Icons.point_of_sale,
                                color: primarycolor,
                              ),
                              title: Text(
                                "Sale",
                                style: subheadline3,
                              ),
                            )),
                        body: Container(
                            child: Column(children: [
                          InkWell(
                            onTap: () {
                              Get.to(Sale(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Create Sale', Icons.create),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(SalesOrder(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Sale Order', Icons.group),
                          ),
                              InkWell(
                                onTap: () {
                                  Get.to(SalesReturnDetails(),
                                      duration: Duration(milliseconds: 300),
                                      transition: Transition.rightToLeft);
                                },
                                child:
                                _tile('Sale Return', Icons.dashboard_customize),
                              ),
                          InkWell(
                            onTap: () {
                              Get.to(CustomerCrDr(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Customer Cr/Dr', Icons.group),
                          ),
                        ])))
                  ]),
              ExpansionPanelList.radio(
                  elevation: 0,
                  animationDuration: const Duration(milliseconds: 600),
                  children: [
                    ExpansionPanelRadio(
                        value: 1,
                        headerBuilder: (_, isExpanded) => Container(
                                child: ListTile(
                              leading: const Icon(
                                Icons.point_of_sale,
                                color: primarycolor,
                              ),
                              title: Text(
                                "Purchase",
                                style: subheadline3,
                              ),
                            )),
                        body: Container(
                            child: Column(children: [
                          InkWell(
                            onTap: () {
                              Get.to(Purchase(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Create Purchase', Icons.create),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(PurchaseOrder(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Purchase Order', Icons.group),
                          ),
                              InkWell(
                                onTap: () {
                                  Get.to(PurchaseReturnDetails(),
                                      duration: Duration(milliseconds: 300),
                                      transition: Transition.rightToLeft);
                                },
                                child: _tile(
                                    'Purchase Return', Icons.dashboard_customize),
                              ),
                          InkWell(
                            onTap: () {
                              Get.to(SupplierCRDR(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Supplier CR/DR', Icons.group),
                          ),
                        ])))
                  ]),
              // ListTile(
              //   leading: const Icon(Icons.party_mode),
              //   title: const Text('Party Cr/Dr'),
              //   onTap: () {},
              // ),

              ExpansionPanelList.radio(
                  elevation: 0,
                  animationDuration: const Duration(milliseconds: 600),
                  children: [
                    ExpansionPanelRadio(
                        value: 1,
                        headerBuilder: (_, isExpanded) => Container(
                                child: ListTile(
                              leading: const Icon(
                                Icons.account_balance,
                                color: primarycolor,
                              ),
                              title: Text(
                                "Account",
                                style: subheadline3,
                              ),
                            )),
                        body: Container(
                            child: Column(children: [
                          ExpansionPanelList.radio(
                              elevation: 0,
                              animationDuration:
                                  const Duration(milliseconds: 600),
                              children: [
                                ExpansionPanelRadio(
                                    value: 1,
                                    headerBuilder: (_, isExpanded) => Container(
                                            child: ListTile(
                                          leading: const Icon(
                                            Icons.account_balance,
                                            color: primarycolor,
                                          ),
                                          title: Text(
                                            "Account Master",
                                            style: subheadline4,
                                          ),
                                        )),
                                    body: Container(
                                        child: Column(children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(Account(),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: _tile('Account', Icons.create),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(AccountGroupList(),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: _tile('Account Group',
                                            Icons.dashboard_customize),
                                      ),
                                    ])))
                              ]),
                          ExpansionPanelList.radio(
                              elevation: 0,
                              animationDuration:
                                  const Duration(milliseconds: 600),
                              children: [
                                ExpansionPanelRadio(
                                    value: 1,
                                    headerBuilder: (_, isExpanded) => Container(
                                            child: ListTile(
                                          leading: const Icon(
                                            Icons.insert_invitation_outlined,
                                            color: primarycolor,
                                          ),
                                          title: Text(
                                            "Journal",
                                            style: subheadline4,
                                          ),
                                        )),
                                    body: Container(
                                        child: Column(children: [
                                      InkWell(
                                        onTap: () {
                                          Get.to(ItemDetails(),
                                              duration:
                                                  Duration(milliseconds: 300),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: _tile(
                                            'Journal Entry', Icons.create),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Get.to(CustomerDetails(),
                                          //     duration: Duration(
                                          //         milliseconds:
                                          //             500), //duration of transitions, default 1 sec
                                          //     transition: Transition.rightToLeft);
                                        },
                                        child: _tile('Journal Reports',
                                            Icons.dashboard_customize),
                                      ),
                                    ])))
                              ]),
                        ])))
                  ]),
              ExpansionPanelList.radio(
                  elevation: 0,
                  animationDuration: const Duration(milliseconds: 600),
                  children: [
                    ExpansionPanelRadio(
                        value: 1,
                        headerBuilder: (_, isExpanded) => Container(
                                child: ListTile(
                              leading: const Icon(
                                Icons.report,
                                color: primarycolor,
                              ),
                              title: Text(
                                "Report",
                                style: subheadline3,
                              ),
                            )),
                        body: Container(
                            child: Column(children: [
                          InkWell(
                            onTap: () {
                              Get.to(InvoiceReport(),
                                  duration: Duration(
                                      milliseconds:
                                          300), //duration of transitions, default 1 sec
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Invoice', Icons.inventory_outlined),
                          ),
                          InkWell(
                            onTap: () {
                              // Get.to(CustomerDetails(),
                              //     duration: Duration(
                              //         milliseconds:
                              //             500), //duration of transitions, default 1 sec
                              //     transition: Transition.rightToLeft);
                            },
                            child: _tile('Stock', Icons.price_change),
                          ),
                          InkWell(
                            onTap: () {
                              // Get.to(SupplierDetails(),
                              //     duration: Duration(
                              //         milliseconds:
                              //             500), //duration of transitions, default 1 sec
                              //     transition: Transition.rightToLeft);
                            },
                            child: _tile('Purchase', Icons.group),
                          ),
                          InkWell(
                            onTap: () {
                              // Get.to(SupplierDetails(),
                              //     duration: Duration(
                              //         milliseconds:
                              //             500), //duration of transitions, default 1 sec
                              //     transition: Transition.rightToLeft);
                            },
                            child: _tile('Sale', Icons.ac_unit),
                          ),
                          InkWell(
                            onTap: () {
                              // Get.to(SupplierDetails(),
                              //     duration: Duration(
                              //         milliseconds:
                              //             500), //duration of transitions, default 1 sec
                              //     transition: Transition.rightToLeft);
                            },
                            child: _tile('Ledger', Icons.format_size),
                          ),
                        ]))),
                  ]),
              // ListTile(
              //   leading: const Icon(
              //     Icons.payment,
              //     color: primarycolor,
              //   ),
              //   title: const Text('Hold Bills'),
              //   onTap: () {},
              // ),
              SizedBox(
                height: height * .04,
              ),
              Image(
                image: AssetImage("assets/images/help1.png"),
                height: height * .10,
                width: width * .20,
                color: Colors.teal,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '📞  +91-1010999999',
                      style: subheadline3,
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Text(
                      "✉  support@thehawks.com",
                      style: subheadline3,
                    )
                  ],
                ),
                // ListTile(
                //   leading: Image(image: AssetImage("assets/images/help.png"),
                //     height:height * .05,
                //   ),
                //   title: const Text('📞 +91-7428302221 \n ✉ support@smartcapita.com'),
                //   onTap: () {},
                // )
              )
            ]),
          ),
          // drawer: Drawer(
          //   child: ListView(
          //     padding: const EdgeInsets.all(10),
          //     children: [
          //       Padding(
          //           padding: EdgeInsets.only(top: 30, left: 20),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               CircleAvatar(
          //                 backgroundColor: primarycolor,
          //                 radius: 30,
          //                 backgroundImage:
          //                     AssetImage("assets/images/profile_image.png"),
          //                 foregroundColor: Colors.white,
          //               ),
          //               SizedBox(
          //                 width: width * .06,
          //               ),
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Anjali Kumari",
          //                     style: profilenametext,
          //                   ),
          //                   Row(
          //                     children: [
          //                       Text(
          //                         "anjali@gmail.com",
          //                         style: subheadline2,
          //                         textAlign: TextAlign.justify,
          //                       ),
          //                       IconButton(
          //                           onPressed: () {
          //                             Get.to(LoginPage(),
          //                                 duration: Duration(
          //                                     milliseconds:
          //                                         500), //duration of transitions, default 1 sec
          //                                 transition: Transition.leftToRight);
          //                           },
          //                           icon: Image(
          //                               image: AssetImage(
          //                                   "assets/images/logout-rounded-up.jpg")))
          //                     ],
          //                   )
          //                 ],
          //               ),
          //             ],
          //           )),
          //       SizedBox(
          //         height: height * .02,
          //       ),
          //       Divider(
          //         thickness: 2,
          //         color: lightblackcolor,
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.settings),
          //         title: const Text('Settings'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.point_of_sale),
          //         title: Row(children: [
          //           DropdownButton(
          //             underline: Container(),
          //             dropdownColor: Colors.grey.shade300,
          //             hint: Text(
          //               "Master",
          //               style: TextStyle(color: blackcolor),
          //             ),
          //             value: marterDropdown,
          //             icon: const Icon(
          //               Icons.arrow_drop_down_sharp,
          //               size: 20,
          //             ),
          //             items: masters.map((String items) {
          //               return DropdownMenuItem(
          //                 value: items,
          //                 child: Text(items),
          //               );
          //             }).toList(),
          //             onChanged: (String? newValue) {
          //               setState(() {
          //                 marterDropdown = newValue!;
          //                 marterDropdown == "Customer"
          //                     ? Get.to(CustomerDetails(),
          //                         duration: Duration(
          //                             milliseconds:
          //                                 500), //duration of transitions, default 1 sec
          //                         transition: Transition.rightToLeft)
          //                     : marterDropdown == "Supplier"
          //                         ? Get.to(SupplierDetails(),
          //                             duration: Duration(
          //                                 milliseconds:
          //                                     500), //duration of transitions, default 1 sec
          //                             transition: Transition.rightToLeft)
          //                         : marterDropdown == "Item"
          //                             ? Get.to(ItemDetails(),
          //                                 duration: Duration(
          //                                     milliseconds:
          //                                         500), //duration of transitions, default 1 sec
          //                                 transition: Transition.rightToLeft)
          //                             : "";
          //                 // Get.to(LoginPage());
          //               });
          //             },
          //           ),
          //         ]),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.point_of_sale),
          //         title: const Text('Sale'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.point_of_sale),
          //         title: const Text('Sale Returns'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.video_label),
          //         title: const Text('Purchase'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.edit),
          //         title: const Text('Purchase Order'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.edit),
          //         title: const Text('Purchase Returns'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.party_mode),
          //         title: const Text('Party Cr/Dr'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.edit),
          //         title: const Text('Customer Cr/Dr'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.report),
          //         title: const Text('Reports'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //       ListTile(
          //         leading: const Icon(Icons.payment),
          //         title: const Text('Hold Bills'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       )
          //     ],
          //   ),
          // ),

          // MultiLevelDrawer(
          //   backgroundColor: Colors.white,
          //   rippleColor: Colors.white,
          //   subMenuBackgroundColor: Colors.grey.shade100,
          //   divisionColor: Colors.grey,
          //   header: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             SizedBox(
          //               height: height * .06,
          //             ),
          //             const CircleAvatar(
          //               backgroundColor: primarycolor,
          //               radius: 40,
          //               backgroundImage:
          //                   AssetImage("assets/images/profile_image.png"),
          //               foregroundColor: Colors.white,
          //             ),
          //             SizedBox(
          //               width: width * .06,
          //             ),
          //                   Text(
          //                     "Anjali Kumari",
          //                     style: profilenametext,
          //                   ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   "anjali@gmail.com",
          //                   style: subheadline2,
          //                   textAlign: TextAlign.justify,
          //                 ),
          //                 IconButton(
          //                     onPressed: () {
          //                       Get.to(LoginPage(),
          //                           duration: Duration(
          //                               milliseconds:
          //                                   500), //duration of transitions, default 1 sec
          //                           transition: Transition.leftToRight);
          //                     },
          //                     icon: Image(
          //                         image: AssetImage(
          //                             "assets/images/logout-rounded-up.jpg")))
          //               ],
          //             )
          //           ],
          //         ),
          //   children: [
          //     MLMenuItem(
          //         leading: Icon(Icons.settings),
          //         content: Text(
          //           "   Settings",
          //         ),
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.settings),
          //         trailing: Icon(Icons.arrow_right),
          //         content: Text("  Master"),
          //         onClick: () {},
          //         subMenuItems: [
          //           MLSubmenu(onClick: () {}, submenuContent: Text("Option 1")),
          //           MLSubmenu(onClick: () {}, submenuContent: Text("Option 2"))
          //         ]),
          //     MLMenuItem(
          //       leading: Icon(Icons.notifications),
          //       content: Text("  Sale"),
          //       onClick: () {
          //         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SecondScreen()));
          //       },
          //     ),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         content: Text("  Sale Returns",
          //         ),
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         content: Text(
          //           "  Purchase",
          //         ),
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         content: Text(
          //           "  Purchase Order",
          //         ),
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         content: Text(
          //           "  Purchase Returns",
          //         ),
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         content: Text(
          //           "  Party Cr/Dr",
          //         ),
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         content: Text(
          //           "  Customer Cr/Dr",
          //         ),
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         trailing: Icon(Icons.arrow_right),
          //         content: Text(
          //           "  Reports",
          //         ),
          //         subMenuItems: [
          //           MLSubmenu(onClick: () {}, submenuContent: Text("Option 1")),
          //           MLSubmenu(onClick: () {}, submenuContent: Text("Option 2")),
          //           MLSubmenu(onClick: () {}, submenuContent: Text("Option 3")),
          //           MLSubmenu(onClick: () {}, submenuContent: Text("Option 4")),
          //         ],
          //         onClick: () {}),
          //     MLMenuItem(
          //         leading: Icon(Icons.payment),
          //         content: Text(
          //           "  Hold Bills",
          //         ),
          //         onClick: () {}),
          //   ],
          // ),//Deawer,
        ));
  }

  Container _tile(String title, IconData icon) {
    return Container(
        child: ListTile(
      title: Text(
        title,
        style: subheadline4,
      ),
      leading: Icon(
        Icons.arrow_back_ios_new_sharp,
        size: 15,
        color: primarycolor,
      ),
    ));
  }
}
