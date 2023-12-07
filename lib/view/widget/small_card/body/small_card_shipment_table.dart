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
                  '${bodyList[i].amount} ${bodyList[i].unit} ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ]
          ),
      ],      
    );
  }
}