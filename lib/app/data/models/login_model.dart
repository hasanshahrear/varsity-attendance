// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  String? token;
  bool? location;
  User? user;

  LoginModel({
    this.success,
    this.message,
    this.token,
    this.location,
    this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    message: json["message"],
    token: json["token"],
    location: json["location"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "token": token,
    "location": location,
    "user": user?.toJson(),
  };
}

class User {
  String? firstName;
  String? lastName;
  String? phone;
  String? designation;
  String? officeAddress;

  User({
    this.firstName,
    this.lastName,
    this.phone,
    this.designation,
    this.officeAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    designation: json["designation"],
    officeAddress: json["office_address"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "designation": designation,
    "office_address": officeAddress,
  };
}
