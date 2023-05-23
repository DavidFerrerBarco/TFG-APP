// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

class MessagesModel {
  String status;
  List<Message> data;

  MessagesModel({
    required this.status,
    required this.data,
  });

  factory MessagesModel.fromJson(String str) =>
      MessagesModel.fromMap(json.decode(str));

  factory MessagesModel.fromMap(Map<String, dynamic> json) => MessagesModel(
        status: json["status"],
        data: List<Message>.from(json["data"].map((x) => Message.fromMap(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
