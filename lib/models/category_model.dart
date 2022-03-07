// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

List<Category> categoryFromMap(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromMap(x)));

String categoryToMap(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Category {
  Category({
    this.id,
    this.categoryName,
  });

  int? id;
  String? categoryName;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    categoryName: json["categoryName"] == null ? null : json["categoryName"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "categoryName": categoryName == null ? null : categoryName,
  };
}
