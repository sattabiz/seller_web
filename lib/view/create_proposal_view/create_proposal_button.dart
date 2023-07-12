import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/create_proposal_model.dart';
import '../../service/create_proposal_service.dart';
import '../../view_model/create_proposal_view_model.dart';
import '../../view_model/landing_view_model.dart';
import 'create_proposal_view_content.dart';
import 'create_proposal_view_table.dart';

class createProposalButton extends ConsumerWidget {
  const createProposalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.secondary)),
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
            } else {
              debugPrint('LandingProvider verisi mevcut değil');
            }
            // Changes end here
          },
          child: const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text('Teklif İste'),
          )),
    );
  }
}

