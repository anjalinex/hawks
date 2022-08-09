import 'dart:async';
import 'dart:convert';
import 'package:hawks/Model/viewCustomerDetails.dart';
import 'package:hawks/Model/viewItem_details.dart';
import 'package:hawks/Model/view_itemsize_details.dart';
import 'package:hawks/Model/view_supplier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hawks/Model/StateModel.dart';
import 'package:hawks/Model/citymodel.dart';
import 'package:hawks/Model/countrymodel.dart';
import 'package:hawks/Model/loginmodel.dart';
import 'package:hawks/Model/signupModel.dart';
import 'package:hawks/Model/viewInvoiceDetails.dart';
import 'package:hawks/Model/viewcompanydetails.dart';
import 'package:hawks/constants/url.dart';
import 'package:hawks/screens/dashboard.dart';
import 'package:hawks/screens/loginpage.dart';
import 'package:http/http.dart' as http;

import '../Model/viewInvoiceDetails.dart';
import '../Model/viewInvoiceDetails.dart';
import '../Model/viewInvoiceDetails.dart';
import '../Model/view_itemcolor.dart';

class ApiServices {
//signup
  Future Signup(
    String name,
    String email,
    String password,
    String country,
    String state,
    String city,
    String contact,
  ) async {
    Map data = {
      'name': name,
      'email': email,
      'password': password,
      'country': '1',
      'state': state,
      'city': city,
      'contact': contact
    };

    String body = json.encode(data);
    var response = await http.post(
      Uri.parse(signupApi),
      body: body,
    );
    var dataresponse = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.offAll(LoginPage());
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //signup
  Future signup(
    String name,
    String email,
    String password,
    String country,
    String state,
    String city,
    String contact,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(signupApi));
    request.fields.addAll({
      'name': name,
      'email': email,
      'password': password,
      'country': '1',
      'state': '3',
      'city': '2',
      'contact': contact
    });
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
      Get.offAll(Dashboard());
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //Login
  Future login(
    String email,
    String password,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(loginApi));
    request.fields.addAll({'email': email, 'password': password});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
      Get.offAll(Dashboard());
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //Login
  Future Login(
    String email,
    String password,
  ) async {
    Map data = {'email': email, 'password': password};
    print(data);
    String body = json.encode(data);
    var response = await http.post(
      Uri.parse(loginApi),
      body: body,
    );
    var dataresponse = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Get.offAll(Dashboard());
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<CountryModel> country() async {
    late List<CountryModel> countrydata;
    return http.get(Uri.parse(countryApi)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return countrydata = jsonDecode(response.body);
    });
  }

  Future<StateModel> State() async {
    Map body = {
      'country_id': '101',
    };
    return http
        .post(Uri.parse(statesApi), body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return StateModel.fromJson(json.decode(response.body));
    });
  }

