import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Info extends ConsumerWidget {
  final String demandName;
  final String orderDate;
  final String ?paymentType;
  final String demandNo;
  final String ?deliveryDate;
  final String ?paymentDueDate;


  const Info({
    Key? key,
    required this.demandName,  //invoice'da gib fatura no yollacanacak
    required this.orderDate,
    this.paymentType,
    required this.demandNo,
    this.deliveryDate,
    this.paymentDueDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(     //row 1
            children:  [
              Text( FlutterI18n.translate(context, "tr.order.topic"),
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 1,                        
                ),
              const SizedBox(width: 10.0),
              Text(
                demandName,
                style: Theme.of(context).textTheme.titleSmall,
                maxLines: 3,                        
              ),                  
            ],
          ),
          const SizedBox(height: 14.0),
          Table(                   
            textDirection: TextDirection.ltr,
            defaultColumnWidth: const FlexColumnWidth(1.0),            
            columnWidths: const <int, TableColumnWidth> {
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(0.4),
              2: FlexColumnWidth(0.3),
              3: FlexColumnWidth(0.4),
            },
            children: [
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.order.order_date"),
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,                        
                  ),
                  Text(
                    orderDate,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,                        
                  ), 
                  Text(
                    FlutterI18n.translate(context, "tr.order.delivery_date"),
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,                        
                  ), 
                  Text(
                    deliveryDate ?? '-',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,                    
                  ), 
                  
                ],
              ),
              TableRow(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      FlutterI18n.translate(context, "tr.order.payment_type"),
                      style: Theme.of(context).textTheme.labelSmall,       
                      maxLines: 1,                              
                    ),
                  ),                                
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      paymentType == null ? '-' : paymentType!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,                                     
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      FlutterI18n.translate(context, "tr.order.expiry"),
                      style: Theme.of(context).textTheme.labelSmall,
                      maxLines: 1,                                     
                      ),
                  ), 
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      paymentDueDate ?? '-',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,                                     
                      ),
                  ),            
                ],
              ),                               
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.order.demand_no"),
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,                        
                  ),                            
                  Text(
                    demandNo,
                    style: Theme.of(context).textTheme.bodySmall, 
                    maxLines: 1,                       
                  ), 
                  Text(
                    FlutterI18n.translate(context, "tr.order.shipment_payment"),
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,                        
                  ),              
                  Text(
                    "Satici",
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,                        
                  ), 
          
                ],
              ),
            ],
          ),
        ],                                                                                                                                 
      ),
    );
  }
}