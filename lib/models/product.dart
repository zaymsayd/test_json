import 'dart:convert';

import 'package:flutter/material.dart';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final String? id;
  final String? price;
  final String? picture;
  final List<ProductColor>? colors;
  final String? productName;
  final List<Brand>? brands;

  Product({
    this.id,
    this.price,
    this.picture,
    this.colors,
    this.productName,
    this.brands,
  });

  Product copyWith({
    String? id,
    String? price,
    String? picture,
    List<ProductColor>? colors,
    String? productName,
    List<Brand>? brands,
  }) =>
      Product(
        id: id ?? this.id,
        price: price ?? this.price,
        picture: picture ?? this.picture,
        colors: colors ?? this.colors,
        productName: productName ?? this.productName,
        brands: brands ?? this.brands,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    price: json["price"],
    picture: json["picture"],
    colors: json["colors"] == null ? [] : List<ProductColor>.from(json["colors"]!.map((x) => colorValues.map[x]!)),
    productName: json["productName"],
    brands: json["brands"] == null ? [] : List<Brand>.from(json["brands"]!.map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "price": price,
    "picture": picture,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => colorValues.reverse[x])),
    "productName": productName,
    "brands": brands == null ? [] : List<dynamic>.from(brands!.map((x) => x.toJson())),
  };
}

class ProductColor {
  final String text;
  final Color color;

  ProductColor({required this.text,required this.color});
}

class Brand {
  final int? id;
  final String? name;

  Brand({
    this.id,
    this.name,
  });

  Brand copyWith({
    int? id,
    String? name,
  }) =>
      Brand(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}


final colorValues = EnumValues({
  "Blue": ProductColor(color: Colors.blue, text: "Blue"),
  "Green": ProductColor(color: Colors.green, text: "Green"),
  "Red": ProductColor(color: Colors.red, text: "Red"),
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
