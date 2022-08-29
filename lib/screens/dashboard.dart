import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:hawks/constants/style.dart';
import 'package:hawks/screens/Sales/create_salereturn.dart';
import 'package:hawks/screens/purchase/prchase_order/purchase_order.dart';
import 'package:hawks/screens/purchase/purchase.dart';
import 'package:hawks/screens/purchase/purchase_return/purchase_return.dart';
import 'package:hawks/screens/purchase/purchase_return/purchase_return_details.dart';
import 'package:hawks/screens/purchase/supllier_cr_dr.dart';
import 'package:hawks/screens/reports/invoice_report.dart';
import 'package:hawks/screens/reports/purchase_reports.dart';
import 'package:hawks/screens/reports/stock_report.dart';
import 'package:hawks/screens/settings/invoice_setting.dart';
import 'package:hawks/screens/settings/manage_setting.dart';
import 'package:hawks/screens/supplier/supllier_details.dart';

import '../constants/color.dart';
import 'Sales/customer_cr_dr.dart';
import 'Sales/sale.dart';
import 'Sales/saleReturn_Details.dart';
import 'Sales/sale_order/sale_order.dart';
import 'accounts/account.dart';
import 'accounts/account_group_list.dart';
import 'customer/customer_details.dart';
import 'item/item_color_details.dart';
import 'item/item_details.dart';
import 'item/item_size_details.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primarycolor,
          elevation: 0.0,
          title: Text("Dashboard"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: height * .10,
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                  color: primarycolor),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(SalesOrder());
                              },
                              icon: Image.asset(
                                color: primarycolor,
                                "assets/images/sales_order.png",
                                height: height * .05,
                              ),
                            ),
                            Text(
                              "Sale Order",
                              style: subheadline3,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(Sale());
                              },
                              icon: Image.asset(
                                "assets/images/sales.jpg",
                                height: height * .05,
                              ),
                            ),
                            Text(
                              "Sale",
                              style: subheadline3,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(CreateSaleReturn());
                              },
                              icon: Image.asset(
                                "assets/images/sales_return.png",
                                height: height * .05,
                                color: primarycolor,
                              ),
                            ),
                            Text(
                              "Sales Return",
                              style: subheadline3,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(PurchaseOrder());
                              },
                              icon: Image.asset(
                                color: primarycolor,
                                "assets/images/purchase_order.png",
                                height: height * .05,
                              ),
                            ),
                            Text(
                              "Purchase Order",
                              style: subheadline3,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(Purchase());
                              },
                              icon: Image.asset(
                                "assets/images/purchase.png",
                                height: height * .05,
                                color: primarycolor,
                              ),
                            ),
                            Text(
                              "Purchase",
                              style: subheadline3,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(PurchaseReturn());
                              },
                              icon: Image.asset(
                                "assets/images/purchase_return.png",
                                height: height * .05,
                                color: primarycolor,
                              ),
                            ),
                            Text(
                              "Purchase Return",
                              style: subheadline3,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(children: <Widget>[
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
                title: Text(
                  'Dashboard',
                  style: subheadline3,
                ),
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
                                      // InkWell(
                                      //   onTap: () {
                                      //     // Get.to(CustomerDetails(),
                                      //     //     duration: Duration(
                                      //     //         milliseconds:
                                      //     //             500), //duration of transitions, default 1 sec
                                      //     //     transition: Transition.rightToLeft);
                                      //   },
                                      //   child: _tile('Create Unit',
                                      //       Icons.dashboard_customize),
                                      // ),
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
                              leading: Image.asset(
                                "assets/images/sales.jpg",
                                height: height * .03,
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
                              Get.to(SalesOrder(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Sale Order', Icons.create),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(Sale(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Create Sale', Icons.group),
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
                              leading: Image.asset(
                                "assets/images/purchase.png",
                                height: height * .03,
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
                              Get.to(PurchaseOrder(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Purchase Order', Icons.create),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(Purchase(),
                                  duration: Duration(milliseconds: 300),
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Create Purchase', Icons.group),
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
                                          // Get.to(ItemDetails(),
                                          //     duration:
                                          //         Duration(milliseconds: 300),
                                          //     transition:
                                          //         Transition.rightToLeft);
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
                              Get.to(StockReport(),
                                  duration: Duration(
                                      milliseconds:
                                          300), //duration of transitions, default 1 sec
                                  transition: Transition.rightToLeft);
                            },
                            child: _tile('Stock', Icons.price_change),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(PurchaseReports(),
                                  duration: Duration(
                                      milliseconds:
                                          300), //duration of transitions, default 1 sec
                                  transition: Transition.rightToLeft);
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
              )
            ]),
          ),
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
