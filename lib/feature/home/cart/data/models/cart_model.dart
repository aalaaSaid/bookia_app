import 'dart:convert';

class CartModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CartModel({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  factory CartModel.fromRawJson(String str) => CartModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
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
  User? user;
  String? total;
  List<CartItem>? cartItems;

  Data({
    this.id,
    this.user,
    this.total,
    this.cartItems,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    total: json["total"],
    cartItems: json["cart_items"] == null ? [] : List<CartItem>.from(json["cart_items"]!.map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "total": total,
    "cart_items": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
  };
}

class CartItem {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductImage;
  String? itemProductPrice;
  int? itemProductDiscount;
  double? itemProductPriceAfterDiscount;
  int? itemProductStock;
  int? itemQuantity;
  double? itemTotal;

  CartItem({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductImage,
    this.itemProductPrice,
    this.itemProductDiscount,
    this.itemProductPriceAfterDiscount,
    this.itemProductStock,
    this.itemQuantity,
    this.itemTotal,
  });

  factory CartItem.fromRawJson(String str) => CartItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    itemId: json["item_id"],
    itemProductId: json["item_product_id"],
    itemProductName: json["item_product_name"],
    itemProductImage: json["item_product_image"],
    itemProductPrice: json["item_product_price"],
    itemProductDiscount: json["item_product_discount"],
    itemProductPriceAfterDiscount: json["item_product_price_after_discount"]?.toDouble(),
    itemProductStock: json["item_product_stock"],
    itemQuantity: json["item_quantity"],
    itemTotal: json["item_total"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "item_product_id": itemProductId,
    "item_product_name": itemProductName,
    "item_product_image": itemProductImage,
    "item_product_price": itemProductPrice,
    "item_product_discount": itemProductDiscount,
    "item_product_price_after_discount": itemProductPriceAfterDiscount,
    "item_product_stock": itemProductStock,
    "item_quantity": itemQuantity,
    "item_total": itemTotal,
  };
}

class User {
  int? userId;
  String? userName;

  User({
    this.userId,
    this.userName,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
  };
}
