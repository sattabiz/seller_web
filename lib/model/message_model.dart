import 'dart:convert';

class GetMessageModel {
    int? status;
    String? responseMessage;
    int? messageRoomId;
    List<Message>? messages;

    GetMessageModel({
        this.status,
        this.responseMessage,
        this.messageRoomId,
        this.messages,
    });

    factory GetMessageModel.fromJson(String str) => GetMessageModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetMessageModel.fromMap(Map<String, dynamic> json) => GetMessageModel(
        status: json["status"],
        responseMessage: json["response_message"],
        messageRoomId: json["message_room_id"],
        messages: json["messages"] == null ? [] : List<Message>.from(json["messages"]!.map((x) => Message.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "response_message": responseMessage,
        "message_room_id": messageRoomId,
        "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toMap())),
    };
}

class Message {
    int? id;
    String? body;
    int? userID;
    String? user;
    String? createdAt;

    Message({
        this.id,
        this.body,
        this.userID,
        this.user,
        this.createdAt,
    });

    factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["id"],
        body: json["body"],
        userID: json['user_id'],
        user: json["user"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "body": body,
        "user": user,
        "created_at": createdAt,
    };
}
