import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SmallCardShipmentTable extends StatelessWidget {
  final String id;
  final String status;
  final String className;
  final List bodyList;

  const SmallCardShipmentTable({ 
  Key? key, 
    required this.id,
    required this.status, 
    required this.className, 
    required this.bodyList
  }) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Table(
      textDirection: TextDirection.ltr,
      columnWidths: const <int, TableColumnWidth> {
        0: FlexColumnWidth(0.2),
        1: FlexColumnWidth(0.8),
        2: FlexColumnWidth(0.3),
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
              FlutterI18n.translate(context, "tr.order.amount"),
              style: Theme.of(context).textTheme.labelLarge,
              maxLines: 1,
            ),
          ]
        ),
        for (int i = 0; i < bodyList.length; i++)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Text(
                    ((i) + 1).toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Text(
                  bodyList[i].name.toString(),     
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Text(
                  '${bodyList[i].amount} adet',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ]
          ),
      ],      
    );

    // return Padding(
    //   padding: const EdgeInsets.only(right: 10.0),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //       Expanded(
    //         flex: 3,
    //         child: Padding(
    //           padding: const EdgeInsets.only(
    //             left: 16.0,
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Expanded(
    //                 flex: 1,
    //                 child: 
    //                   Text(
    //                     (i + 1).toString(),
    //                     style: Theme.of(context).textTheme.bodySmall,
    //                     textDirection: TextDirection.ltr,
    //                     maxLines: 1
    //                   ),
    //               ),
    //               Expanded(
    //                 flex: 10,
    //                 child: 
    //                   Text(
    //                     bodyList[i].name.toString(),
    //                     style: Theme.of(context).textTheme.bodySmall,
    //                     textDirection: TextDirection.ltr,
    //                     maxLines: 1
    //                   ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         flex: 2,
    //         child: Padding(
    //           padding: const EdgeInsets.only(bottom: 5, right: 7),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               const Spacer(
    //                 flex: 1,
    //               ),
    //               status == 'order_on_the_way'
    //               ? Expanded(
    //                 flex: 6,
    //                 child: Text(
    //                   bodyList[i].shippedAmount.toString() + 'adet',
    //                   style: Theme.of(context).textTheme.bodySmall,
    //                   textDirection: TextDirection.ltr,
    //                   maxLines: 1,
    //                 )
    //               )
    //               : const Spacer(flex:6),
    //               Expanded(
    //                 flex: 4,
    //                 child: 
    //                  Text(
    //                   status == 'order_on_the_way'
    //                   ? bodyList[i].price.toString() + ' ₺'
    //                   : bodyList[i].shippedAmount.toString() + ' adet',
    //                   style: Theme.of(context).textTheme.bodySmall,
    //                   textDirection: TextDirection.ltr,
    //                   maxLines: 1)
    //               ),
    //               const Spacer(
    //                 flex: 1,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}