import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';


class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final boolProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final indexProvider = StateProvider<int>((ref) => 0);
final String pendingSvg = 'assets/pending2.svg';
final String orderConfirmedSvg = 'assets/conveyor.svg';
final String orderApprovedSvg = 'assets/exportNotes.svg';
final String newMessage = 'assets/newMessage.svg';
final String exportNotes = 'assets/exportNotes.svg';
final Widget newMessageSvg = SvgPicture.asset(
  newMessage,
  semanticsLabel: 'Acme Logo',
  width: 30.0,
  height: 35.0,
);

class smallCard extends ConsumerWidget {
  final int index;
  final String orderStatus;
  final String demandNo;
  final String orderDate;
  final List<String> productNames;
  final List<String> amounts;
  const smallCard({
    Key? key,
    required this.index,
    required this.orderStatus,
    required this.demandNo,
    required this.amounts,
    required this.orderDate,
    required this.productNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, String> orderStatusMap = {
      'pending': 'teklif istendi',
      'order_confirmed': 'Sipariş Edildi',
      'order_approved': 'Sipariş Edildi'
    };
    Map<String, String> statusIconMap = {
      'pending': pendingSvg,
      'order_confirmed': orderConfirmedSvg,
      'order_approved': orderApprovedSvg
    };
    //create dateTime object
    final DateTime parsedDate = DateTime.parse(orderDate);
    //formating dateTime object
    String formattedDate =
        "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: InkWell(
            onTap: () {
              debugPrint(ref.watch(boolProvider).toString());
              ref.read(indexProvider.notifier).state = index;
              debugPrint(index.toString());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 15, left: 20, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: SvgPicture.asset(
                                statusIconMap[orderStatus] ?? '',
                                semanticsLabel: 'Order Status Icon',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                            Expanded(
                                flex: 15,
                                child: AutoSizeText(
                                  orderStatusMap[orderStatus] ?? '',
                                  style: Theme.of(context).textTheme.titleLarge!,
                                )),
                            Flexible(child: newMessageSvg),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text('No: $demandNo')),
                            Flexible(
                                child: Text('Sipariş Tarihi: $formattedDate')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0, top: 8.0, left: 16.0),
                  child: Text('Acil Siparis'),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Expanded(
                              flex: 1,
                              child: Text('#'),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text('Ürün'),
                            ),
                            Spacer(
                              flex: 6,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Spacer(
                            flex: 6,
                          ),
                          Expanded(
                            flex: 9,
                            child: Text('Sipariş'),
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          Expanded(
                            flex: 4,
                            child: Text('Sevk'),
                          ),
                          Spacer(
                            flex: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < productNames.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text((i + 1).toString()),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Text(productNames[i]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5, right: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Text('${amounts[i]} adet'),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                const Expanded(
                                  flex: 3,
                                  child: Text('100tl'),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          )),
    );
  }
}
