import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class OrderTableStatus extends StatelessWidget {
  final List productList;
  final String status;

  const OrderTableStatus({ 
    Key? key,
    required this.productList,
    required this.status,
     }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return DataTable2(
      columnSpacing: 5,
      fixedTopRows: 1,
      fixedLeftColumns: 1,
      dataRowHeight: 30,
      headingRowHeight: 30,
      smRatio: 0.3,
      lmRatio: 2,
      dividerThickness: 0,
      headingTextStyle: Theme.of(context).textTheme.labelMedium,
      dataTextStyle: Theme.of(context).textTheme.bodyMedium,
      dataRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
      headingRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surfaceVariant),
      columns: [
        const DataColumn2(
          // fixedWidth: 33,
          label: Text('#', maxLines: 1, textDirection: TextDirection.rtl),
          numeric: true,
          fixedWidth: 20,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.product")),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            FlutterI18n.translate(context, "tr.order.price"),
          ),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.order_header")),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.ship")),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.state")),
          numeric: true,
          size: ColumnSize.M,
        ),
      ],
      rows: productList
        .map(
          (item) => DataRow2(
            cells: [
              DataCell(Text((productList.indexOf(item) + 1).toString(), textDirection: TextDirection.ltr,)),
              DataCell(Text(item.name.toString())), //product_name
              DataCell(Text(item.price.toString())), //propsal_note
              DataCell(
                Text(
                  '${item.amount} ' ' ${item.unit}',
                )
              ),
              const DataCell(
                Text(
                  '-', //sevk miktari
                  textDirection: TextDirection.rtl,
                )
              ),
              DataCell(
                Text(
                  FlutterI18n.translate(context, 'tr.order.$status'),
                  textDirection: TextDirection.rtl,
                )
              ),
            ]
          ),
        )
        .toList(),
    );
  }
}