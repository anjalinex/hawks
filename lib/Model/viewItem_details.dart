// To parse this JSON data, do
//
//     final viewItemDetails = viewItemDetailsFromJson(jsonString);

import 'dart:convert';

ViewItemDetails viewItemDetailsFromJson(String str) => ViewItemDetails.fromJson(json.decode(str));

String viewItemDetailsToJson(ViewItemDetails data) => json.encode(data.toJson());

class ViewItemDetails {
  ViewItemDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewItemDetails.fromJson(Map<String, dynamic> json) => ViewItemDetails(
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
    required this.itemName,
    required this.sku,
    required this.unit,
    required this.itemsize,
    required this.itemcolor,
    required this.purchasePrice,
    required this.mrp,
    required this.discount,
    required this.salesPriceWithtax,
    required this.salesPriceWithouttax,
    required this.catId,
    required this.category,
  });

  String id;
  String itemName;
  String sku;
  String unit;
  String itemsize;
  String itemcolor;
  String purchasePrice;
  String mrp;
  String discount;
  String salesPriceWithtax;
  String salesPriceWithouttax;
  String catId;
  String category;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    itemName: json["item_name"],
    sku: json["sku"],
    unit: json["unit"],
    itemsize: json["itemsize"],
    itemcolor: json["itemcolor"],
    purchasePrice: json["purchase_price"],
    mrp: json["mrp"],
    discount: json["discount"],
    salesPriceWithtax: json["sales_price_withtax"],
    salesPriceWithouttax: json["sales_price_withouttax"],
    catId: json["cat_id"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_name": itemName,
    "sku": sku,
    "unit": unit,
    "itemsize": itemsize,
    "itemcolor": itemcolor,
    "purchase_price": purchasePrice,
    "mrp": mrp,
    "discount": discount,
    "sales_price_withtax": salesPriceWithtax,
    "sales_price_withouttax": salesPriceWithouttax,
    "cat_id": catId,
    "category": category,
  };
}
