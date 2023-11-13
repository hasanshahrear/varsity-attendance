// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  LocationModel({
    this.success,
    this.statusCode,
    this.message,
    this.data,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  double? longitude;
  double? latitude;

  Data({
    this.longitude,
    this.latitude,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
  };
}
