// To parse this JSON data, do
//
//     final county = countyFromMap(jsonString);

import 'dart:convert';

List<County> countyFromMap(String str) => List<County>.from(json.decode(str).map((x) => County.fromMap(x)));

String countyToMap(List<County> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class County {
  County({
    this.id,
    this.name,
    this.districtId,
  });

  int? id;
  String? name;
  int? districtId;

  factory County.fromMap(Map<String, dynamic> json) => County(
    id: json["id"] == null ? null : json["id"],
    name: json["countyName"] == null ? null : json["countyName"],
    districtId: json["idDistrict"] == null ? null : json["idDistrict"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "countyName": name == null ? null : name,
    "idDistrict": districtId == null ? null : districtId,
  };
}
