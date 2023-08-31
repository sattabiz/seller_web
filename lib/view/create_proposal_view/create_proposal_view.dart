import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'create_proposal_button.dart';
import 'create_proposal_view_content.dart';
import 'create_proposal_view_table.dart';

class createProposalView extends ConsumerWidget {
  const createProposalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth =
        MediaQuery.of(context).size.width / 1250; //change function
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        width: 1000,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 30,
            ),
            SvgPicture.asset(
              'assets/flare.svg',
              width: 30.0,
              height: 30.0,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 14,
              child: Text(
                FlutterI18n.translate(
                    context, 'tr.proposal.new_proposal_request'),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            InkWell(
              child: Icon(
                Icons.close,
                size: 35,
                color: Theme.of(context).colorScheme.shadow,
              ),
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
            ],
          ),
        ),
      ),
      actions: [
        const CreateProposalButton(),
        Container(
          width: 600,
          constraints: BoxConstraints(
              maxWidth: screenWidth * 550, minWidth: screenWidth * 330),
        ),
        // const Spacer(flex: 3),
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(200, 40)),
            backgroundColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primaryContainer),
          ),
          onPressed: () {
            final formItems = ref.read(formItemProvider.notifier).state;
          },
          child: Text(
              FlutterI18n.translate(context, 'tr.proposal.save_list_btn'),
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  )),
        )
      ],
    );
  }
}
