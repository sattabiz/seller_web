import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../utils/widget_helper.dart';

class OrderTable extends StatelessWidget {
  final List productList;
  final String className;
  final bool filesAttached;

  const OrderTable({
    super.key, 
    required this.productList,
    required this.className,
    required this.filesAttached

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
          headingRowColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.surfaceVariant),
          columns: [
            const DataColumn2(
              // fixedWidth: 33,
              label: Text('#', maxLines: 1, textDirection: TextDirection.rtl),
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
                textAlign: TextAlign.start,
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                FlutterI18n.translate(context, "tr.order.amount"),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.end,
              ),
              size: ColumnSize.M,
              numeric: true
            ),
            DataColumn2(
              label: Text(
                FlutterI18n.translate(context, "tr.order.price"),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.end,
              ),
              size: ColumnSize.M,
              numeric: true
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
            if (filesAttached)
              const DataColumn2(
                label: Text(
                  " ",
                  textAlign: TextAlign.end,
                ),
                fixedWidth: 100
              ),
          ],
          rows: productList
            .map(
              (item) => DataRow2(
                cells: [
                  DataCell(
                    Text(
                      (productList.indexOf(item) + 1).toString(), 
                      textDirection: TextDirection.rtl,
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
                    )
                  ), //product_name
                  DataCell(
                    Text(
                      item.description.toString(),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    )
                  ), //propsal_note
                  DataCell(
                    Text(
                      '${item.amount} ' ' ${item.unit}',
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      // textDirection: TextDirection.rtl,
                    )
                  ), //product_unit
                  DataCell(
                    Text(
                      "${item.price.toString()} ${getCurrencySymbol(item.currencyCode.toString())}",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                      maxLines: 1,
                    )
                  ),
                  DataCell(
                    Text(
                      "${calcuteAmount(item.amount.toString(), item.price.toString())} ${getCurrencySymbol(item.currencyCode.toString())}",
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                    )
                  ),
                  if (filesAttached)
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          showProductFiles(item.productFiles),
                          showProductsProposalFiles(item.productsProposalFiles),
                        ],
                      ),
                    )
                ]
              ),
            )
            .toList(),
        ),
      ),
    );
  }
}
