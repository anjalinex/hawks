import 'dart:convert';

ViewCategory viewCategoryFromJson(String str) =>
    ViewCategory.fromJson(json.decode(str));

String viewCategoryToJson(ViewCategory data) => json.encode(data.toJson());

class ViewCategory {
  ViewCategory({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewCategory.fromJson(Map<String, dynamic> json) => ViewCategory(
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
    required this.category,
    required this.createdAt,
    required this.isdeleted,
  });

  String id;
  String category;
  DateTime createdAt;
  String isdeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        isdeleted: json["isdeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "created_at": createdAt.toIso8601String(),
        "isdeleted": isdeleted,
      };
}
