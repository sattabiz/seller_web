import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class InfoShipment extends StatelessWidget {
  final String className;
  final String invoiceNo;
  final String? infoRow1;
  final String? infoRow2;
  final String? infoRow3;
  final String? infoRow4;
  final String? infoRow5;
  final String? infoRow6;
  const InfoShipment({
    Key? key,
    required this.className,
    required this.invoiceNo,
    this.infoRow1,
    this.infoRow2,
    this.infoRow3,
    this.infoRow4,
    this.infoRow5,
    this.infoRow6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //row 1
            children: [
              Text(
                FlutterI18n.translate(context, "tr.invoice.invoice_no"),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 4,
                child: Text(
                  invoiceNo == "null" ? '-' : invoiceNo,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Table(
            textDirection: TextDirection.ltr,
            // defaultColumnWidth: const FlexColumnWidth(1.0),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(0.6),
              2: FlexColumnWidth(0.3),
              3: FlexColumnWidth(0.8),
            },
            children: [
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.invoice.invoice_date"),
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                  ),
                  Text(
                    infoRow1 ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                  Text(
                    FlutterI18n.translate(context, "tr.order.waybill"),
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                  ),
                  Text(
                    infoRow2 ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      FlutterI18n.translate(context, "tr.order.payment_type"),
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      infoRow3 == null ? '-' : infoRow3!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      FlutterI18n.translate(context, "tr.order.expiry"),
                      style: Theme.of(context).textTheme.labelLarge,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      infoRow4 ?? '-',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.order.order_no"),
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                  ),
                  Text(
                    infoRow5 ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                  Text(
                    FlutterI18n.translate(context, "tr.order.shipment_payment"),
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                  ),
                  Text(
                    infoRow6 ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
