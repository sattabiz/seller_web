import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:seller_point/view/widget/big_card%20/info/info_box.dart';
import 'package:seller_point/view/widget/big_card%20/info/proposal_sum_panel.dart';
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
    return Stack(
      children: [
        Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          ),
          Column(
        children: [
          Expanded(
            flex: 7,
            child: DataTable2(
              columnSpacing: 5,
              fixedTopRows: 1,
              fixedLeftColumns: 1,
              dataRowHeight: 30,
              headingRowHeight: 30,
              smRatio: 0.3,
              lmRatio: 1.2,
              headingTextStyle: Theme.of(context).textTheme.labelMedium,
              dataTextStyle: Theme.of(context).textTheme.bodyMedium,
              dataRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
              headingRowColor: MaterialStateProperty.all<Color>(Colors.transparent),
              columns: [
                const DataColumn2(
                  label: Text(
                    '#', 
                    textDirection: TextDirection.ltr,
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
                    textDirection: TextDirection.rtl,
                  ),
                  size: ColumnSize.M,
                  // fixedWidth: 60
                ),
                DataColumn2(
                  label: Text(
                    FlutterI18n.translate(context, "tr.order.price"),
                    textDirection: TextDirection.rtl,
                  ),
                  // numeric: true,
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text(
                    FlutterI18n.translate(context, "tr.order.total"),
                    textDirection: TextDirection.rtl,
                  ),
                  numeric: true,
                  size: ColumnSize.S,
                ),
              ],
              rows: productsProposalList
                  .map(
                    (item) => DataRow2(
                      cells: [
                      DataCell(
                        Text(
                          (productsProposalList.indexOf(item) + 1).toString(),
                          // textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          // textAlign: TextAlign.left,
                        ),
                      ),
                      DataCell(
                        Text(
                          item.productName.toString(),
                          textDirection: TextDirection.ltr,
                        ),
                      ), //product_name
                      DataCell(
                        Text(
                          item.proposalNote.toString() == 'null' ? '-' : item.proposalNote.toString(),
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                        )
                      ), //propsal_note
                      DataCell(
                        Text(
                          '${item.amount} ' ' ${item.productUnit}',
                          maxLines: 1,
                        )
                      ), //product_unit
                      DataCell(
                        Text(
                          item.price.toString() == 'null' ? '-' : item.price.toString(),
                          textDirection: TextDirection.rtl,
                        )
                      ),
                      DataCell(
                        Text(
                          item.price.toString() == 'null' ? '-' 
                          : calcuteAmount(item.amount.toString(), item.price.toString()),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      // DataCell(Text('')),
                    ]),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            flex: 3,  
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ProposalSumPanel(
                className: className,
                row1: "$FlutterI18n.translate(context, 'tr.order.proposal')",
                row2: "$FlutterI18n.translate(context, 'tr.order.proposal')",
                row3: "$FlutterI18n.translate(context, 'tr.order.proposal')"
      
              )
            ),
          ),
        ],
      ),
      ],
      
    );
    
  }
}
