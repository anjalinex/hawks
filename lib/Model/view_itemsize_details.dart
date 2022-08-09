import 'dart:convert';

ViewItemsizeDetails viewItemsizeDetailsFromJson(String str) =>
    ViewItemsizeDetails.fromJson(json.decode(str));

String viewItemsizeDetailsToJson(ViewItemsizeDetails data) =>
    json.encode(data.toJson());

class ViewItemsizeDetails {
  ViewItemsizeDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewItemsizeDetails.fromJson(Map<String, dynamic> json) =>
      ViewItemsizeDetails(
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
    required this.sizeCode,
    required this.sizeName,
    required this.createdAt,
    required this.isdeleted,
  });

  String id;
  String sizeCode;
  String sizeName;
  DateTime createdAt;
  String isdeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        sizeCode: json["size_code"],
        sizeName: json["size_name"],
        createdAt: DateTime.parse(json["created_at"]),
        isdeleted: json["isdeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size_code": sizeCode,
        "size_name": sizeName,
        "created_at": createdAt.toIso8601String(),
        "isdeleted": isdeleted,
      };
}
