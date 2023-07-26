import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/widget_helper.dart';
import '../big_card /big_card.dart';
import 'body/body_header.dart';
import 'body/body_proposal.dart';
import 'body/list_header..dart';
import 'header/header_invoice.dart';
import 'header/header_order.dart';
import 'header/header_proposal.dart';

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final boolProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final proposalIndexProvider = StateProvider<int?>((ref) => 1);

const String newMessage = 'assets/newMessage.svg';
final Widget newMessageSvg = SvgPicture.asset(
  newMessage,
  semanticsLabel: 'Acme Logo',
  width: 22.0,
  height: 20.0,
);

class SmallCard extends ConsumerWidget {
  final int index;
  final String className;
  final String id;
  final String status;
  final String bodyHeader;
  final String headerDate;
  final String ?paymentType; //info_2 (column1) 
  final String ?demandNo; //info_3 (column1)
  final String ?deliveryDate; //info_1 (column2)
  final String ?paymentDueDate;
  final String ?infoBoxRow1;
  final String ?infoBoxRow2;
  final String ?infoBoxRow3;
  final String ?paymentDate;
  final List bodyList;
  final Widget ?bigCardButtons;

  const SmallCard({
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
    this.infoBoxRow1,
    this.infoBoxRow2,
    this.infoBoxRow3,
    this.paymentDate,
    required this.bodyList,
    this.bigCardButtons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    DateTime parsedDate = DateTime.parse(headerDate);
    String formattedDate =
        "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";

    Map<String, Widget> headerWidget = {
      'proposal': HeaderProposal(id: id,status: status,headerDate: formattedDate,newMessageSvg: newMessageSvg, className: className,),
      'order': HeaderOrder(id: id,status: status,headerDate: formattedDate,newMessageSvg: newMessageSvg, className: className,),
      'invoice': HeaderInvoice(id: id,status: status,headerDate: formattedDate,newMessageSvg: newMessageSvg, className: className,),
    };
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surface,
          child: InkWell(
            onTap: () {
              ref.read(proposalIndexProvider.notifier).state=index;
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
                            paymentType: paymentType ?? '-',
                            demandNo: demandNo ?? ' ',
                            deliveryDate: deliveryDate,
                            paymentDueDate: paymentDueDate ?? '-',
                            statusMap: FlutterI18n.translate(context, "tr.$className.$status"),
                            infoBoxRow1: infoBoxRow1 ?? '-',
                            infoBoxRow2: infoBoxRow2 ?? '-',
                            infoBoxRow3: 'Merkez',
                            paymentDate: paymentDate ?? '-',
                            buttons: bigCardButtons ?? Container(),
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
                headerWidget[className]!,
                BodyHeader( bodyHeader: bodyHeader,status: status,className: className),
                const SizedBox(height: 4),
                BodyProposal(
                  id: id,
                  // i: i, 
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