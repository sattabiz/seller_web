import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class Info extends ConsumerWidget {
  final String demandName;
  final String orderDate;
  final dynamic paymentType;
  final String demandNo;
  final String deliveryDate;
  final String paymentDueDate;


  const Info({
    Key? key,
    required this.demandName,
    required this.orderDate,
    required this.paymentType,
    required this.demandNo,
    required this.deliveryDate,
    required this.paymentDueDate,
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
              Text(
                "Konu:",
                  style: Theme.of(context).textTheme.titleSmall,                        
                ),
                const SizedBox(width: 10.0),
              Text(
                demandName,
                  style: Theme.of(context).textTheme.titleSmall,                        
                ),                  
            ],
          ),
          const SizedBox(height: 14.0),
          Table(                               
            columnWidths: const <int, TableColumnWidth> {
              0: FlexColumnWidth(0.3),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(0.3),
              3: FlexColumnWidth(0.5),
            },
            children: [
              TableRow(
                children: <Widget>[
                  Text(
                    "Siparis Tarihi:",
                    style: Theme.of(context).textTheme.labelSmall,
                    //  maxLines: 1,                        
                  ),
                  Text(
                    orderDate,
                    style: Theme.of(context).textTheme.bodySmall,                        
                  ), 
                  Text(
                    "Teslim Tarihi",
                    style: Theme.of(context).textTheme.labelSmall,                        
                  ), 
                  Text(
                    deliveryDate,
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,                        
                  ), 
                  
                ],
              ),
              TableRow(
                children: <Widget>[
                  Text(
                    "Odeme Sekli:",
                    style: Theme.of(context).textTheme.labelSmall,                        
                  ),                                
                  Text(
                    paymentType,
                    style: Theme.of(context).textTheme.bodySmall,                        
                  ),
                  Text(
                    "Vade",
                    style: Theme.of(context).textTheme.labelSmall,                        
                    ), 
                  Text(
                    paymentDueDate,
                    style: Theme.of(context).textTheme.bodySmall,                        
                    ),            
                ],
              ),                                 
              TableRow(
                children: <Widget>[
                  Text(
                    "Teklif No",
                    style: Theme.of(context).textTheme.labelSmall,                        
                  ),                            
                  Text(
                    demandNo,
                    style: Theme.of(context).textTheme.bodySmall,                        
                  ), 
                  Text(
                    "Nakliye Odeme",
                    style: Theme.of(context).textTheme.labelSmall,                        
                  ),              
                  Text(
                    "Satici",
                    style: Theme.of(context).textTheme.bodySmall,                        
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