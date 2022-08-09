import 'dart:convert';

ViewItemDetails viewItemDetailsFromJson(String str) =>
    ViewItemDetails.fromJson(json.decode(str));

String viewItemDetailsToJson(ViewItemDetails data) =>
    json.encode(data.toJson());

class ViewItemDetails {
  ViewItemDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewItemDetails.fromJson(Map<String, dynamic> json) =>
      ViewItemDetails(
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
    required this.itemName,
    required this.sku,
    required this.unit,
    required this.itemsize,
    required this.itemcolor,
    required this.purchasePrice,
  });

  String itemName;
  String sku;
  String unit;
  String itemsize;
  String itemcolor;
  String purchasePrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        itemName: json["item_name"],
        sku: json["sku"],
        unit: json["unit"],
        itemsize: json["itemsize"],
        itemcolor: json["itemcolor"],
        purchasePrice: json["purchase_price"],
      );

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "sku": sku,
        "unit": unit,
        "itemsize": itemsize,
        "itemcolor": itemcolor,
        "purchase_price": purchasePrice,
      };
}
