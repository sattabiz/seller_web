import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../utils/widget_helper.dart';

class ShipmentTable extends StatelessWidget {
  final List shipmentProductList;
  final String className;

  const ShipmentTable({
    super.key, 
    required this.shipmentProductList,
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
              size: ColumnSize.S
            ),
            DataColumn2(
              label: Text(FlutterI18n.translate(context, "tr.order.product")),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(FlutterI18n.translate(context, "tr.order.description")),  //tedarikci nocu
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(FlutterI18n.translate(context, "tr.order.amount")),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text(FlutterI18n.translate(context, "tr.order.price")),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(FlutterI18n.translate(context, "tr.order.total")),
              numeric: true,
              size: ColumnSize.S,
              // fixedWidth: 70,
            ),
          ],
          rows: shipmentProductList
              .map(
                (item) => DataRow2(
                  // color: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
                  cells: [
                    DataCell(Text((shipmentProductList.indexOf(item) + 1).toString(), textDirection: TextDirection.ltr,)),
                    DataCell(Text(item.name.toString())), //product_name
                    DataCell(Text(item.proposalNote.toString())), //propsal_note
                    DataCell(
                      Text(
                        '${item.shippedAmount} ' ' ${item.unit}',
                        // textDirection: TextDirection.rtl,
                      )
                    ), //product_unit
                    DataCell(
                      Text(
                        "${item.price.toString()} ${getCurrencySymbol(item.currencyCode.toString())}",
                        textDirection: TextDirection.rtl,
                      )
                    ),
                    DataCell(
                      Text(
                        "${calcuteAmount(item.shippedAmount.toString(), item.price.toString())} ${getCurrencySymbol(item.currencyCode.toString())}",
                        textDirection: TextDirection.rtl
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