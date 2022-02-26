// To parse this JSON data, do
//
//     final country = countryFromMap(jsonString);

import 'dart:convert';

List<Country> countryFromMap(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromMap(x)));

String countryToMap(List<Country> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Country {
  Country({
    this.id,
    this.countryName,
    this.imageStr,
  });

  int? id;
  String? countryName;
  String? imageStr;

  factory Country.fromMap(Map<String, dynamic> json) => Country(
    id: json["id"] ?? null,
    countryName: json["countryName"] ?? null,
    imageStr: json["imageStr"] ?? null,
  );

  Map<String, dynamic> toMap() => {
    "id": id ?? null,
    "countryName": countryName ?? null,
    "imageStr": imageStr ?? null,
  };
}
