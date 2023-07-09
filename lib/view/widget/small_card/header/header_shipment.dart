import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/widget_helper.dart';


class HeaderShipment extends StatelessWidget {
  final String id;
  final String status;
  final String headerDate;
  final Widget ?newMessageSvg;
const HeaderShipment({ Key? key, required this.id, required this.status, required this.headerDate, this.newMessageSvg }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius:  const BorderRadius.only(
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
                Flexible(  // icon
                  child: SvgPicture.asset(
                    statusIconMap[status] ?? '', 
                    semanticsLabel: 'Order Status Icon',
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
                Expanded(
                    flex: 15,
                    child: AutoSizeText(    // headerStatus
                      FlutterI18n.translate(context, "tr.shipment.$status"),
                      style:
                          Theme.of(context).textTheme.titleLarge!,
                    )),
                Flexible(child: newMessageSvg ?? const SizedBox(width: 1)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // headerId
                Flexible(
                  child: status == 'order_on_the_way'
                  ? AutoSizeText(FlutterI18n.translate(context, "tr.shipment.shipped_date" ) + headerDate)
                  :  AutoSizeText(FlutterI18n.translate(context, "tr.order.order_no") + id),
                ),
                 // header date
                Flexible( 
                  child: status == 'order_on_the_way'
                  ? const SizedBox(width: 1)
                  :  AutoSizeText(FlutterI18n.translate(context, "tr.shipment.date") + headerDate),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}