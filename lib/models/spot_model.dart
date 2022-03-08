// To parse this JSON data, do
//
//     final spot = spotFromMap(jsonString);

import 'dart:convert';

List<Spot> spotFromMap(String str) => List<Spot>.from(json.decode(str).map((x) => Spot.fromMap(x)));

String spotToMap(List<Spot> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Spot {
  Spot({
    this.id,
    this.idCountry,
    this.idDistrict,
    this.idCounty,
    this.imageStr,
    this.spotName,
    this.website,
    this.email,
    this.contact,
    this.latitude,
    this.longitude,
    this.shortDescription,
    this.longDescription,
    this.fact1,
    this.fact2,
    this.fact3,
    this.fact4,
    this.fact5,
  });

  int? id;
  int? idCountry;
  int? idDistrict;
  int? idCounty;
  String? imageStr;
  String? spotName;
  String? website;
  String? email;
  String? contact;
  String? latitude;
  String? longitude;
  String? shortDescription;
  String? longDescription;
  String? fact1;
  String? fact2;
  String? fact3;
  String? fact4;
  String? fact5;

  factory Spot.fromMap(Map<String, dynamic> json) => Spot(
    id: json["id"] == null ? null : json["id"],
    idCountry: json["idCountry"] == null ? null : json["idCountry"],
    idDistrict: json["idDistrict"] == null ? null : json["idDistrict"],
    idCounty: json["idCounty"] == null ? null : json["idCounty"],
    imageStr: json["imageStr"] == null ? null : json["imageStr"],
    spotName: json["spotName"] == null ? null : json["spotName"],
    website: json["website"] == null ? null : json["website"],
    email: json["email"] == null ? null : json["email"],
    contact: json["contact"] == null ? null : json["contact"],
    latitude: json["latitude"] == null ? null : json["latitude"],
    longitude: json["longitude"] == null ? null : json["longitude"],
    shortDescription: json["shortDescription"] == null ? null : json["shortDescription"],
    longDescription: json["longDescription"] == null ? null : json["longDescription"],
    fact1: json["fact1"] == null ? null : json["fact1"],
    fact2: json["fact2"] == null ? null : json["fact2"],
    fact3: json["fact3"],
    fact4: json["fact4"],
    fact5: json["fact5"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "idCountry": idCountry == null ? null : idCountry,
    "idDistrict": idDistrict == null ? null : idDistrict,
    "idCounty": idCounty == null ? null : idCounty,
    "imageStr": imageStr == null ? null : imageStr,
    "spotName": spotName == null ? null : spotName,
    "website": website == null ? null : website,
    "email": email == null ? null : email,
    "contact": contact == null ? null : contact,
    "latitude": latitude == null ? null : latitude,
    "longitude": longitude == null ? null : longitude,
    "shortDescription": shortDescription == null ? null : shortDescription,
    "longDescription": longDescription == null ? null : longDescription,
    "fact1": fact1 == null ? null : fact1,
    "fact2": fact2 == null ? null : fact2,
    "fact3": fact3,
    "fact4": fact4,
    "fact5": fact5,
  };
}
