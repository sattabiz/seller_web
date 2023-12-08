import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/index.dart';
import 'package:seller_point/view/widget/big_card%20/responsive/resposive_bigcard.dart';
import '../../../../model/get_current_user_info_model.dart';
import '../../../../utils/widget_helper.dart';
import '../../../../view_model/create_message_view_model.dart';
import '../../../../view_model/get_message_view_model.dart';
import '../../../../view_model/list_messages_view_model.dart';
import '../../../../view_model/websocket_message_view_model.dart';

final readMessageProvider = StateProvider<String?>((ref) => '');

class ChatBox extends ConsumerStatefulWidget {
  const ChatBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatBoxState();
}

class _ChatBoxState extends ConsumerState<ChatBox> {
  TextEditingController textEditingController = TextEditingController();
  ScrollController messageController = ScrollController();

  void onSubmitted(String value) {
    textEditingController.clear();
    ref.read(readMessageProvider.notifier).state = value;
    ref.watch(createMessageProvider);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //  CurrentUserInfoModel userInfo = ref.watch(userIdProvider);
    // ref.watch(webSocketProvider);
    final liveChats = ref.watch(liveChatProvider).reversed.toList();
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30, top: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: messageController,
                      itemCount: liveChats.length,
                      physics: const ClampingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (context, index) {
                        return liveChats[index].userID == 0
                            ? Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10, top: 10),
                                child: Text(
                                  "${liveChats[index].createdAt.toString()}   ${liveChats[index].body.toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                ))
                            : Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Align(
                                  alignment: (liveChats[index].userID == 1
                                      ? Alignment.topRight
                                      : Alignment.topLeft),
                                  child: Container(
                                    constraints: BoxConstraints.tightFor(
                                        width: ResponsiveBigCard.isMobile
                                            ? width * 0.5
                                            : width * 0.15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(8),
                                        topRight: const Radius.circular(8),
                                        bottomLeft:
                                            (liveChats[index].userID == 1
                                                ? const Radius.circular(10)
                                                : const Radius.circular(0)),
                                        bottomRight:
                                            (liveChats[index].userID == 1
                                                ? const Radius.circular(0)
                                                : const Radius.circular(10)),
                                      ),
                                      color: (liveChats[index].userID == 1
                                          ? Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant
                                          : Theme.of(context)
                                              .colorScheme
                                              .primaryContainer),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            liveChats[index].user.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      liveChats[index].userID ==
                                                              1
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .secondary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            liveChats[index].body.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.2,
                                                  height: 1.5,
                                                ),
                                            maxLines: double.maxFinite.floor(),
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            liveChats[index]
                                                .createdAt
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
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
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30, top: 10),
          child: Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: TextField(
              controller: textEditingController,
              cursorColor: Theme.of(context).colorScheme.onBackground,
              decoration: InputDecoration(
                hintText: "Bir Mesaj Yazın...",
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
  }
}
