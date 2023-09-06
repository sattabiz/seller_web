/* import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../storage/jwt_storage.dart';

final chatProvider = StreamProvider<String>((ref) async* {
// Connect to an API using sockets, and decode the output
final _jwt = await jwtStorageService().getJwtData();
debugPrint(_jwt);
final socket = WebSocketChannel.connect(Uri.parse('ws://192.168.1.234:8001/cable?jwt=eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzMDQ2OTZkNC0xYjk0LTQzYmEtYjJmYi1iZGVmMGMxZDdmZTciLCJzdWIiOiIxIiwic2NwIjoiYXBpX3VzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY5NDAwNDUxMiwiZXhwIjoxNjk0MDkwOTEyfQ.UUqaWAl7KddfVkq_PqqYaWWKWnolPo3KhbJx7HvaeNQ'));
final socket2 = WebSocketChannel.connect(Uri.parse('ws://192.168.1.234:8001/cable?jwt=eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzMDQ2OTZkNC0xYjk0LTQzYmEtYjJmYi1iZGVmMGMxZDdmZTciLCJzdWIiOiIxIiwic2NwIjoiYXBpX3VzZXIiLCJhdWQiOm51bGwsImlhdCI6MTY5NDAwNDUxMiwiZXhwIjoxNjk0MDkwOTEyfQ.UUqaWAl7KddfVkq_PqqYaWWKWnolPo3KhbJx7HvaeNQ'));

ref.onDispose(socket.sink.close);


final request = {
"command": "subscribe",
"identifier": "{\"channel\":\"MessageRoomChannel\",\"message_room_id\":144}"
}
;
socket.sink.add(json.encode(request));
socket2.sink.add(json.encode(request));
/* socket.sink.add(json.encode({
"command": "unsubscribe",
"identifier": "{\"channel\":\"MessageRoomChannel\",\"message_room_id\":144}"
})); */
await for (final message in socket.stream) {
// Sadece mesajları al ve işle
print(message);
yield message.toString();
}
}); */