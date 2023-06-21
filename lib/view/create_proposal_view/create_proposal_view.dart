import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'create_proposal_button.dart';
import 'create_proposal_view_content.dart';
import 'create_proposal_view_table.dart';
class createProposalView extends ConsumerWidget {
  const createProposalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30))), //for border radiuss
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
            ),
            const Icon(Icons.star_half_outlined),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 14,
              child: Text(
                'Yeni Teklif İsteği',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            InkWell(
              child: Icon(Icons.exit_to_app_sharp),
              onTap: () => Navigator.of(context).pop(),
            ), // to return to the page
            const SizedBox(
              width: 30,
            )
          ],
        ),
      ),
      content: Padding(
        padding:
            const EdgeInsets.only(left: 22.0, right: 22.0, top: 15, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              createProposalViewContent(),
              createProposalViewTable(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  createProposalButton(),
                  Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          final formItems = ref.read(formItemProvider.notifier).state;

                          debugPrint('Number of items: ${formItems.length}');

                          for (var item in formItems) {
                            debugPrint('Category: ${item.category}');
                            debugPrint('Product: ${item.product}');
                            debugPrint('Amount: ${item.amount}');
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Listelerime Kaydet'),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
