import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/model/message_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../model/web_socket_message_model.dart';
import '../storage/jwt_storage.dart';
import 'get_message_view_model.dart';
import 'list_messages_view_model.dart';

final webSocketProvider = StreamProvider.autoDispose<String>((ref) async* {
  final _jwt = await jwtStorageService().getJwtData();
  debugPrint(_jwt);
  final socket = WebSocketChannel.connect(
      Uri.parse('wss://test.satta.biz/cable?jwt=$_jwt'));
  int? messageRoomIdAsyncValue = await ref.watch(messageRoomIdProvider);

  //print(socket);
  if (ref.watch(messagePipeProvider) == 1 && ref.watch(messageRoomIdProvider) != 0 ) {
    //for subscription
    final request = {
      "command": "subscribe",
      "identifier":
          "{\"channel\":\"MessageRoomChannel\",\"message_room_id\":$messageRoomIdAsyncValue}"
    };
    socket.sink.add(json.encode(request));
    //print(socket.stream);
    await for (final message in socket.stream) {
      //print(message);
      if (message.toString().contains('"body"')) {
        WebSocketMessageModel webSocketAsyncValue =
            WebSocketMessageModel.fromMap(json.decode(message!));
        Message lastMessage = Message(
          id: webSocketAsyncValue.message!.id,
          body: webSocketAsyncValue.message!.body,
          createdAt: webSocketAsyncValue.message!.time,
          user: webSocketAsyncValue.message!.user,
          userID: webSocketAsyncValue.message!.userId,
        );
        //debugPrint("------------------------------------------------------");
        //debugPrint(currentUserInfoModel.message!.body);
        ref.read(liveChatProvider.notifier).addMessage(lastMessage);
      }
    }
  } else if (ref.watch(messagePipeProvider) == 2) {
    //for unsubscription
    socket.sink.close();
    socket.sink.add(json.encode({
      "command": "unsubscribe",
      "identifier":
          "{\"channel\":\"MessageRoomChannel\",\"message_room_id\":$messageRoomIdAsyncValue}"
    }));
    socket.sink.close();
  } else {}
});

final messagePipeProvider = StateProvider<int?>((ref) {
  //for open or close websocketProvider's subscription if-else part
  return 0;
});
