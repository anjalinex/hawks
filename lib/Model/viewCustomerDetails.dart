// To parse this JSON data, do
//
//     final viewCustomerDetails = viewCustomerDetailsFromJson(jsonString);

import 'dart:convert';

ViewCustomerDetails viewCustomerDetailsFromJson(String str) => ViewCustomerDetails.fromJson(json.decode(str));

String viewCustomerDetailsToJson(ViewCustomerDetails data) => json.encode(data.toJson());

class ViewCustomerDetails {
  ViewCustomerDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewCustomerDetails.fromJson(Map<String, dynamic> json) => ViewCustomerDetails(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.customerName,
    required this.mobileNo,
    required this.email,
    required this.gstNo,
    required this.birthday,
    required this.anniversary,
    required this.openingBalance,
    required this.title,
    required this.creditDays,
    required this.creaditLimit,
    required this.createdAt,
    this.updatedAt,
    required this.isdeleted,
    required this.address,
    required this.billingAddress,
  });

  String id;
  String customerName;
  String mobileNo;
  String email;
  String gstNo;
  String birthday;
  String anniversary;
  String openingBalance;
  String title;
  String creditDays;
  String creaditLimit;
  DateTime createdAt;
  dynamic updatedAt;
  String isdeleted;
  String address;
  String billingAddress;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    customerName: json["customer_name"],
    mobileNo: json["mobile_no"],
    email: json["email"],
    gstNo: json["gst_no"],
    birthday: json["birthday"],
    anniversary: json["anniversary"],
    openingBalance: json["opening_balance"],
    title: json["title"],
    creditDays: json["credit_days"],
    creaditLimit: json["creadit_limit"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    isdeleted: json["isdeleted"],
    address: json["address"],
    billingAddress: json["billing_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_name": customerName,
    "mobile_no": mobileNo,
    "email": email,
    "gst_no": gstNo,
    "birthday": birthday,
    "anniversary": anniversary,
    "opening_balance": openingBalance,
    "title": title,
    "credit_days": creditDays,
    "creadit_limit": creaditLimit,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "isdeleted": isdeleted,
    "address": address,
    "billing_address": billingAddress,
  };
}
