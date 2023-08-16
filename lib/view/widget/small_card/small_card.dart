import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/widget_helper.dart';
import '../big_card /big_card.dart';
import 'body/body_header.dart';
import 'body/body_proposal.dart';

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
  final List bodyList;
  final Widget headerSmallCard;
  final Widget bigCardHeader;
  final Widget ?bigCardButtons;
  final Widget ?infoWidget;
  final Widget ?infoBoxWidget;

  const SmallCard({
    Key? key,
    required this.index,
    required this.className,
    required this.id,
    required this.status,
    required this.bodyHeader,
    required this.headerDate,
    required this.bodyList,
    required this.bigCardHeader,
    required this.headerSmallCard,
    this.bigCardButtons,
    this.infoWidget,
    this.infoBoxWidget,
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
                            statusMap: FlutterI18n.translate(context, "tr.$className.$status"), //kaldirilacak
                            bigCardHeader: bigCardHeader,
                            infoBoxWidget: infoBoxWidget ?? const SizedBox(),
                            buttons: bigCardButtons ?? const SizedBox(),
                            infoWidget: infoWidget ?? const SizedBox(),
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
                headerSmallCard,
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