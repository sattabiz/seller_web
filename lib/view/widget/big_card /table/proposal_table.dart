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
          ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
            child: Container(
              color: Theme.of(context).colorScheme.onPrimary,
              height: 345,
              child:Expanded(
            flex: 7,
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
              headingRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surfaceVariant),
              /* decoration: BoxDecoration(
                borderRadius: BorderR adius.circular(10),
              ), */
              
              columns: [
                const DataColumn2(
                  label: Text(
                    '#',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
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
                  label: Center(
                    child: Text(
                      FlutterI18n.translate(context, "tr.proposal.proposal_note"),
                    ),
                  ),  //tedarikci nocu
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
                    (item) => DataRow2(
                      cells: [
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
                      DataCell(
                        Center(
                          child: Text(
                            item.proposalNote.toString() == 'null' ? 
                            '-' : 
                            item.proposalNote.toString(),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                            fontSize: 12.0,
                            ),
                          ),
                        )
                      ), //propsal_note
                      DataCell(
                        Text(
                          '${item.amount} ' 'Adet',//' ${item.productUnit}',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        )
                      ), //product_unit
                      DataCell(
                        Text(
                          item.price.toString() == 'null' ? '-' : item.price.toString(),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                        )
                      ),
                      DataCell(
                        Text(
                          item.price.toString() == 'null' ? '₺ 20000' 
                          : calcuteAmount(item.amount.toString(), item.price.toString()),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      // DataCell(Text('')),
                    ]),
                  )
                  .toList(),
            ),
            ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 16 ,  
            child: Container( )
          ),
          Expanded(
            flex: 4,  
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: ProposalSumPanel(
                className: className,
                row1: costCalc(productsProposalList,"raw_cost"),
                row2: costCalc(productsProposalList,"tax_amount"),
                row3: costCalc(productsProposalList,"total_cost"),/* "$FlutterI18n.translate(context, 'tr.order.proposal')" */ 
      
              )
            ),
          ),
        ],
      ),
      ],
      
    );
    
  }
  
  
}