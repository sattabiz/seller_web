import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class CreateOrderButton extends StatelessWidget {
  final String className;
  const CreateOrderButton({ 
    Key? key,
    required this.className,
    }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        fixedSize: const MaterialStatePropertyAll(Size(140, 40))
      ),
      onPressed: () {
      }, 
      child: Text(
        FlutterI18n.translate(context, "tr.$className.create_order_btn"),
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
    );
  }
}