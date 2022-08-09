// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
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
    required this.name,
    required this.stateId,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
    required this.isDeleted,
  });

  String id;
  String name;
  String stateId;
  String isActive;
  DateTime createdAt;
  dynamic updatedAt;
  String isDeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "isActive": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt,
    "isDeleted": isDeleted,
  };
}
