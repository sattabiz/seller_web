import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


class BodyProposal extends StatelessWidget {
  final String id;
  // final int i;
  final String status;
  final String className;
  final String bodyHeader;
  final List bodyList;

  const BodyProposal({ 
  Key? key, 
    required this.id,
    // required this.i, 
    required this.status, 
    required this.className, 
    required this.bodyHeader, 
    required this.bodyList
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Table(
      textDirection: TextDirection.ltr,
      columnWidths: const <int, TableColumnWidth> {
        0: FlexColumnWidth(0.2),
        1: FlexColumnWidth(0.6),
        2: FlexColumnWidth(0.3),
        3: FlexColumnWidth(0.3),
      },
      children: [
        TableRow(
          children: [
            const Text(
              '#',
              textAlign: TextAlign.center,
            ),
            Text(
              FlutterI18n.translate(context, "tr.order.product"),
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 1,
            ),
            Text(
              status == 'order_approved'
              ? FlutterI18n.translate(context, "tr.order.order_header")
              : FlutterI18n.translate(context, "tr.order.amount"),
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 1,
            ),
            Text(
              FlutterI18n.translate(context, "tr.order.price"),
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
            ),
          ]
        ),
        for (int i = 0; i < bodyList.length; i++)
          TableRow(
            children: [
              Text(
                  ((i) + 1).toString(),
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              Text(
                className == 'proposal'
                ? bodyList[i].productName.toString()
                : bodyList[i].name.toString(),     
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1),
              Text(
                (className=='invoice' || className=='shipment')
                ? '${bodyList[i].shippedAmount} adet'
                : '${bodyList[i].amount} adet',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              bodyList[i].price == null
              ? const Text('-')
              : Text(
                '${bodyList[i].price} ₺',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
              ),
            ]
          ),
      ],      
    );
  }
}