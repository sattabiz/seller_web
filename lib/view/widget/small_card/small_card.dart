import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../view_model/get_message_view_model.dart';


class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final boolProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final proposalIndexProvider = StateProvider.autoDispose<int?>((ref) => 1);
final idProvider = StateProvider<String?>((ref) => '');   //for all post service
final messageIdProvider = StateProvider<String?>((ref) => '')  ;

final Widget newMessageSvg = SvgPicture.asset(
  'assets/newMessage.svg',
  width: 22.0,
  height: 20.0,
);

class SmallCard extends ConsumerWidget {
  final String className;
  final String id;
  final String messageId;
  final String status;
  final Widget bodyHeader;
  final Widget headerSmallCard;
  final Widget smallCardTable;
  final Widget bigCard;


  const SmallCard({
    Key? key,
    required this.className,
    required this.id,
    required this.messageId,
    required this.status,
    required this.bodyHeader,
    required this.headerSmallCard,
    required this.smallCardTable,
    required this.bigCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          child: InkWell(
            onTap: () {
              ref.read(idProvider.notifier).state = id;
              ref.read(messageIdProvider.notifier).state = messageId;
              ref.watch(getMessageProvider);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Consumer(
                    builder: (context, ref, _) {
                      return Dialog(
                        child: bigCard,
                      );
                    },
                  );
                }
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerSmallCard,
                bodyHeader,
                const SizedBox(height: 4),
                smallCardTable,
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
    );
  }
}