import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../model/get_favorite_list_model.dart';
import '../create_proposal_view/create_proposal_button.dart';
import '../create_proposal_view/create_proposal_view_content.dart';
import '../create_proposal_view/create_proposal_view_table.dart';
import 'favorite_list_table.dart';

class FavoriteListWidget extends StatelessWidget {
  final GetFavoriteListModel data;
  const FavoriteListWidget({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   double screenWidth = MediaQuery.of(context).size.width / 1250;
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      title: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
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
            const Icon(Icons.flare),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 14,
              child: Text(
                FlutterI18n.translate(context, 'tr.proposal.create_proposal_header'),
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
              createProposalViewContent(topic: data.name!),
              favoriteListTable(items: data.products ?? []),
            ],
          ),
        ),
      ),
      actions: [
        const CreateProposalButton(),
        Container(
          width: 600,
          constraints:  BoxConstraints(maxWidth: screenWidth *  550, minWidth: screenWidth * 330),
        ),
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(200, 40)),
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
          ),
          onPressed: () {},
          child: Text(
            FlutterI18n.translate(context, 'tr.proposal.update_btn'),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            )
          ),
        )
    
      ],










      // content: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     createProposalViewContent(topic: data.name!),
      //     favoriteListTable(items: data.products ?? []),

      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         createProposalButton(),
      //         Padding(
      //               padding: const EdgeInsets.only(top: 20.0, right: 16),
      //               child: ElevatedButton(
      //                   onPressed: () {},
      //                   child: const Padding(
      //                     padding: EdgeInsets.all(15.0),
      //                     child: Text('Guncelle'),
      //                   )),
      //             )
      //       ],
      //     )
          
      //   ],
      // ),
      
    );
  }
}
