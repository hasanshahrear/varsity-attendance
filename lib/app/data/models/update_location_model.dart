// To parse this JSON data, do
//
//     final updateLocationModel = updateLocationModelFromJson(jsonString);

import 'dart:convert';

UpdateLocationModel updateLocationModelFromJson(String str) => UpdateLocationModel.fromJson(json.decode(str));

String updateLocationModelToJson(UpdateLocationModel data) => json.encode(data.toJson());

class UpdateLocationModel {
  bool success;
  String message;

  UpdateLocationModel({
    required this.success,
    required this.message,
  });

  factory UpdateLocationModel.fromJson(Map<String, dynamic> json) => UpdateLocationModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
