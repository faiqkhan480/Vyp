// To parse this JSON data, do
//
//     final subCategory = subCategoryFromMap(jsonString);

import 'dart:convert';

List<SubCategory> subCategoryFromMap(String str) => List<SubCategory>.from(json.decode(str).map((x) => SubCategory.fromMap(x)));

String subCategoryToMap(List<SubCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.categoryId,
  });

  int? id;
  String? name;
  int? categoryId;

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
    id: json["id"] == null ? null : json["id"],
    name: json["subCategoryName"] == null ? null : json["subCategoryName"],
    categoryId: json["idCategory"] == null ? null : json["idCategory"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "subCategoryName": name == null ? null : name,
    "idCategory": categoryId == null ? null : categoryId,
  };
}
