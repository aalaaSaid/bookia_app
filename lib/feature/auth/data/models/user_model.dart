import 'dart:convert';

class UserModel {
  Data data;
  String message;
  List<dynamic> error;
  int status;

  UserModel({
    required this.data,
    required this.message,
    required this.error,
    required this.status,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    error: List<dynamic>.from(json["error"].map((x) => x)),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "error": List<dynamic>.from(error.map((x) => x)),
    "status": status,
  };
}

class Data {
  User user;
  String token;

  Data({
    required this.user,
    required this.token,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "token": token,
  };
}

class User {
  int id;
  String name;
  String email;
  dynamic address;
  dynamic city;
  dynamic phone;
  bool emailVerified;
  String image;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.city,
    required this.phone,
    required this.emailVerified,
    required this.image,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
