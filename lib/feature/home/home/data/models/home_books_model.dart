import 'dart:convert';

class BooksModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  BooksModel({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  factory BooksModel.fromRawJson(String str) => BooksModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksModel.fromJson(Map<String, dynamic> json) => BooksModel(
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
  List<Product>? products;

  Data({
    this.products,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  int? discount;
  double? priceAfterDiscount;
  int? stock;
  int? bestSeller;
  String? image;
  String? category;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.stock,
    this.bestSeller,
    this.image,
    this.category,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    discount: json["discount"],
    priceAfterDiscount: json["price_after_discount"]?.toDouble(),
    stock: json["stock"],
    bestSeller: json["best_seller"],
    image: json["image"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "discount": discount,
    "price_after_discount": priceAfterDiscount,
    "stock": stock,
    "best_seller": bestSeller,
    "image": image,
    "category": category,
  };
}
