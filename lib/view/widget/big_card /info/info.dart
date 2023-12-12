import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:seller_point/view/widget/big_card%20/responsive/bigcard_mobile.dart';

final proposalIdProvider = StateProvider<String?>((ref) => '');
final ScrollController _scrollController = ScrollController();
class Info extends ConsumerWidget {
  final String className;
  final String demandName;
  final String? infoRow1;
  final String? infoRow2;
  final String? infoRow3;
  final String? infoRow4;
  final String? infoRow5;
  final String? infoRow6;

  const Info({
    Key? key,
    required this.className,
    required this.demandName,
    this.infoRow1,
    this.infoRow2,
    this.infoRow3,
    this.infoRow4,
    this.infoRow5,
    this.infoRow6,
  }) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //row 1
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                FlutterI18n.translate(context, "tr.order.topic"),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 4,
                child: Text(
                  demandName == "null" ? '-' : demandName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Table(
            textDirection: TextDirection.ltr,
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
                    FlutterI18n.translate(context, "tr.$className.infoRow1"),
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                  ),
                  Text(
                    infoRow1 ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                  ),
                  Text(
                    FlutterI18n.translate(context, "tr.$className.infoRow2"),
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
                    FlutterI18n.translate(context, "tr.$className.infoRow5"),
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
