import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';

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
      columnSpacing: 10,
      // horizontalMargin: 22,
      fixedTopRows: 1,
      dataRowHeight: 25,
      headingRowHeight: 30,
      headingTextStyle: Theme.of(context).textTheme.labelMedium,
      dataTextStyle: Theme.of(context).textTheme.bodySmall,
      dataRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
      headingRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.outlineVariant),
      // empty: Placeholder(),
      columns: [
        const DataColumn2(
          // fixedWidth: 33,
          label: AutoSizeText('#', maxLines: 1, textDirection: TextDirection.rtl),
          numeric: true,
          fixedWidth: 20,
        ),
        DataColumn2(
          label: AutoSizeText(FlutterI18n.translate(context, "tr.order.product")),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: AutoSizeText(FlutterI18n.translate(context, "tr.proposal.proposal_note")),  //tedarikci nocu
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
      rows: productsProposalList
          .map(
            (item) => DataRow2(
              // color: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.primary),
              cells: [
              DataCell(AutoSizeText((productsProposalList.indexOf(item) + 1).toString(), textDirection: TextDirection.ltr,)),
              DataCell(AutoSizeText(item.productName.toString())), //product_name
              DataCell(AutoSizeText(item.proposalNote.toString())), //propsal_note
              DataCell(AutoSizeText(item.productUnit.toString())), //product_unit
              DataCell(AutoSizeText(item.price.toString())),
              DataCell(AutoSizeText(item.amount.toString(), textAlign: TextAlign.left)),
              // DataCell(Text('')),
            ]),
          )
          .toList(),
    );
  }
}
