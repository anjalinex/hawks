import 'dart:convert';

ViewInvoiceDetails viewInvoiceDetailsFromJson(String str) =>
    ViewInvoiceDetails.fromJson(json.decode(str));

String viewInvoiceDetailsToJson(ViewInvoiceDetails data) =>
    json.encode(data.toJson());

class ViewInvoiceDetails {
  ViewInvoiceDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewInvoiceDetails.fromJson(Map<String, dynamic> json) =>
      ViewInvoiceDetails(
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
    required this.branches,
    required this.invoiceType,
    required this.invoiceFormat,
    required this.invoiceName,
    required this.termsCondition1,
    required this.termsCondition2,
    required this.termsCondition3,
    required this.termsCondition4,
    required this.bankName,
    required this.ifscCode,
    required this.accountNo,
    required this.bankAddress,
    required this.headerColor,
    required this.createdAt,
    this.updatedAt,
    required this.isdeleted,
  });

  String id;
  String branches;
  String invoiceType;
  String invoiceFormat;
  String invoiceName;
  String termsCondition1;
  String termsCondition2;
  String termsCondition3;
  String termsCondition4;
  String bankName;
  String ifscCode;
  String accountNo;
  String bankAddress;
  String headerColor;
  DateTime createdAt;
  dynamic updatedAt;
  String isdeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        branches: json["branches"],
        invoiceType: json["invoice_type"],
        invoiceFormat: json["invoice_format"],
        invoiceName: json["invoice_name"],
        termsCondition1: json["terms_condition1"],
        termsCondition2: json["terms_condition2"],
        termsCondition3: json["terms_condition3"],
        termsCondition4: json["terms_condition4"],
        bankName: json["bank_name"],
        ifscCode: json["ifsc_code"],
        accountNo: json["account_no"],
        bankAddress: json["bank_address"],
        headerColor: json["header_color"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        isdeleted: json["isdeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branches": branches,
        "invoice_type": invoiceType,
        "invoice_format": invoiceFormat,
        "invoice_name": invoiceName,
        "terms_condition1": termsCondition1,
        "terms_condition2": termsCondition2,
        "terms_condition3": termsCondition3,
        "terms_condition4": termsCondition4,
        "bank_name": bankName,
        "ifsc_code": ifscCode,
        "account_no": accountNo,
        "bank_address": bankAddress,
        "header_color": headerColor,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "isdeleted": isdeleted,
      };
}
