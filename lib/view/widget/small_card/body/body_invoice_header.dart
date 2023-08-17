import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class BodyInvoiceHeader extends StatelessWidget {
  final String bodyHeader;

  const BodyInvoiceHeader({ 
    Key? key,
    required this.bodyHeader, 
   }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.only(
          bottom: 4.0, top: 5.0, left: 16.0),
      child: Row(
        children: [
          Text(
            FlutterI18n.translate(context, 'tr.invoice.invoice_no'),
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            bodyHeader,
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      )
    );
  }
}