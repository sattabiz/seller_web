import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketMessageModel {
  Map<String, dynamic>? identifier;
  Message2? message;

  WebSocketMessageModel({
    this.identifier,
    this.message,
  });

  factory WebSocketMessageModel.fromJson(String str) =>
      WebSocketMessageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WebSocketMessageModel.fromMap(Map<String, dynamic> json) =>
      WebSocketMessageModel(
        identifier: json["identifier"] == null
            ? null
            : Map<String, dynamic>.from(jsonDecode(json["identifier"])),
        message: json["message"] == null ? null : Message2.fromMap(json["message"]),
      );

  Map<String, dynamic> toMap() => {
        "identifier": identifier == null ? null : jsonEncode(identifier),
        "message": message?.toMap(),
      };
}

class Message2 {
  String? body;
  int? id;
  int? userId;
  String? user;
  String? time;

  Message2({
    this.body,
    this.id,
    this.userId,
    this.user,
    this.time,
  });

  factory Message2.fromJson(String str) => Message2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message2.fromMap(Map<String, dynamic> json) => Message2(
        body: json["body"],
        id: json["id"],
        userId: json["user_id"],
        user: json["user"],
        time: json["time"],
      );

  Map<String, dynamic> toMap() => {
        "body": body,
        "user_id": userId,
        "user": user,
        "time": time,
      };
}