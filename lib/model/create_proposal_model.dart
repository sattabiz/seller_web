// To parse this JSON data, do
//
//     final getOrderlistModel = getOrderlistModelFromMap(jsonString);

import 'dart:convert';

class CreateProposalModel {
    int? status;
    String? jwt;
    String? responseMessage;
    String? requestId;

    CreateProposalModel({
        this.status,
        this.jwt,
        this.responseMessage,
        this.requestId,
    });

    factory CreateProposalModel.fromJson(String str) => CreateProposalModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CreateProposalModel.fromMap(Map<String, dynamic> json) => CreateProposalModel(
        status: json["status"],
        jwt: json["jwt"],
        responseMessage: json["response_message"],
        requestId: json["request_id"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "jwt": jwt,
        "response_message": responseMessage,
        "request_id": requestId,
    };
}
