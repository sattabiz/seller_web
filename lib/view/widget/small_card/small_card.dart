import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/model/get_buyer_invoices_list_model.dart';
import '../../../view_model/buyer_invoices_view_model.dart';
import '../../../view_model/customer_addresses_view_model.dart';
import '../../../view_model/get_message_view_model.dart';
import '../../../view_model/websocket_message_view_model.dart';


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
final createMessageMapProvider = StateProvider<Map?>((ref) => {})  ;

class SmallCard extends ConsumerWidget {
  final GetInvoicesModel? invoice;
  final String className;
  final String id;
  final String messageId;
  final Map<String, dynamic> createMessageMap;
  final String status;
  final Widget bodyHeader;
  final Widget headerSmallCard;
  final Widget smallCardTable;
  final Widget bigCard;


  const SmallCard({
    Key? key,
    required this.className,
    this.invoice,
    required this.id,
    required this.messageId,
    required this.createMessageMap,
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
            onTap: () async{
              if(className == "invoice"){
                ref.read(invoiceIndexProvider.notifier).state = invoice!;
                ref.watch(invoiceCurrenciesIndexProvider);
              }
              //debugPrint(createMessageMap.toString());
              ref.read(idProvider.notifier).state = id;
              ref.read(messageIdProvider.notifier).state = messageId;
              ref.read(createMessageMapProvider.notifier).state = createMessageMap;
              ref.watch(getMessageProvider);
              ref.read(messagePipeProvider.notifier).state = 1; ////for open the subscription
              ref.watch(webSocketProvider);
              showDialog(
                context: context,
                barrierDismissible: false,
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