import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class BodyHeader extends StatelessWidget {
  final String bodyHeader;
  final String status;
  final String className;
  const BodyHeader({ 
  Key? key, 
    required this.bodyHeader, 
    required this.status, 
    required this.className
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Padding(
    padding: const EdgeInsets.only(
        bottom: 8.0, top: 8.0, left: 16.0),
    child: className == 'invoice' && status == 'order_on_the_way'
    ? AutoSizeText(FlutterI18n.translate(context, "tr.shipment.invoice_no") + bodyHeader)
    : Text(bodyHeader)
    );
  }
}