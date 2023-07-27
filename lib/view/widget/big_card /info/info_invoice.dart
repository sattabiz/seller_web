import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class InfoInvoice extends StatelessWidget {
  final String invoiceNo; //demand_name
  final String invoiceDate;
  final dynamic paymentType;
  final String orderId;
  final String ?paymentDate;
  final String className;

  const InfoInvoice({
  Key? key,
  required this.invoiceNo,  //invoice'da gib fatura no yollacanacak
  required this.invoiceDate,
  required this.paymentType,
  required this.orderId,
  required this.className,
  this.paymentDate,
}) : super(key: key);



  @override
  Widget  build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(     //row 1
            children:  [
              Text( FlutterI18n.translate(context, "tr.invoice.invoice_date"),
                style: Theme.of(context).textTheme.titleSmall,                     
                ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  invoiceDate,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 3,
                ),
              ),                  
            ],
          ),
          const SizedBox(height: 14.0),
          Table(                   
            textDirection: TextDirection.ltr,
            defaultColumnWidth: const FlexColumnWidth(1.0),            
            columnWidths: const <int, TableColumnWidth> {
              0: FlexColumnWidth(0.1),
              1: FlexColumnWidth(0.3),
            },
            children: [
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.order.order_date"),
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,                        
                  ),
                  Text(
                    paymentDate ?? '-',
                    style: Theme.of(context).textTheme.bodyMedium,
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
                      style: Theme.of(context).textTheme.labelMedium,       
                      maxLines: 1,                              
                    ),
                  ),                                
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      paymentType == null ? '-' : paymentType!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,                                     
                    ),
                  ),  
                ],
              ),                               
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.order.order_no"),
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,                        
                  ),                            
                  Text(
                    orderId,
                    style: Theme.of(context).textTheme.bodyMedium, 
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