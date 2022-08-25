// To parse this JSON data, do
//
//     final viewCreatePurchase = viewCreatePurchaseFromJson(jsonString);

import 'dart:convert';

ViewCreatePurchase viewCreatePurchaseFromJson(String str) => ViewCreatePurchase.fromJson(json.decode(str));

String viewCreatePurchaseToJson(ViewCreatePurchase data) => json.encode(data.toJson());

class ViewCreatePurchase {
  ViewCreatePurchase({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewCreatePurchase.fromJson(Map<String, dynamic> json) => ViewCreatePurchase(
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
    required this.invNo,
    required this.supInvDate,
    required this.pos,
    required this.mobile,
    required this.itemId,
    required this.itemCenter,
    required this.billNo,
    required this.billDate,
    required this.customerType,
    required this.barcode,
    required this.unitId,
    required this.itemColorId,
    required this.itmeSizeId,
    required this.qty,
    required this.price,
    required this.total,
    required this.expireDate,
    this.createdAt,
    this.updatedAt,
    required this.isdeleted,
    required this.suppliername,
    required this.unit,
    required this.itemName,
    required this.itemsize,
    required this.itemcolor,
  });

  String id;
  String sId;
  String invNo;
  DateTime supInvDate;
  String pos;
  String mobile;
  String itemId;
  String itemCenter;
  String billNo;
  DateTime billDate;
  String customerType;
  String barcode;
  String unitId;
  String itemColorId;
  String itmeSizeId;
  String qty;
  String price;
  String total;
  DateTime expireDate;
  dynamic createdAt;
  dynamic updatedAt;
  String isdeleted;
  String suppliername;
  String unit;
  String itemName;
  String itemsize;
  String itemcolor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    sId: json["s_id"],
    invNo: json["inv_no"],
    supInvDate: DateTime.parse(json["sup_inv_date"]),
    pos: json["pos"],
    mobile: json["mobile"],
    itemId: json["item_id"],
    itemCenter: json["item_center"],
    billNo: json["bill_no"],
    billDate: DateTime.parse(json["bill_date"]),
    customerType: json["customer_type"],
    barcode: json["barcode"],
    unitId: json["unit_id"],
    itemColorId: json["item_color_id"],
    itmeSizeId: json["itme_size_id"],
    qty: json["qty"],
    price: json["price"],
    total: json["total"],
    expireDate: DateTime.parse(json["expire_date"]),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    isdeleted: json["isdeleted"],
    suppliername: json["supplier_name"],
    unit: json["unit"],
    itemName: json["item_name"],
    itemsize: json["itemsize"],
    itemcolor: json["itemcolor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "s_id": sId,
    "inv_no": invNo,
    "sup_inv_date": supInvDate.toIso8601String(),
    "pos": pos,
    "mobile": mobile,
    "item_id": itemId,
    "item_center": itemCenter,
    "bill_no": billNo,
    "bill_date": billDate.toIso8601String(),
    "customer_type": customerType,
    "barcode": barcode,
    "unit_id": unitId,
    "item_color_id": itemColorId,
    "itme_size_id": itmeSizeId,
    "qty": qty,
    "price": price,
    "total": total,
    "expire_date": "${expireDate.year.toString().padLeft(4, '0')}-${expireDate.month.toString().padLeft(2, '0')}-${expireDate.day.toString().padLeft(2, '0')}",
    "created_at": createdAt,
    "updated_at": updatedAt,
    "isdeleted": isdeleted,
    "supplier_name": suppliername,
    "unit": unit,
    "item_name": itemName,
    "itemsize": itemsize,
    "itemcolor": itemcolor,
  };
}
