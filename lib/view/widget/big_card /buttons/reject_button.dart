import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class RejectButton extends StatelessWidget {

  const RejectButton({ 
    Key? key
    }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer),
        fixedSize: const MaterialStatePropertyAll(Size(130, 40))
      ),
      onPressed: () {
      }, 
      child: Text(
        FlutterI18n.translate(context, "tr.order.reject_btn_big_card"),
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),),
    );
  }
}