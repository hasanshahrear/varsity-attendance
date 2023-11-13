// To parse this JSON data, do
//
//     final checkOutModel = checkOutModelFromJson(jsonString);

import 'dart:convert';

CheckOutModel checkOutModelFromJson(String str) => CheckOutModel.fromJson(json.decode(str));

String checkOutModelToJson(CheckOutModel data) => json.encode(data.toJson());

class CheckOutModel {
  bool success;
  String message;

  CheckOutModel({
    required this.success,
    required this.message,
  });

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
