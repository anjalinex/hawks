import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
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
    required this.countryId,
    required this.visible,
    required this.createdAt,
    required this.updatedAt,
    required this.isdeleted,
  });

  String id;
  String name;
  String countryId;
  String visible;
  DateTime createdAt;
  DateTime updatedAt;
  String isdeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    countryId: json["country_id"],
    visible: json["visible"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    isdeleted: json["isdeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country_id": countryId,
    "visible": visible,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "isdeleted": isdeleted,
  };
}
