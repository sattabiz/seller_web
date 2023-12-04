import 'package:flutter/material.dart';
import 'package:seller_point/view/widget/big_card%20/buttons/reject_button.dart';

import 'create_order_button.dart';

class ButtonWidget extends StatelessWidget {
  final String className;
  final String status;
  final String? id;
  final void Function()? onPressed;
  const ButtonWidget({ 
    Key? key,
    required this.className,
    required this.status,
    this.id,
    this.onPressed
  }) : super(key: key);

  bool orderButtonBool () {
    return status == 'replied' || status == 'last_offer' || status == 'proposal_stvs'|| status == 'invoice_goods_delivered' || (className == 'shipment' && status == 'order_on_the_way'); //status invoice_goods_delivered olarak degisti
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 30, right: 10, bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderButtonBool()
          ? CreateOrderButton(className: className, id: id, onPressed: onPressed,)
          : const SizedBox(),

          const SizedBox(width: 10.0),

          const RejectButton(),
        ],
      ),
    );
  }
}