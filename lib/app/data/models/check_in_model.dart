// To parse this JSON data, do
//
//     final checkInModel = checkInModelFromJson(jsonString);

import 'dart:convert';

CheckInModel checkInModelFromJson(String str) => CheckInModel.fromJson(json.decode(str));

String checkInModelToJson(CheckInModel data) => json.encode(data.toJson());

class CheckInModel {
  bool success;
  String message;

  CheckInModel({
    required this.success,
    required this.message,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