  Future Cities(String url, String state, {required Map body}) async {
    body = {
      'state_id': state,
    };
    return http
        .post(Uri.parse(cityApi), body: body)
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return CityModel.fromJson(json.decode(response.body));
    });
  }

  //Createcompany
  Future Createcompany(
    String company_name,
    String email,
    String gst_no,
    String pos,
    String contact_no,
    String est_year,
    String country_id,
    String state_id,
    String city_id,
    String zipcode,
    String username,
    String locality,
    String language,
    String address,
    String date,
  ) async {
    Map data = {
      'company_name': company_name,
      'email': email,
      'gst_no': gst_no,
      'pos': pos,
      'contact_no': contact_no,
      'est_year': est_year,
      'country_id': '1',
      'state_id': state_id,
      'city_id': city_id,
      'zipcode': zipcode,
      'username': username,
      'locality': locality,
      'language': language,
      'address': address,
      'date': date
    };

    String body = json.encode(data);
    var response = await http.post(
      Uri.parse(createCompany),
      body: body,
    );
    var dataresponse = jsonDecode(response.body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: dataresponse["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //Createcompany
  // Future CreateInvoice(
  //   String branches,
  //   String invoice_type,
  //   String invoice_format,
  //   String invoice_name,
  //   String terms_condition1,
  //   String terms_condition2,
  //   String terms_condition3,
  //   String terms_condition4,
  //   String bank_name,
  //   String ifsc_code,
  //   String account_no,
  //   String bank_address,
  //   String header_color,
  // ) async {
  //   Map data = {
  //     'branches': branches,
  //     'invoice_type': invoice_type,
  //     'invoice_format': invoice_format,
  //     'invoice_name': invoice_name,
  //     'terms_condition1': terms_condition1,
  //     'terms_condition2': terms_condition2,
  //     'terms_condition3': terms_condition3,
  //     'terms_condition4': terms_condition4,
  //     'bank_name': bank_name,
  //     'ifsc_code': ifsc_code,
  //     'account_no': account_no,
  //     'bank_address': bank_address,
  //     'header_color': header_color
  //   };
  //   String body = json.encode(data);
  //   var response = await http.post(
  //     Uri.parse(createinvoice),
  //     body: body,
  //   );
  //   var dataresponse = jsonDecode(response.body);
  //   print(response.body);
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(
  //         msg: dataresponse["message"],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: dataresponse["message"],
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 5,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }

//ViewCompanyDetails
  Future<ViewCompanyDetails> Viewcompany() async {
    return http.get(Uri.parse(view_company)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return ViewCompanyDetails.fromJson(json.decode(response.body));
    });
  }

  //DeleteCompanyDetails
  Future DeleteCompanyDetails(
    String id,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(removecompany));
    request.fields.addAll({'id': id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //ViewInvoiceDetails
  Future<ViewInvoiceDetails> ViewInvoice() async {
    return http.get(Uri.parse(view_invoice)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return ViewInvoiceDetails.fromJson(json.decode(response.body));
    });
  }

  //DeleteInvoiceDetails
  Future DeleteInvoiceDetails(
    String id,
  ) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(remove_invoice_details));
    request.fields.addAll({'id': id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //ViewInvoiceDetails
  Future<ViewSupplierDetails> ViewSupplier() async {
    return http
        .get(Uri.parse(view_supplier_details))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return ViewSupplierDetails.fromJson(json.decode(response.body));
    });
  }

  //DeleteSupplierDetails
  Future DeleteSupplierDetails(
    String id,
  ) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(remove_supplier_details));
    request.fields.addAll({'id': id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //ViewCustomer
  Future<ViewCustomerDetails> ViewCustomer() async {
    return http
        .get(Uri.parse(view_customer_details))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return ViewCustomerDetails.fromJson(json.decode(response.body));
    });
  }

//DeleteSupplierDetails
  Future DeleteCustomerDetails(
    String id,
  ) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(remove_customer_details));
    request.fields.addAll({'id': id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //ViewItemcolor
  Future<ViewItemcolorDetails> ViewItemcolor() async {
    return http.get(Uri.parse(view_itemcolor)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return ViewItemcolorDetails.fromJson(json.decode(response.body));
    });
  }

  //DeleteSupplierDetails
  Future DeleteItemColorDetails(
    String id,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(remove_itemcolor));
    request.fields.addAll({'id': id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //ViewItemcolor
  Future<ViewItemsizeDetails> ViewItemsize() async {
    return http.get(Uri.parse(view_itemsize)).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return ViewItemsizeDetails.fromJson(json.decode(response.body));
    });
  }

  //DeleteSupplierDetails
  Future DeleteItemSizeDetails(
    String id,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(remove_itemsize));
    request.fields.addAll({'id': id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }

  //ViewItemDetails
  Future<ViewItemDetails> ViewItem() async {
    return http
        .get(Uri.parse(view_item_details))
        .then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode != 200) {
        throw new Exception("Error");
      }
      return ViewItemDetails.fromJson(json.decode(response.body));
    });
  }

  //DeleteSupplierDetails
  Future DeleteItemDetails(
    String id,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse(remove_item_details));
    request.fields.addAll({'id': id});
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
    } else {
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }
}
