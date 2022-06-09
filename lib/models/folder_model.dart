// To parse this JSON data, do
//
//     final folder = folderFromMap(jsonString);

import 'dart:convert';

List<Folder> folderFromMap(String str) => List<Folder>.from(json.decode(str).map((x) => Folder.fromMap(x)));

String folderToMap(List<Folder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Folder {
  Folder({
    this.id,
    this.folderId,
    this.folderName,
    this.favorites,
  });

  int? id;
  int? folderId;
  String? folderName;
  List<Favorite>? favorites;

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
    id: json["id"] == null ? null : json["id"],
    folderId: json["folderId"] == null ? null : json["folderId"],
    folderName: json["folderName"] == null ? null : json["folderName"],
    favorites: json["favorites"] == null ? [] : List<Favorite>.from(json["favorites"].map((x) => Favorite.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "folderId": folderId == null ? null : folderId,
    "folderName": folderName == null ? null : folderName,
    "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x.toMap())),
  };
}

List<Favorite> favoriteFromMap(String str) => List<Favorite>.from(json.decode(str).map((x) => Favorite.fromMap(x)));

class Favorite {
  Favorite({
    this.id,
    this.idSpot,
    this.idUser,
    this.favoriteName,
    this.imageStr,
    this.idCountry,
    this.idDistrict,
    this.idCounty,
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
  int? idSpot;
  int? idUser;
  String? favoriteName;
  String? imageStr;
  int? idCountry;
  int? idDistrict;
  int? idCounty;
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

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
    id: json["id"] == null ? null : json["id"],
    idSpot: json["idSpot"] == null ? null : json["idSpot"],
    idUser: json["idUser"] == null ? null : json["idUser"],
    favoriteName: json["favoriteName"] == null ? null : json["favoriteName"],
    imageStr: json["imageStr"] == null ? null : json["imageStr"],
    idCountry: json["idCountry"] == null ? null : json["idCountry"],
    idDistrict: json["idDistrict"] == null ? null : json["idDistrict"],
    idCounty: json["idCounty"] == null ? null : json["idCounty"],
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
    fact3: json["fact3"] == null ? null : json["fact3"],
    fact4: json["fact4"] == null ? null : json["fact4"],
    fact5: json["fact5"] == null ? null : json["fact5"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "idSpot": idSpot == null ? null : idSpot,
    "idUser": idUser == null ? null : idUser,
    "favoriteName": favoriteName == null ? null : favoriteName,
    "imageStr": imageStr == null ? null : imageStr,
  };
}
