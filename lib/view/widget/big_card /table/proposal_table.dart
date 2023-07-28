import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../../../utils/widget_helper.dart';

class ProposalTable extends StatelessWidget {
  final List productsProposalList;
  final String className;

  const ProposalTable({
    super.key, 
    required this.productsProposalList,
    required this.className
    });

  @override
  Widget build(BuildContext context) {    
    return DataTable2(
      columnSpacing: 5,
      fixedTopRows: 1,
      dataRowHeight: 30,
      headingRowHeight: 30,
      headingTextStyle: Theme.of(context).textTheme.labelMedium,
      dataTextStyle: Theme.of(context).textTheme.bodyMedium,
      dataRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
      headingRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surfaceVariant),
      columns: [
        const DataColumn2(
          label: Text(
            '#', 
            textAlign: TextAlign.left,
          ),
          numeric: true,
          fixedWidth: 20,
        ),
        DataColumn2(
          label: Text(
            FlutterI18n.translate(context, "tr.order.product"),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            FlutterI18n.translate(context, "tr.proposal.proposal_note"),
          ),  //tedarikci nocu
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(
            FlutterI18n.translate(context, "tr.order.amount"),
          ),
          size: ColumnSize.S,
          // fixedWidth: 60
        ),
        DataColumn2(
          label: Text(
            FlutterI18n.translate(context, "tr.order.price"),
          ),
          numeric: true,
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(
            FlutterI18n.translate(context, "tr.order.total"),
          ),
          numeric: true,
          size: ColumnSize.S,
        ),
      ],
      rows: productsProposalList
          .map(
            (item) => DataRow2(
              // color: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
              cells: [
              DataCell(
                Text(
                  (productsProposalList.indexOf(item) + 1).toString(),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                ),
              ),
              DataCell(
                Text(
                  item.productName.toString(),
                ),
              ), //product_name
              DataCell(
                Text(
                  item.proposalNote.toString() == 'null' ? '-' : item.proposalNote.toString(),
                )
              ), //propsal_note
              DataCell(
                Text(
                  item.amount.toString(),
                )
              ), //product_unit
              DataCell(
                Text(
                  item.price.toString() == 'null' ? '-' : item.price.toString(),
                )
              ),
              DataCell(
                Text(
                  item.price.toString() == 'null' ? '-' 
                  : calcuteAmount(item.amount.toString(), item.price.toString()),
                ),
              ),
              // DataCell(Text('')),
            ]),
          )
          .toList(),
    );
  }
}
