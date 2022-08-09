import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hawks/constants/color.dart';
import 'package:hawks/drawerlist.dart';
import 'package:hawks/screens/Sales/create_sale.dart';
import 'package:hawks/screens/Sales/create_salereturn.dart';
import 'package:hawks/screens/Sales/sale.dart';
import 'package:hawks/screens/Sales/sale_order/sale_order.dart';
import 'package:hawks/screens/Sales/sales_details.dart';
import 'package:hawks/screens/Sales/sales_return.dart';
import 'package:hawks/screens/accounts/account.dart';
import 'package:hawks/screens/accounts/account_group_list.dart';
import 'package:hawks/screens/dashboard.dart';
import 'package:hawks/screens/item/add_item_form.dart';
import 'package:hawks/screens/item/item_size_details.dart';
import 'package:hawks/screens/reports/invoice_report.dart';
import 'package:hawks/screens/reports/stock_report.dart';
import 'package:hawks/screens/sales_screen.dart';
import 'package:hawks/screens/settings/company_form.dart';
import 'package:hawks/screens/settings/invoice_setting.dart';
import 'package:hawks/screens/settings/manage_setting.dart';
import 'package:hawks/screens/splashscreen.dart';
import 'package:get/get.dart';
import 'package:hawks/screens/supplier/supplier_form.dart';
import 'package:http/io_client.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

class MyOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyOverride();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primaryColor: primarycolor),
      home: SplashScreen(),
    );
  }
}
