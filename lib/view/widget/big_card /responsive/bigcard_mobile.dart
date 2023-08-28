import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/widget/big_card%20/chat_box/chat_box.dart';

final proposalIdProvider = StateProvider<String?>((ref) => '');

class BigCardMobile extends ConsumerWidget {
  final String id;
  final Widget bigCardHeader;
  final Widget bigCardTable;
  final Widget? tableInfoPanel;
  final Widget buttons;
  final Widget infoWidget;
  final Widget? infoBoxWidget;

  const BigCardMobile({
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
    return Column(
      children: [
        Container(
          child: bigCardHeader,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    Expanded(flex: 8, child: infoWidget),
                    infoBoxWidget ?? const SizedBox(width: 0),
                  ],
                ),
              ), //info
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 30.0, right: 30.0),
                child: Container(
                  constraints: const BoxConstraints.tightFor(height: 400),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.onPrimary,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: bigCardTable,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(MediaQuery.of(context).size.toString()),
                      tableInfoPanel ?? const SizedBox(width: 0),
                    ],
                  ),
                ),
              ),
              buttons,
              const Padding(
                padding: EdgeInsets.only(
                  left: 30.0,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: ChatBox(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
