import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view_model/create_proposal_view_model.dart';
import 'create_proposal_view_content.dart';
import 'create_proposal_view_table.dart';

class CreateProposalButton extends ConsumerWidget {
  const CreateProposalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
          fixedSize: MaterialStateProperty.all(const Size(150, 40)),
        ),
        onPressed: () async {
          List<FormItem> _productsAttributes = ref.watch(formItemProvider);
          final _contentItems = ref.watch(offerModelProvider);
          
          
          if (_productsAttributes != null) {
            try {
              await ref.watch(createProposalProvider);
            } catch (e) {
              debugPrint('API çağrısında bir hata oluştu: $e');
            }
            Navigator.pop(context);
          } else {
            debugPrint('LandingProvider verisi mevcut değil');
          }
        },
        child: Text(
          FlutterI18n.translate(context, 'tr.proposal.create_proposal_btn'),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ));
  }
}

