import 'dart:convert';

class ProfileModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ProfileModel({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    error: json["error"] == null ? [] : List<dynamic>.from(json["error"]!.map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
    "status": status,
  };
}

class Data {
  int? id;
  String? name;
  String? email;
  String? address;
  dynamic city;
  String? phone;
  bool? emailVerified;
  String? image;

  Data({
    this.id,
    this.name,
    this.email,
    this.address,
    this.city,
    this.phone,
    this.emailVerified,
    this.image,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    city: json["city"],
    phone: json["phone"],
    emailVerified: json["email_verified"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "address": address,
    "city": city,
    "phone": phone,
    "email_verified": emailVerified,
    "image": image,
  };
}
