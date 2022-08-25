// To parse this JSON data, do
//
//     final viewPurchaseOrder = viewPurchaseOrderFromJson(jsonString);

import 'dart:convert';

ViewPurchaseOrder viewPurchaseOrderFromJson(String str) => ViewPurchaseOrder.fromJson(json.decode(str));

String viewPurchaseOrderToJson(ViewPurchaseOrder data) => json.encode(data.toJson());

class ViewPurchaseOrder {
  ViewPurchaseOrder({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewPurchaseOrder.fromJson(Map<String, dynamic> json) => ViewPurchaseOrder(
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
    required this.sId,
    required this.poNo,
    required this.mobile,
    required this.poDate,
    required this.expectedDate,
    required this.barcode,
    required this.itemId,
    required this.unitId,
    required this.itemColorId,
    required this.itmeSizeId,
    required this.price,
    required this.qty,
    required this.createdDate,
    required this.updatedDate,
    required this.isDeleted,
    required this.unit,
    required this.itemName,
    required this.itemsize,
    required this.itemcolor,
  });

  String id;
  String sId;
  String poNo;
  String mobile;
  DateTime poDate;
  DateTime expectedDate;
  String barcode;
  String itemId;
  String unitId;
  String itemColorId;
  String itmeSizeId;
  String price;
  String qty;
  String createdDate;
  String updatedDate;
  String isDeleted;
  String unit;
  String itemName;
  String itemsize;
  String itemcolor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    sId: json["s_id"],
    poNo: json["po_no"],
    mobile: json["mobile"],
    poDate: DateTime.parse(json["po_date"]),
    expectedDate: DateTime.parse(json["expected_date"]),
    barcode: json["barcode"],
    itemId: json["item_id"],
    unitId: json["unit_id"],
    itemColorId: json["item_color_id"],
    itmeSizeId: json["itme_size_id"],
    price: json["price"],
    qty: json["qty"],
    createdDate: json["created_date"],
    updatedDate: json["updated_date"],
    isDeleted: json["isDeleted"],
    unit: json["unit"],
    itemName: json["item_name"],
    itemsize: json["itemsize"],
    itemcolor: json["itemcolor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "s_id": sId,
    "po_no": poNo,
    "mobile": mobile,
    "po_date": "${poDate.year.toString().padLeft(4, '0')}-${poDate.month.toString().padLeft(2, '0')}-${poDate.day.toString().padLeft(2, '0')}",
    "expected_date": "${expectedDate.year.toString().padLeft(4, '0')}-${expectedDate.month.toString().padLeft(2, '0')}-${expectedDate.day.toString().padLeft(2, '0')}",
    "barcode": barcode,
    "item_id": itemId,
    "unit_id": unitId,
    "item_color_id": itemColorId,
    "itme_size_id": itmeSizeId,
    "price": price,
    "qty": qty,
    "created_date": createdDate,
    "updated_date": updatedDate,
    "isDeleted": isDeleted,
    "unit": unit,
    "item_name": itemName,
    "itemsize": itemsize,
    "itemcolor": itemcolor,
  };
}
