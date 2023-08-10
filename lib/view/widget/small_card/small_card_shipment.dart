import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/widget_helper.dart';
import '../../../view_model/shipment_delivered_view_model.dart';
import '../../../view_model/provider_controller.dart';
import '../big_card /big_card.dart';
import '../big_card /buttons/button_widget.dart';
import 'body/body_header.dart';
import 'body/body_proposal.dart';
import 'body/body_shipment.dart';
import 'body/list_header_shipment.dart';
import 'header/header_shipment.dart';

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final boolProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());
    final shipmentIndexProvider = StateProvider<String?>((ref) => '');

const String newMessage = 'assets/newMessage.svg';
final Widget newMessageSvg = SvgPicture.asset(
  newMessage,
  semanticsLabel: 'Acme Logo',
  width: 22.0,
  height: 20.0,
);

class SmallCardShipment extends ConsumerWidget {
  final int index;
  final String className;
  final String id;
  final String status;
  final String bodyHeader;
  final String headerDate;
  final String ?paymentType; //info_2 (column1) 
  final String ?demandNo; //info_3 (column1)
  final String ?deliveryDate; //info_1 (column2)
  final String ?paymentDueDate; //info_2 (column2)
  final String ?carrier;
  final String ?trackingNo;
  final Widget ?infoWidget;
  final List bodyList;
  final Widget infoBoxWidget;

  const SmallCardShipment({
    Key? key,
    required this.index,
    required this.className,
    required this.id,
    required this.status,
    required this.bodyHeader,
    required this.headerDate,
    this.paymentType,
    this.demandNo,
    this.deliveryDate,
    this.paymentDueDate,
    this.carrier,
    this.trackingNo,
    this.infoWidget, 
    required this.bodyList,
    required this.infoBoxWidget,
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
              ref.read(shipmentIndexProvider.notifier).state=id;
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
                            statusMap: FlutterI18n.translate(context, "tr.$className.$status"),
                            infoBoxWidget: infoBoxWidget,
                            infoWidget: infoWidget ?? const SizedBox(height: 0),
                            buttons: ButtonWidget(
                              className: className,
                              status: status,
                              onPressed: () async {
                              await ref.watch(shipmentDeliveredProvider);
                              ref.read(drawerCountProvider.notifier).state = 1;
                              Navigator.pop(context);
                            },
                            ),
                            tableList: bodyList),
                      );
                    },
                  );
                }
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderShipment(id: id, status: status, headerDate: formattedDate(headerDate), newMessageSvg: newMessageSvg),
                bodyHeader == null
                ? const SizedBox(height: 0)
                : BodyHeader( bodyHeader: bodyHeader,status: status,className: className),
                const SizedBox(height: 4),
                // const ListHeaderShipment(), //list header
                // const SizedBox(
                //   height: 10,
                // ),
                status == 'order_on_the_way'
                ? BodyProposal(
                    id: id,
                    status: status, 
                    className: className, 
                    bodyList: bodyList,
                )
                : BodyShipment(
                    id: id,
                    status: status, 
                    className: className, 
                    bodyList: bodyList,
                ),
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