import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/create_proposal_model.dart';
import '../../service/create_proposal_service.dart';
import '../../view_model/create_proposal_view_model.dart';
import '../../view_model/landing_view_model.dart';
import '../../view_model/proposal_view_model.dart';
import 'create_proposal_view_content.dart';
import 'create_proposal_view_table.dart';
import 'dart:ui';

class createProposalButton extends ConsumerWidget {
  const createProposalButton({Key? key}) : super(key: key);

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
          
          // Changes start here
          final landingProviderAsyncValue = ref.watch(getLandingViewContentProvider);
          final landingProvider = landingProviderAsyncValue.value;
          if (landingProvider != null) {
            final _orderlistservice = createProposalService();
            try {
              CreateProposalModel _orderList =
                  await _orderlistservice.createProposlPost(
                      _productsAttributes,
                      _contentItems, 
                      landingProvider
                  );
            } catch (e) {
              debugPrint('API çağrısında bir hata oluştu: $e');
            }
            ref.refresh(formItemProvider);
            ref.refresh(proposalListview);
            Navigator.pushNamed(context, '/proposalScreen');
          } else {
            debugPrint('LandingProvider verisi mevcut değil');
          }
          // Changes end here
        },
        child: Text(
          FlutterI18n.translate(context, 'tr.proposal.create_proposal_btn'),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ));
  }
}

