import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../model/get_order_list_model.dart';


class ProductListTable extends ConsumerWidget {
  final List<Product> productList;

  const ProductListTable({
    super.key, 
    required this.productList
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DataTable2(
      columnSpacing: 10,
      horizontalMargin: 22,
      fixedTopRows: 1,
      dataRowHeight: 25,
      headingRowHeight: 30,
      headingTextStyle: Theme.of(context).textTheme.labelMedium,
      dataTextStyle: Theme.of(context).textTheme.bodySmall,
      // empty: Placeholder(),
      columns: [
        const DataColumn2(
          // fixedWidth: 33,
          label: AutoSizeText('#', textAlign: TextAlign.start, maxLines: 1, textDirection: TextDirection.ltr),
          numeric: true,
          fixedWidth: 20,
        ),
        DataColumn2(
          label: AutoSizeText(FlutterI18n.translate(context, "tr.order.product")),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: AutoSizeText(FlutterI18n.translate(context, "tr.order.description")),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: AutoSizeText(FlutterI18n.translate(context, "tr.order.amount")),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: AutoSizeText(FlutterI18n.translate(context, "tr.order.price")),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: AutoSizeText(FlutterI18n.translate(context, "tr.order.total")),
          numeric: true,
          // size: ColumnSize.S,
          fixedWidth: 70,
        ),
      ],
      rows: productList
          .map(
            (item) => DataRow2(
              // color: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
              cells: [
              DataCell(AutoSizeText((productList.indexOf(item) + 1).toString())),
              DataCell(AutoSizeText(item.name.toString())),
              DataCell(AutoSizeText(item.description.toString())),
              DataCell(AutoSizeText(item.unit.toString())),
              DataCell(AutoSizeText(item.price.toString())),
              DataCell(AutoSizeText(item.amount.toString(), textAlign: TextAlign.left)),
              // DataCell(Text('')),
            ]),
          )
          .toList(),
    );
  }
}
