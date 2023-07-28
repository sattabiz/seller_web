import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../view_model/create_order_view_model.dart';
import 'package:seller_point/view/widget/big_card%20/table/invoice_table.dart';
import 'package:seller_point/view/widget/big_card%20/table/product_table.dart';
import 'package:seller_point/view/widget/big_card%20/table/proposal_table.dart';
import 'package:seller_point/view/widget/big_card%20/table/shipment_table.dart';
import 'buttons/reject_button.dart';
import 'header/header.dart';
import 'info/info.dart';
import 'info/info_box.dart';
import 'info/info_invoice.dart';

final proposalIdProvider = StateProvider<String?>((ref) => '');


class BigCard extends ConsumerWidget {
  final String id; //header_no
  final String className;
  final String status;
  final String svgPath;
  final String topic; //body_header
  final String ?statusMap;
  final Widget buttons;
  final Widget infoWidget;
  final Widget ?infoBoxWidget;
  final List tableList; //body_table

  const BigCard( {
    Key? key,
    required this.id,
    required this.className,
    required this.status,
    required this.svgPath,
    required this.topic,
    this.statusMap,
    required this.buttons,
    required this.infoWidget,
    this.infoBoxWidget,
    required this.tableList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Map<String, Widget> tableListMap= {
      'proposal': ProposalTable(productsProposalList: tableList, className: className),
      'order': ProductListTable(productList: tableList, className: className),
      'shipment': ShipmentTable(shipmentProductList: tableList, className: className),
      'invoice': InvoiceTable(invoiceProductList: tableList, className: className),
    };

    return Container(
      width: width * 0.7,
      height: height * 0.8,
      constraints: BoxConstraints.tightFor(width: width * 0.7, height: height * 0.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          Header(id: id, statusMap: statusMap ?? '-', svgPath: svgPath),  // header sonu
          Expanded(
            flex: 10,                    //body
            child: Row(
              children: [
                SizedBox(        // left-side
                  width: width * 0.7 * 0.7,
                  height: height * 0.7,
                  child: Column(  
                    crossAxisAlignment: CrossAxisAlignment.start,         
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: infoWidget
                          ),
                          infoBoxWidget ?? const SizedBox(width: 0),
                        ],
                      ),  //info        
                      Expanded(
                        flex: 3,
                        // fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 30.0, right: 16.0),
                          child: Container(
                            // height: height * 0.7 * 0.7,  //table-height ama responsive yapilacak
                            decoration: BoxDecoration(
                              borderRadius: const  BorderRadius.all(Radius.circular(10)),
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            child: tableListMap[className],
                          ),
                        ),
                      ),
                      buttons,
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30,top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              alignment: (id == "1" ?Alignment.topLeft:Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ( id == "1" ? Colors.grey.shade200 :Colors.blue[200]),
                                ),
                                padding: const  EdgeInsets.all(16),
                                child: Text("Siparis yolda", style: const TextStyle(fontSize: 15),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Container(                            
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            constraints: BoxConstraints.tightFor(width: width * 0.7 * 0.7 * 0.6, height: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}