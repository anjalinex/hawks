// To parse this JSON data, do
//
//     final viewCompanyDetails = viewCompanyDetailsFromJson(jsonString);

import 'dart:convert';

ViewCompanyDetails viewCompanyDetailsFromJson(String str) =>
    ViewCompanyDetails.fromJson(json.decode(str));

String viewCompanyDetailsToJson(ViewCompanyDetails data) =>
    json.encode(data.toJson());

class ViewCompanyDetails {
  ViewCompanyDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewCompanyDetails.fromJson(Map<String, dynamic> json) =>
      ViewCompanyDetails(
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
    required this.companyName,
    required this.gstNo,
    required this.email,
    required this.pos,
    required this.contactNo,
    required this.username,
    required this.estYear,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.zipcode,
    required this.locality,
    required this.language,
    required this.address,
    required this.date,
    required this.createdAt,
    this.updatedAt,
    required this.isdeleted,
  });

  String id;
  String companyName;
  String gstNo;
  String email;
  String pos;
  String contactNo;
  String username;
  String estYear;
  String countryId;
  String stateId;
  String cityId;
  String zipcode;
  String locality;
  String language;
  String address;
  String date;
  DateTime createdAt;
  dynamic updatedAt;
  String isdeleted;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyName: json["company_name"],
        gstNo: json["gst_no"],
        email: json["email"],
        pos: json["pos"],
        contactNo: json["contact_no"],
        username: json["username"],
        estYear: json["est_year"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        zipcode: json["zipcode"],
        locality: json["locality"],
        language: json["language"],
        address: json["address"],
        date: json["date"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        isdeleted: json["isdeleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "gst_no": gstNo,
        "email": email,
        "pos": pos,
        "contact_no": contactNo,
        "username": username,
        "est_year": estYear,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "zipcode": zipcode,
        "locality": locality,
        "language": language,
        "address": address,
        "date": date,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "isdeleted": isdeleted,
      };
}
