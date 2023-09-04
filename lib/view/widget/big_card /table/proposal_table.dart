import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../../../utils/widget_helper.dart';
import 'dart:js' as js;

class ProposalTable extends StatelessWidget {
  final List productsProposalList;
  final String className;
  final bool filesAttached;

  const ProposalTable(
      {super.key, required this.productsProposalList, required this.className, required this.filesAttached});

  @override
  Widget build(BuildContext context) {
    debugPrint(filesAttached.toString());
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        // height: MediaQuery.of(context).size.height * 0.370, //345,
        child: DataTable2(
          columnSpacing: 5,
          fixedTopRows: 1,
          fixedLeftColumns: 1,
          dataRowHeight: 30,
          headingRowHeight: 30,
          smRatio: 0.3,
          lmRatio: 1.6,
          dividerThickness: 0,
          empty: const Text(""),
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          dataTextStyle: Theme.of(context).textTheme.bodyMedium,
          dataRowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          headingRowColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.surfaceVariant),
          columns: [
            const DataColumn2(
              label: Text('#',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              numeric: true,
              fixedWidth: 20,
            ),
            DataColumn2(
              label: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  FlutterI18n.translate(context, "tr.order.product"),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                FlutterI18n.translate(context, "tr.proposal.proposal_note"),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
              ), //tedarikci nocu
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                FlutterI18n.translate(context, "tr.order.amount"),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.end,
              ),
              size: ColumnSize.M,
              numeric: true,
            ),
            DataColumn2(
              label: Text(
                FlutterI18n.translate(context, "tr.order.price"),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.end,
              ),
              numeric: true,
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(
                FlutterI18n.translate(context, "tr.order.total"),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.end,
              ),
              numeric: true,
              size: ColumnSize.M,
            ),
          ],
          rows: productsProposalList
              .map(
                (item) => DataRow2(cells: [
                  DataCell(
                    Text(
                      (productsProposalList.indexOf(item) + 1).toString(),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataCell(
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        item.productName.toString(),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ), //product_name
                  DataCell(Text(
                    item.proposalNote.toString() == 'null'
                        ? '-'
                        : item.proposalNote.toString(),
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                  )), //propsal_note
                  DataCell(Text(
                    '${item.amount} ' ' ${item.productUnit}',
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  )), //product_unit
                  DataCell(Text(
                    item.price.toString() == 'null'
                        ? '-'
                        : "${item.price.toString()} ${getCurrencySymbol(item.currencyCode.toString())}",
                    textAlign: TextAlign.end,
                    maxLines: 1,
                  )),
                  DataCell(
                    Text(
                      item.price.toString() == 'null'
                          ? '-'
                          : "${calcuteAmount(item.amount.toString(), item.price.toString())} ${getCurrencySymbol(item.currencyCode.toString())}",
                      textAlign: TextAlign.end,
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}
