/*
 *  ====================================================
 *  Copyright (c) 2021. Daniel Nazarian
 *
 *  Do not use, edit or distribute without explicit permission.
 *  Questions, comments or concerns -> email dnaz@danielnazarian.com
 * ======================================================
 */

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

// ===============================================================================
// USER ==========================================================================
// ===============================================================================

class User {
  String? id;
  String? email;
  String? token;
  String? firstName;
  String? lastName;

  User({
    this.id,
    this.email,
    this.token,
    this.firstName,
    this.lastName,
  });

  User copyWith({
    String? id,
    String? email,
    String? token,
    String? firstName,
    String? lastName,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        token: token ?? this.token,
      );

  // ==================================
  // LOGGED IN / TOKEN
  //
  bool get loggedIn {
    if (token != "") {
      // TOKEN SAVED -- logged in
      return true;
    } else {
      // NO TOKEN SAVED -- not logged in
      return false;
    }
  }

  // ==================================
  // JSON
  //
  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "token": token,
      };
}
