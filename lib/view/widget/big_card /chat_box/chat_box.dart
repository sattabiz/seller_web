// import 'package:flutter/material.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:uuid/uuid.dart';

// class ChatBox extends StatelessWidget {
//  ChatBox({ Key? key }) : super(key: key);

//  List<types.Message> _messages = [];
//   final _user = const types.User(
//     id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
//   );

//   void _handleSendPressed(types.PartialText message) {
//     final textMessage = types.TextMessage(
//       author: _user,
//       createdAt: DateTime.now().millisecondsSinceEpoch,
//       id: const Uuid().v4(),
//       text: message.text,
//     );
//   }

//   @override
//   Widget build(BuildContext context){
    
//     return Chat(
//       messages: _messages,
//       onSendPressed: (message) {
//         _messages = [..._messages];
//       },
//       user: _user,

//     );
//   }
// }