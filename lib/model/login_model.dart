class LoginModel {
/*
{
  "status": 200,
  "jwt": "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJjY2JlMjg1Zi1jYTU5LTQzZmQtOTE0NC0zMmFhZDllMTNjYzciLCJzdWIiOiIxMzY3Iiwic2NwIjoiYXBpX3VzZXIiLCJhdWQiOm51bGwsImlhdCI6MTYyOTYyMDE2MCwiZXhwIjoxNjI5NzA2NTYwfQ.qftHtDJu9IexTOCprLsRvhXuGT__UIPvIl95DYxtdEs",
  "response_message": "Basarili giris.",
  "request_id": "9c656770-3b24-45d0-a41d-09d885372def"
} 
*/

  int? status;
  String? jwt;
  String? responseMessage;
  String? requestId;

  LoginModel({
    this.status,
    this.jwt,
    this.responseMessage,
    this.requestId,
  });
  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toInt();
    jwt = json['jwt']?.toString();
    responseMessage = json['response_message']?.toString();
    requestId = json['request_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['jwt'] = jwt;
    data['response_message'] = responseMessage;
    data['request_id'] = requestId;
    return data;
  }
}