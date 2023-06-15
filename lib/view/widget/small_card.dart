import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seller_point/view/widget/big_card/big_card.dart';

import '../../model/get_order_list_model.dart';


class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final boolProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final indexProvider = StateProvider<int>((ref) => 0);
const String pendingSvg = 'assets/pending2.svg';
const String orderApprovedSvg = 'assets/exportNotes.svg';
const String orderConfirmedSvg = 'assets/conveyor.svg';
const String orderPrepared = 'assets/trolley.svg';
const String orderOnTheWay = 'assets/shipment.svg';
const String orderDelivered = 'assets/warehouse.svg';
const String newMessage = 'assets/newMessage.svg';
const String exportNotes = 'assets/exportNotes.svg';
final Widget newMessageSvg = SvgPicture.asset(
  newMessage,
  semanticsLabel: 'Acme Logo',
  width: 30.0,
  height: 35.0,
);

class SmallCard extends ConsumerWidget {
  final int index;
  final String id;
  final String orderStatus;
  final String demandNo;
  final String demandName;
  final String orderDate;
  final String deliveryDate;
  final String paymentDueDate;
  final String paymentType;
  final List<Product>  products;
  const SmallCard({
    Key? key,
    required this.index,
    required this.id,
    required this.orderStatus,
    required this.demandNo,
    required this.demandName,
    required this.orderDate,
    required this.paymentDueDate,
    required this.paymentType,
    required this.deliveryDate,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, String> orderStatusMap = {
      'pending': FlutterI18n.translate(context, "tr.order.pending"),
      'order_approved': FlutterI18n.translate(context, "tr.order.order_approved"),
      'order_confirmed': FlutterI18n.translate(context, "tr.order.order_confirmed"),
      'order_prepared' : FlutterI18n.translate(context, "tr.order.order_prepared"),
      'order_on_the_way' : FlutterI18n.translate(context, "tr.order.order_on_the_way"),
      'order_delivered' : FlutterI18n.translate(context, "tr.order.order_delivered"),
    };
    Map<String, String> statusIconMap = {
      'pending': pendingSvg,
      'order_approved': orderApprovedSvg,
      'order_confirmed': orderConfirmedSvg,
      'order_prepared': orderPrepared,
      'order_on_the_way': orderOnTheWay,
      'order_delivered': orderDelivered
    };
    //create dateTime object
    final DateTime parsedDate = DateTime.parse(orderDate);
    debugPrint('------ust_context---------$context');
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
              showDialog(
                context: context, 
                builder: ( BuildContext context) => Dialog(
                  child: BigCard(
                    id: id,
                    status: orderStatus,
                    demandName: demandName,
                    date: orderDate,
                    paymentType: paymentType,
                    demandNo: demandNo,
                    deliveryDate: deliveryDate,
                    paymentDueDate: paymentDueDate,
                    products: products
                  ),
                ),
              );              
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
                            Flexible(child: Text(FlutterI18n.translate(context, "tr.order.no") + demandNo)),
                            Flexible(
                                child: Text(FlutterI18n.translate(context, "tr.order.order_date") + formattedDate)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 16.0),
                  child: Text(demandName)
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
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text('#'),
                            ),
                            Expanded(
                              flex: 2,
                              child: AutoSizeText(
                                FlutterI18n.translate(context, "tr.order.product"),
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
                        children:  [
                          const Spacer(
                            flex: 6,
                          ),
                          Expanded(
                            flex: 9,
                            child: Text(FlutterI18n.translate(context, "tr.order.order")),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          Flexible(
                            flex: 4,
                            child: orderStatus == 'order_approved'
                            ? AutoSizeText(
                                FlutterI18n.translate(context, "tr.order.price"),
                                textDirection: TextDirection.ltr,
                                maxLines: 1
                              )
                            : AutoSizeText(
                                FlutterI18n.translate(context, "tr.order.ship"),
                                textDirection: TextDirection.ltr,
                                maxLines: 1
                              ),
                          ),
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
                for (int i = 0; i < products.length; i++)
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
                                  child: AutoSizeText(
                                    (i + 1).toString(),
                                    textDirection: TextDirection.ltr,
                                    maxLines: 1),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: AutoSizeText(
                                    products[i].name.toString(),
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
                                  child: AutoSizeText(
                                    products[i].amount.toString() + ' adet',
                                    textDirection: TextDirection.ltr,
                                    maxLines: 1
                                  ),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                 Expanded(
                                  flex: 3,
                                  child: (orderStatus == 'order_approved') 
                                  ? AutoSizeText(
                                      products[i].price.toString() + ' ₺',
                                      textDirection: TextDirection.ltr,
                                      maxLines: 1
                                   )
                                  : AutoSizeText(
                                      products[i].amount.toString() + ' adet',
                                      textDirection: TextDirection.ltr,
                                      maxLines: 1
                                    ),
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
  FutureOr<void> _dialogBuilder(
    BuildContext context, 
    id, 
    status, 
    demandName,
    date, 
    paymentType, 
    demandNo, 
    deliveryDate, 
    paymentDueDate, 
    products
  ) async {
    debugPrint('Before calling showDialog');
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: BigCard(
            id: id, 
            status: status, 
            demandName: demandName,
            date: date, 
            paymentType: paymentType, 
            demandNo: demandNo, 
            deliveryDate: deliveryDate, 
            paymentDueDate: paymentDueDate, 
            products: products
          )
        );
      }
    );
    debugPrint('------context---------$context');
    debugPrint('------after---------$Dialog');
  }
