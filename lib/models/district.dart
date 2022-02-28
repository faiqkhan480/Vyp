// To parse this JSON data, do
//
//     final district = districtFromMap(jsonString);

import 'dart:convert';

List<District> districtFromMap(String str) => List<District>.from(json.decode(str).map((x) => District.fromMap(x)));

String districtToMap(List<District> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class District {
  District({
    this.id,
    this.districtName,
    this.idCountry,
  });

  int? id;
  String? districtName;
  int? idCountry;

  factory District.fromMap(Map<String, dynamic> json) => District(
    id: json["id"] == null ? null : json["id"],
    districtName: json["districtName"] == null ? null : json["districtName"],
    idCountry: json["idCountry"] == null ? null : json["idCountry"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "districtName": districtName == null ? null : districtName,
    "idCountry": idCountry == null ? null : idCountry,
  };
}
