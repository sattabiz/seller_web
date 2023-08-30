import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../utils/widget_helper.dart';

class InvoiceTable extends StatelessWidget {
  final List invoiceProductList;
  final String className;

  const InvoiceTable({
    super.key, 
    required this.invoiceProductList,
    required this.className
    });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimary,
        child: DataTable2(
          columnSpacing: 5,
          fixedTopRows: 1,
          fixedLeftColumns: 1,
          dataRowHeight: 30,
          headingRowHeight: 30,
          smRatio: 0.3,
          lmRatio: 1.6,
          dividerThickness: 0,
          headingTextStyle: Theme.of(context).textTheme.titleMedium,
          dataTextStyle: Theme.of(context).textTheme.bodyMedium,
          dataRowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          headingRowColor:MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surfaceVariant),
          columns: [
            const DataColumn2(
              // fixedWidth: 33,
              label: Text('#', textDirection: TextDirection.rtl),
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
                FlutterI18n.translate(context, "tr.order.description"),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,),  //tedarikci nocu
              size: ColumnSize.M,
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
          rows: invoiceProductList
              .map(
                (item) => DataRow2(
                  cells: [
                    DataCell(
                      Text((
                        invoiceProductList.indexOf(item) + 1).toString(), 
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          item.name.toString(),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ),
                    ), //product_name
                    DataCell(
                      Text(
                        item.proposalNote.toString(),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.start,
                      )
                    ),
                    DataCell(
                      Text(
                        '${item.shippedAmount} ' ' ${item.unit}',
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                      )
                    ), //product_unit
                    DataCell(
                      Text(
                        "${item.price.toString()} ${getCurrencySymbol(item.currencyCode.toString())}",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                      )
                    ),
                    DataCell(
                      Text(
                      item.price.toString() == 'null' ? '-' 
                      : "${calcuteAmount(item.shippedAmount.toString(), item.price.toString())} ${getCurrencySymbol(item.currencyCode.toString())}",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.end,
                      )
                    ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }
}