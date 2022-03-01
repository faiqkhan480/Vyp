// To parse this JSON data, do
//
//     final county = countyFromMap(jsonString);

import 'dart:convert';

List<County> countyFromMap(String str) => List<County>.from(json.decode(str).map((x) => County.fromMap(x)));

String countyToMap(List<County> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class County {
  County({
    this.id,
    this.countyName,
    this.idDistrict,
  });

  int? id;
  String? countyName;
  int? idDistrict;

  factory County.fromMap(Map<String, dynamic> json) => County(
    id: json["id"] == null ? null : json["id"],
    countyName: json["countyName"] == null ? null : json["countyName"],
    idDistrict: json["idDistrict"] == null ? null : json["idDistrict"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "countyName": countyName == null ? null : countyName,
    "idDistrict": idDistrict == null ? null : idDistrict,
  };
}
