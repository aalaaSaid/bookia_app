import 'dart:convert';

class SliderModel {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  SliderModel({
    this.data,
    this.message,
    this.error,
    this.status,
  });

  factory SliderModel.fromRawJson(String str) => SliderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
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
  List<Slider>? sliders;

  Data({
    this.sliders,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sliders: json["sliders"] == null ? [] : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toJson())),
  };
}

class Slider {
  String? image;

  Slider({
    this.image,
  });

  factory Slider.fromRawJson(String str) => Slider.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}
