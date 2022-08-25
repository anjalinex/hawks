import 'dart:convert';

ViewPurchaseReturn viewPurchaseReturnFromJson(String str) =>
    ViewPurchaseReturn.fromJson(json.decode(str));

String viewPurchaseReturnToJson(ViewPurchaseReturn data) =>
    json.encode(data.toJson());

class ViewPurchaseReturn {
  ViewPurchaseReturn({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewPurchaseReturn.fromJson(Map<String, dynamic> json) =>
      ViewPurchaseReturn(
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
    required this.address,
    required this.mobileNo,
    required this.pos,
    required this.gstType,
    required this.itemCenter,
    required this.returnBillNo,
    required this.purchaseBillNo,
    required this.billDate,
    required this.barcode,
    required this.itemId,
    required this.unitId,
    required this.itemColorId,
    required this.itmeSizeId,
    required this.qty,
    required this.basePrice,
    required this.discountAmount,
    required this.total,
    required this.isdeleted,
    required this.supplierName,
    required this.unit,
    required this.itemName,
    required this.itemsize,
    required this.itemcolor,
  });

  String id;
  String sId;
  String address;
  String mobileNo;
  String pos;
  String gstType;
  String itemCenter;
  String returnBillNo;
  String purchaseBillNo;
  DateTime billDate;
  String barcode;
  String itemId;
  String unitId;
  String itemColorId;
  String itmeSizeId;
  String qty;
  String basePrice;
  String discountAmount;
  String total;
  String isdeleted;
  String supplierName;
  String unit;
  String itemName;
  String itemsize;
  String itemcolor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sId: json["s_id"],
        address: json["address"],
        mobileNo: json["mobile_no"],
        pos: json["pos"],
        gstType: json["gst_type"],
        itemCenter: json["item_center"],
        returnBillNo: json["return_bill_no"],
        purchaseBillNo: json["purchase_bill_no"],
        billDate: DateTime.parse(json["bill_date"]),
        barcode: json["barcode"],
        itemId: json["item_id"],
        unitId: json["unit_id"],
        itemColorId: json["item_color_id"],
        itmeSizeId: json["itme_size_id"],
        qty: json["qty"],
        basePrice: json["base_price"],
        discountAmount: json["discount_amount"],
        total: json["total"],
        isdeleted: json["isdeleted"],
        supplierName: json["supplier_name"],
        unit: json["unit"],
        itemName: json["item_name"],
        itemsize: json["itemsize"],
        itemcolor: json["itemcolor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "s_id": sId,
        "address": address,
        "mobile_no": mobileNo,
        "pos": pos,
        "gst_type": gstType,
        "item_center": itemCenter,
        "return_bill_no": returnBillNo,
        "purchase_bill_no": purchaseBillNo,
        "bill_date":
            "${billDate.year.toString().padLeft(4, '0')}-${billDate.month.toString().padLeft(2, '0')}-${billDate.day.toString().padLeft(2, '0')}",
        "barcode": barcode,
        "item_id": itemId,
        "unit_id": unitId,
        "item_color_id": itemColorId,
        "itme_size_id": itmeSizeId,
        "qty": qty,
        "base_price": basePrice,
        "discount_amount": discountAmount,
        "total": total,
        "isdeleted": isdeleted,
        "supplier_name": supplierName,
        "unit": unit,
        "item_name": itemName,
        "itemsize": itemsize,
        "itemcolor": itemcolor,
      };
}
