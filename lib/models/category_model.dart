// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

List<Category> categoryFromMap(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromMap(x)));

String categoryToMap(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Category {
  Category({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["categoryName"] == null ? null : json["categoryName"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "categoryName": name == null ? null : name,
  };
}
