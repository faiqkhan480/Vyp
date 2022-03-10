// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.nationality,
    this.email,
    this.birthday,
    this.phoneNumber,
    this.confirmed,
  });

  int? id;
  String? firstName;
  String? lastName;
  int? nationality;
  String? email;
  DateTime? birthday;
  String? phoneNumber;
  bool? confirmed;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    nationality: json["nationality"] == null ? null : json["nationality"],
    email: json["email"] == null ? null : json["email"],
    birthday: json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
    phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
    confirmed: json["confirmed"] == null ? null : json["confirmed"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "nationality": nationality == null ? null : nationality,
    "email": email == null ? null : email,
    "birthday": birthday == null ? null : birthday!.toIso8601String(),
    "phoneNumber": phoneNumber == null ? null : phoneNumber,
    "confirmed": confirmed == null ? null : confirmed,
  };
}
