import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../view_model/create_order_view_model.dart';
import '../../../../view_model/proposal_view_model.dart';
import '../../../../view_model/provider_controller.dart';
import '../../../order_view/order_view.dart';

class CreateOrderButton extends ConsumerWidget {
  final String className;
  final String? id;
  final void Function()? onPressed;
  const CreateOrderButton({ 
    Key? key,
    required this.className,
    this.id,
    this.onPressed
    }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    return  ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        fixedSize: const MaterialStatePropertyAll(Size(140, 40))
      ),
      onPressed: /* () async{
        await ref.watch(createOrderProvider);
        ref.read(drawerCountProvider.notifier).state = 1;
        Navigator.pop(context);
      },  */
      onPressed,
      child: Text(
        FlutterI18n.translate(context, "tr.$className.create_order_btn"),
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
    );
  }
}