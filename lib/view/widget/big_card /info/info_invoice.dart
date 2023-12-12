import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import '../../../../utils/widget_helper.dart';

class InfoInvoice extends StatelessWidget {
  final String invoiceNo; //demand_name
  final String invoiceDate;
  final dynamic paymentType;
  final String orderId;
  final String ?paymentDate;
  final String className;
  final String status;

  const InfoInvoice({
  Key? key,
  required this.invoiceNo,  //invoice'da gib fatura no yollacanacak
  required this.invoiceDate,
  required this.paymentType,
  required this.orderId,
  required this.className,
  required this.status,
  this.paymentDate,
}) : super(key: key);

  @override
  Widget  build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(left: 30.0, top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(     //row 1
            children:  [
              Text( FlutterI18n.translate(context, "tr.invoice.invoice_no"),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),                     
                ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  invoiceNo,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 3,
                ),
              ),                  
            ],
          ),
          const SizedBox(height: 14.0),
          Table(                   
            textDirection: TextDirection.ltr,       
            columnWidths: const <int, TableColumnWidth> {
              0: FlexColumnWidth(0.1),
              1: FlexColumnWidth(0.6),
            },
            children: [
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.invoice.info_row_1.$status"),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,                        
                  ),
                  Text(
                    formattedDate(invoiceDate),
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 1,                        
                  ), 
                  
                ],
              ),
              TableRow(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      FlutterI18n.translate(context, "tr.order.payment_type"),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),       
                      maxLines: 1,                              
                    ),
                  ),                                
                  Container(
                    margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      paymentType,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,                                     
                    ),
                  ),  
                ],
              ),                               
              TableRow(
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(context, "tr.order.order_no"),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,                        
                  ),                            
                  Text(
                    orderId,
                    style: Theme.of(context).textTheme.bodyLarge, 
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