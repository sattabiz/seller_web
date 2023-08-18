import 'package:flutter/material.dart';
import '../../../../utils/widget_helper.dart';

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
  ScrollController messageController = ScrollController();

  void scrollToMaxExtent() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messageController.animateTo(
        messageController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeIn,
      );
    });
  }

  void onSubmitted(String value) {
    setState(() {
      messages.add(ChatMessage(messageContent: value, messageType: "receiver"));
      textEditingController.clear();
      scrollToMaxExtent();
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
    final time = DateTime.now().toUtc();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30,top: 10),
          child: Container(
            // width: width,
            height: height * 0.68,
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
                  height: 360,
                  child: ListView.builder(
                    controller: messageController,
                    itemCount: messages.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxWidth: double.infinity,
                          minWidth: 150,
                          minHeight: 70,
                          maxHeight: double.infinity),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Align(
                           alignment: (messages[index].messageType == "receiver"?Alignment.topRight:Alignment.topLeft),
                          child: Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(8),
                                topRight: const Radius.circular(8),
                                bottomLeft: (messages[index].messageType == "receiver"?Radius.circular(10):Radius.circular(0)),
                                bottomRight: (messages[index].messageType == "receiver"?Radius.circular(0):Radius.circular(10)),
                              ),
                              color: (messages[index].messageType  == "receiver"?Theme.of(context).colorScheme.surfaceVariant:Theme.of(context).colorScheme.primaryContainer),
                            ),
                            padding: const  EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    messages[index].messageContent, 
                                    style: Theme.of(context).textTheme.bodySmall,
                                    maxLines: double.maxFinite.floor(), 
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    formattedTime(time.toString()), 
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
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                // filled: true,
                // fillColor: Theme.of(context).colorScheme.onPrimary,
                hintText: "  Write message...",
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
