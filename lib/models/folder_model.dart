// To parse this JSON data, do
//
//     final folder = folderFromMap(jsonString);

import 'dart:convert';

List<Folder> folderFromMap(String str) => List<Folder>.from(json.decode(str).map((x) => Folder.fromMap(x)));

String folderToMap(List<Folder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Folder {
  Folder({
    this.folderId,
    this.folderName,
    this.favorites,
  });

  int? folderId;
  String? folderName;
  List<Favorite>? favorites;

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
    folderId: json["folderId"] == null ? null : json["folderId"],
    folderName: json["folderName"] == null ? null : json["folderName"],
    favorites: json["favorites"] == null ? [] : List<Favorite>.from(json["favorites"].map((x) => Favorite.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
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
  });

  int? id;
  int? idSpot;
  int? idUser;
  String? favoriteName;
  String? imageStr;

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
    id: json["id"] == null ? null : json["id"],
    idSpot: json["idSpot"] == null ? null : json["idSpot"],
    idUser: json["idUser"] == null ? null : json["idUser"],
    favoriteName: json["favoriteName"] == null ? null : json["favoriteName"],
    imageStr: json["imageStr"] == null ? null : json["imageStr"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "idSpot": idSpot == null ? null : idSpot,
    "idUser": idUser == null ? null : idUser,
    "favoriteName": favoriteName == null ? null : favoriteName,
    "imageStr": imageStr == null ? null : imageStr,
  };
}
