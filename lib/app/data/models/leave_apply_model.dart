// To parse this JSON data, do
//
//     final leaveApplyModel = leaveApplyModelFromJson(jsonString);

import 'dart:convert';

LeaveApplyModel leaveApplyModelFromJson(String str) => LeaveApplyModel.fromJson(json.decode(str));

String leaveApplyModelToJson(LeaveApplyModel data) => json.encode(data.toJson());

class LeaveApplyModel {
  bool success;
  String message;

  LeaveApplyModel({
    required this.success,
    required this.message,
  });

  factory LeaveApplyModel.fromJson(Map<String, dynamic> json) => LeaveApplyModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
