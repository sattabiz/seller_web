import 'package:flutter/material.dart';
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
      // key: globalKeyList[index],
      columnSpacing: 10,
      // horizontalMargin: 22,
      // minWidth: double.infinity,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).colorScheme.primary,
      //   // border: Border.all(
      //   //   color: Theme.of(context).colorScheme.primary ,
      //   //   // width: 1,
      //   // ),
      //   borderRadius:  const BorderRadius.all(Radius.circular(10)),
      // ),
      fixedTopRows: 1,
      dataRowHeight: 25,
      headingRowHeight: 30,

      headingTextStyle: Theme.of(context).textTheme.labelMedium,
      dataTextStyle: Theme.of(context).textTheme.bodySmall,
      // empty: Placeholder(),
      columns:  const[
        DataColumn2(
          // fixedWidth: 33,
          label: Text('#', textAlign: TextAlign.start),
          numeric: true,
          fixedWidth: 15,
                  // border: Border.all(
        //   color: Theme.of(context).colorScheme.primary ,
        //   // width: 1,
        // ),
        ),
        DataColumn2(
          label: Text('Urun'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Aciklama'),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text('Miktar'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Fiyat'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Tutar'),
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
              DataCell(Text((productList.indexOf(item) + 1).toString())),
              DataCell(Text(item.name.toString())),
              DataCell(Text(item.description.toString())),
              DataCell(Text(item.unit.toString())),
              DataCell(Text(item.price.toString())),
              DataCell(Text(item.amount.toString(), textAlign: TextAlign.left)),
              // DataCell(Text('')),
            ]),
          )
          .toList(),
    );
  }
}
