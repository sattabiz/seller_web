import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/widget/big_card%20/chat_box/chat_box.dart';

final proposalIdProvider = StateProvider<String?>((ref) => '');

class BigCardDesktop extends ConsumerWidget {
  final String id;
  final Widget bigCardHeader;
  final Widget bigCardTable;
  final Widget? tableInfoPanel;
  final Widget buttons;
  final Widget infoWidget;
  final Widget? infoBoxWidget;

  const BigCardDesktop({
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints.tightFor(width: width * 0.85, height: height * 0.9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          bigCardHeader,
          Expanded(
            flex: 11, //body
            child: Row(
              children: [
                Flexible(
                  flex: 9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(flex: 8, child: infoWidget),
                          Container(
                              constraints: const BoxConstraints.tightFor(width: 270),
                              child: infoBoxWidget ?? const SizedBox(width: 0)),
                        ],
                      ), //info
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 30.0, right: 16.0),
                          child: Container(
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
                      ), //Data Grid
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: Theme.of(context).colorScheme.surfaceVariant,
                            ),
                            // alignment: Alignment.centerRight,
                            child: Row(
                              children: [
                                const Spacer(),
                                tableInfoPanel ?? const SizedBox(width: 0),
                              ],
                            ),
                          ),
                        ),
                      ), //TableInfoPanel
                    ],
                  ),
                ),
                const Flexible(flex: 3, child: ChatBox()), //ChatBox
              ],
            ),
          ),
          Row(
            children: [
              buttons,
            ],
          ), //CancelButton
        ],
      ),
    );
  }
}
