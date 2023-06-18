import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../model/get_order_list_model.dart';
import 'big_card/big_card.dart';
import 'countdown_date.dart';

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final boolProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

const String newMessage = 'assets/newMessage.svg';
final Widget newMessageSvg = SvgPicture.asset(
  newMessage,
  semanticsLabel: 'Acme Logo',
  width: 30.0,
  height: 35.0,
);

class SmallCard extends ConsumerWidget {
  final int index;
  final String className;
  final String id;
  final String status;
  final String bodyHeader;
  final String headerDate;
  final String paymentType; //info_2 (column1)
  final String demandNo; //info_3 (column1)
  final String ?deliveryDate; //info_1 (column2)
  final String ?paymentDueDate; //info_2 (column2)
  final List bodyList;

  const SmallCard({
    Key? key,
    required this.index,
    required this.className,
    required this.id,
    required this.status,
    required this.bodyHeader,
    required this.headerDate,
    required this.paymentType,
    required this.demandNo,
    this.deliveryDate,
    this.paymentDueDate,
    required this.bodyList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, String> orderStatusMap = {
      'pending': FlutterI18n.translate(context, "tr.proposal.pending"),
      'replied': FlutterI18n.translate(context, "tr.proposal.replied"),
      'proposal_stvs': FlutterI18n.translate(context, "tr.proposal.replied"),
      'order_approved':
          FlutterI18n.translate(context, "tr.order.order_approved"),
      'order_confirmed':
          FlutterI18n.translate(context, "tr.order.order_confirmed"),
      'order_prepared':
          FlutterI18n.translate(context, "tr.order.order_prepared"),
      'order_on_the_way':
          FlutterI18n.translate(context, "tr.order.order_on_the_way"),
      'order_delivered':
          FlutterI18n.translate(context, "tr.order.order_delivered"),
      'invoice_paid': FlutterI18n.translate(context, "tr.invoice.invoice_paid"),
      'invoice_discounted':
          FlutterI18n.translate(context, "tr.invoice.invoice_discounted"),
      'invoice_approved_dbs':
          FlutterI18n.translate(context, "tr.invoice.invoice_approved_dbs"),
      'invoice_pending':
          FlutterI18n.translate(context, "tr.invoice.invoice_pending"),
    };
    // Map<String, Widget> bilge = {
    //   'order': ,
    //   'proposal':
    // };

    Map<String, String> bodyListMap = {
      'pending': FlutterI18n.translate(context, "tr.order.ship"),
      'order_approved': FlutterI18n.translate(context, "tr.order.price"),
      'order_confirmed': FlutterI18n.translate(context, "tr.order.ship"),
      'order_prepared': FlutterI18n.translate(context, "tr.order.ship"),
      'order_on_the_way': FlutterI18n.translate(context, "tr.order.ship"),
      'order_delivered': FlutterI18n.translate(context, "tr.order.ship"),
      'invoice_paid': FlutterI18n.translate(context, "tr.invoice.price"),
      'invoice_discounted': FlutterI18n.translate(context, "tr.invoice.price"),
      'invoice_approved_dbs':
          FlutterI18n.translate(context, "tr.invoice.price"),
      'invoice_pending': FlutterI18n.translate(context, "tr.invoice.price"),
    };
    Map<String, String> statusIconMap = {
      'pending': 'assets/pending2.svg',
      'replied': 'assets/exportNotes.svg',
      'proposal_stvs': 'assets/exportNotes.svg',
      // 'order_pending': 'assets/exportNotes.svg',
      'order_approved': 'assets/exportNotes.svg',
      'order_confirmed': 'assets/conveyor.svg',
      'order_prepared': 'assets/trolley.svg',
      'order_on_the_way': 'assets/shipment.svg',
      'order_delivered': 'assets/warehouse.svg',
      'invoice_paid': 'assets/paid.svg',
      'invoice_discounted': 'assets/paymentProcess.svg',
      'invoice_approved_dbs': 'assets/DBS.svg',
      'invoice_pending': 'assets/pending.svg',
    };


    DateTime parsedDate = DateTime.parse(headerDate);
    String formattedDate =
        "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";

    Map<String, String> headerIdMap= {
      'proposal': FlutterI18n.translate(context, "tr.order.no" ) + id,
      'order': FlutterI18n.translate(context, "tr.order.no" ) + id,
      'invoice': FlutterI18n.translate(context, "tr.invoice.invoice_date") + formattedDate,
    };

    Map<String, Widget> headerDateMap = {
      'order': Text(FlutterI18n.translate(context, "tr.order.order_date") +
          formattedDate),
      'proposal': CountdownDate(headerDate: headerDate),
      'invoice': const SizedBox(width: 1,),
    };

    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Consumer(
                      builder: (context, ref, _) {
                        return Dialog(
                          child: BigCard(
                              id: id,
                              className: className,
                              status: status,
                              svgPath: statusIconMap[status] ?? '',
                              topic: bodyHeader,
                              date: headerDate,
                              paymentType: paymentType,
                              demandNo: demandNo,
                              deliveryDate: deliveryDate,
                              paymentDueDate: paymentDueDate,
                              statusMap: orderStatusMap[status],
                              tableList: bodyList),
                        );
                      },
                    );
                  });
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
                                statusIconMap[status] ?? '',
                                semanticsLabel: 'Order Status Icon',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                            Expanded(
                                flex: 15,
                                child: AutoSizeText(
                                  orderStatusMap[status] ?? '',
                                  style:
                                      Theme.of(context).textTheme.titleLarge!,
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
                            Flexible(
                                child: AutoSizeText(headerIdMap[className] ?? "-")),
                            Flexible(
                                // header date degiskeni
                                child: headerDateMap[className] ?? Text("-")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, top: 8.0, left: 16.0),
                    child: Text(bodyHeader)),
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
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text('#'),
                            ),
                            Expanded(
                              flex: 2,
                              child: AutoSizeText(
                                FlutterI18n.translate(
                                    context, "tr.order.product"),
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                              ),
                            ),
                            const Spacer(
                              flex: 6,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Spacer(
                            flex: 6,
                          ),
                          Expanded(
                            flex: 9,
                            child: status == "order_delivered"
                                ? Text(FlutterI18n.translate(
                                    context, "tr.order.order"))
                                : Text(FlutterI18n.translate(context,
                                    "tr.order.amount")), //buraya bakilacak
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          Flexible(
                              flex: 4,
                              child: AutoSizeText(
                                bodyListMap[status] ?? '',
                              )),
                          const Spacer(
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
                for (int i = 0; i < bodyList.length; i++)
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
                                  child: AutoSizeText((i + 1).toString(),
                                      textDirection: TextDirection.ltr,
                                      maxLines: 1),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: className == 'order' || className=='invoice'
                                      ? AutoSizeText(
                                          bodyList[i].name.toString(),
                                          textDirection: TextDirection.ltr,
                                          maxLines: 1)
                                      : AutoSizeText(
                                          bodyList[i].productName.toString(),
                                          textDirection: TextDirection.ltr,
                                          maxLines: 1),
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
                                  child: (className=='invoice')
                                      ? AutoSizeText(
                                          bodyList[i].shippedAmount.toString() + 'adet',
                                          textDirection: TextDirection.ltr,
                                          maxLines: 1)
                                      : AutoSizeText(
                                          bodyList[i].amount.toString() +
                                              ' adet',
                                          textDirection: TextDirection.ltr,
                                          maxLines: 1),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: (status == 'order_approved' ||
                                          className == 'proposal'|| className=='invoice')
                                      ? AutoSizeText(
                                          bodyList[i].price.toString() + ' ₺',
                                          textDirection: TextDirection.ltr,
                                          maxLines: 1)
                                      : AutoSizeText(
                                          bodyList[i].amount.toString() +
                                              ' adet',
                                          textDirection: TextDirection.ltr,
                                          maxLines: 1),
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

// FutureOr<void> _dialogBuilder(
//   BuildContext context,
//   id,
//   status,
//   demandName,
//   date,
//   paymentType,
//   demandNo,
//   deliveryDate,
//   paymentDueDate,
//   products

// ) async {
//   await showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         child: BigCard(
//           key: context,
//           id: id,
//           status: status,
//           demandName: demandName,
//           date: date,
//           paymentType: paymentType,
//           demandNo: demandNo,
//           deliveryDate: deliveryDate,
//           paymentDueDate: paymentDueDate,
//           products: products
//         )
//       );
//     }
//   );
//   debugPrint('------context---------$context');
//   debugPrint('------after---------$Dialog');
// }
