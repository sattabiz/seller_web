import 'package:flutter/material.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}


class ChatBox extends StatefulWidget {
  const ChatBox({ Key? key }) : super(key: key);

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Siparis yolda", messageType: "receiver"),
    ChatMessage(messageContent: "Elinizde baska urun var mi?", messageType: "sender"),
  ];

  TextEditingController textEditingController = TextEditingController();

  void onSubmitted(String value) {
    setState(() {
      messages.add(ChatMessage(messageContent: value, messageType: "receiver"));
      textEditingController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30,top: 10),
          child: Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                 Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "10.02 Siparis Haluk Cetin tarafindan onaylandi",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 300,
                  height: 310,
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        // width: 150,
                        // height: 50,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Align(
                           alignment: (messages[index].messageType == "receiver"?Alignment.topRight:Alignment.topLeft),
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (messages[index].messageType  == "receiver"?Theme.of(context).colorScheme.surfaceVariant:Theme.of(context).colorScheme.primaryContainer),
                            ),
                            padding: const  EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    messages[index].messageContent, 
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "12:00", 
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30,top: 10),
          child: Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                hintText: "Write message...",
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
                border: InputBorder.none
              ),
              onSubmitted: (value) {
                onSubmitted(value);
              },
            ),
          ),
        ),
      ],
      
    );
  }
}
