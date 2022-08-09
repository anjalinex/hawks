import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.message,
    required this.data,
  });

  String message;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.contact,
    required this.country,
    required this.state,
    required this.city,
    required this.createdAt,
    this.updatedAt,
  });

  String id;
  String name;
  String email;
  String password;
  dynamic contact;
  String country;
  String state;
  String city;
  DateTime createdAt;
  dynamic updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        contact: json["contact"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "contact": contact,
        "country": country,
        "state": state,
        "city": city,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
