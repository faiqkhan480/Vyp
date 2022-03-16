// To parse this JSON data, do
//
//     final folder = folderFromMap(jsonString);

import 'dart:convert';

List<Folder> folderFromMap(String str) => List<Folder>.from(json.decode(str).map((x) => Folder.fromMap(x)));

String folderToMap(List<Folder> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Folder {
  Folder({
    this.id,
    this.folderName,
    this.idUser,
  });

  int? id;
  String? folderName;
  int? idUser;

  factory Folder.fromMap(Map<String, dynamic> json) => Folder(
    id: json["id"] == null ? null : json["id"],
    folderName: json["folderName"] == null ? null : json["folderName"],
    idUser: json["idUser"] == null ? null : json["idUser"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "folderName": folderName == null ? null : folderName,
    "idUser": idUser == null ? null : idUser,
  };
}
