// To parse this JSON data, do
//
//     final viewItemcolorDetails = viewItemcolorDetailsFromJson(jsonString);

import 'dart:convert';

ViewItemcolorDetails viewItemcolorDetailsFromJson(String str) => ViewItemcolorDetails.fromJson(json.decode(str));

String viewItemcolorDetailsToJson(ViewItemcolorDetails data) => json.encode(data.toJson());

class ViewItemcolorDetails {
  ViewItemcolorDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewItemcolorDetails.fromJson(Map<String, dynamic> json) => ViewItemcolorDetails(
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
    required this.colorCode,
    required this.colorName,
    required this.createdAt,
    required this.isdeleted,
  });

  String id;
  String colorCode;
  String colorName;
  DateTime createdAt;
  String isdeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    colorCode: json["color_code"],
    colorName: json["color_name"],
    createdAt: DateTime.parse(json["created_at"]),
    isdeleted: json["isdeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color_code": colorCode,
    "color_name": colorName,
    "created_at": createdAt.toIso8601String(),
    "isdeleted": isdeleted,
  };
}
