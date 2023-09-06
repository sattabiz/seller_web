import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/widget_helper.dart';
import '../../../../view_model/create_message_view_model.dart';
import '../../../../view_model/get_message_view_model.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
final readMessageProvider = StateProvider<String?>((ref) => '')  ;

class ChatBox extends ConsumerStatefulWidget {
  const ChatBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatBoxState();
}

class _ChatBoxState extends ConsumerState<ChatBox> {

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
      // messages.add(ChatMessage(messageContent: value, messageType: "receiver"));
      textEditingController.clear();
      //scrollToMaxExtent();
      ref.read(readMessageProvider.notifier).state = value;
      ref.watch(createMessageProvider);
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

    // List<ChatMessage> messages = [
    //   ChatMessage(messageContent: "Siparis yolda", messageType: "receiver"),
    //   ChatMessage(
    //       messageContent: "Elinizde baska urun var mi?", messageType: "sender"),
    // ];



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final messageProvider = ref.watch(getMessageProvider);
    return messageProvider.when(
      data: (message) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      // height: height * 0.57,
                      constraints:
                          BoxConstraints(minHeight: 200, maxHeight: height * 0.57),
                      child: ListView.builder(
                        controller: messageController,
                        itemCount: message.messages!.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return 
                          message.messages![index].userID == 0
                          ? Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            child: Text(
                              "${formettedDateAndTime(message.messages![index].createdAt.toString())}   ${message.messages![index].body.toString()}",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          )
                          : Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: (message.messages![index].userID == 1
                                  ? Alignment.topRight
                                  : Alignment.topLeft),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(8),
                                    topRight: const Radius.circular(8),
                                    bottomLeft:
                                        (message.messages![index].userID == 1
                                            ? const Radius.circular(10)
                                            : const Radius.circular(0)),
                                    bottomRight:
                                        (message.messages![index].userID == 1
                                            ? const Radius.circular(0)
                                            : const Radius.circular(10)),
                                  ),
                                  color: (message.messages![index].userID == 1
                                      ? Theme.of(context).colorScheme.surfaceVariant
                                      : Theme.of(context).colorScheme.primaryContainer
                                  ),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        message.messages![index].user.toString(),
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        message.messages![index].body.toString(),
                                        style:
                                            Theme.of(context).textTheme.bodySmall,
                                        maxLines: double.maxFinite.floor(),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        formattedTime(message.messages![index].createdAt.toString()),
                                        style:
                                            Theme.of(context).textTheme.bodySmall,
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
              padding: const EdgeInsets.only(right: 30, top: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: TextField(
                  controller: textEditingController,
                  cursorColor: Theme.of(context).colorScheme.onBackground,
                  decoration: InputDecoration(
                    hintText: "  Write message...",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  ),
                  onSubmitted: (value) {
                    onSubmitted(value);
                  },
                ),
              ),
            ),
          ],
        );

      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const Center(child: CircularProgressIndicator()),
    );


  }
}
