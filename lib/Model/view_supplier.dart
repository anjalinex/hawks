import 'dart:convert';

ViewSupplierDetails viewSupplierDetailsFromJson(String str) =>
    ViewSupplierDetails.fromJson(json.decode(str));

String viewSupplierDetailsToJson(ViewSupplierDetails data) =>
    json.encode(data.toJson());

class ViewSupplierDetails {
  ViewSupplierDetails({
    required this.message,
    required this.data,
  });

  String message;
  List<Datum> data;

  factory ViewSupplierDetails.fromJson(Map<String, dynamic> json) =>
      ViewSupplierDetails(
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
    required this.supplierName,
    required this.mobileNo,
    required this.email,
    required this.gstNo,
    required this.openingBalance,
    required this.title,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.address,
    required this.zipcode,
    required this.remarks,
    required this.createdAt,
    this.updatedAt,
    required this.isdeleted,
    required this.city,
  });

  String id;
  String supplierName;
  String mobileNo;
  String email;
  String gstNo;
  String openingBalance;
  String title;
  String countryId;
  String stateId;
  String cityId;
  String address;
  String zipcode;
  String remarks;
  DateTime createdAt;
  dynamic updatedAt;
  String isdeleted;
  String city;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        supplierName: json["supplier_name"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        gstNo: json["gst_no"],
        openingBalance: json["opening_balance"],
        title: json["title"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        address: json["address"],
        zipcode: json["zipcode"],
        remarks: json["remarks"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        isdeleted: json["isdeleted"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_name": supplierName,
        "mobile_no": mobileNo,
        "email": email,
        "gst_no": gstNo,
        "opening_balance": openingBalance,
        "title": title,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "address": address,
        "zipcode": zipcode,
        "remarks": remarks,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "isdeleted": isdeleted,
        "city": city,
      };
}
