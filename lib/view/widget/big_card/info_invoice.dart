import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


class InfoInvoice extends StatelessWidget {
  final String invoiceNo; //demand_name
  final String orderDate;
  final dynamic paymentType;
  final String demandNo;
  final String className;

  const InfoInvoice({
  Key? key,
  required this.invoiceNo,  //invoice'da gib fatura no yollacanacak
  required this.orderDate,
  required this.paymentType,
  required this.demandNo,
  required this.className,
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
            AutoSizeText( FlutterI18n.translate(context, "tr.invoice.invoice_date"),
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 1,                        
              ),
            const SizedBox(width: 10.0),
            AutoSizeText(
              invoiceNo,
                style: Theme.of(context).textTheme.titleSmall,
                minFontSize: 10.0,
                maxLines: 3,                        
              ),                  
            ],
          ),
          Row(     //row 1
            children:  [
              AutoSizeText(
                FlutterI18n.translate(context, "tr.order.order_date"),
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 1,                        
              ),
              AutoSizeText(
                orderDate,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,                        
              ),     
            ],
          ),
          Row(     //row 1
            children:  [
              Text(
                FlutterI18n.translate(context, "tr.order.payment_type"),
                style: Theme.of(context).textTheme.labelSmall,       
                maxLines: 1,                              
              ),                                
              Text(
                paymentType,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,                                     
              ),
            ],
          ),
          Row(     //row 1
            children:  [
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
            ],
          ),
        ]
      ),
    );
  }
}