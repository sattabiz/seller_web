import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/widget/big_card%20/chat_box/chat_box.dart';
import 'package:seller_point/view/widget/big_card%20/responsive/resposive_bigcard.dart';
import 'package:seller_point/view/widget/big_card%20/responsive/bigcard_desktop.dart';
import 'package:seller_point/view/widget/big_card%20/responsive/bigcard_mobile.dart';

final proposalIdProvider = StateProvider<String?>((ref) => '');

class BigCard extends ConsumerWidget {
  final String id;
  final Widget bigCardHeader;
  final Widget bigCardTable;
  final Widget? tableInfoPanel;
  final Widget buttons;
  final Widget infoWidget;
  final Widget? infoBoxWidget;

  const BigCard({
    Key? key,
    required this.id,
    required this.bigCardHeader,
    required this.bigCardTable,
    this.tableInfoPanel,
    required this.buttons,
    required this.infoWidget,
    this.infoBoxWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ResponsiveBigCard(
        bigCardDesktop: BigCardDesktop(
            id: id,
            bigCardHeader: bigCardHeader,
            bigCardTable: bigCardTable,
            tableInfoPanel: tableInfoPanel,
            buttons: buttons,
            infoWidget: infoWidget,
            infoBoxWidget: infoBoxWidget),
        bigCardMobile: BigCardMobile(
            id: id,
            bigCardHeader: bigCardHeader,
            bigCardTable: bigCardTable,
            tableInfoPanel: tableInfoPanel,
            buttons: buttons,
            infoWidget: infoWidget,
            infoBoxWidget: infoBoxWidget
        ));
  }
}
