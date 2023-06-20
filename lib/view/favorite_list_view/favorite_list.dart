import 'package:flutter/material.dart';

import '../create_proposal_view/create_proposal_button.dart';
import '../create_proposal_view/new_offer_request_content.dart';
import 'favorite_list_table.dart';

class favoriteListWidget extends StatefulWidget {
  const favoriteListWidget({Key? key}) : super(key: key);

  @override
  _FavoriteListWidgetState createState() => _FavoriteListWidgetState();
}

class _FavoriteListWidgetState extends State<favoriteListWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.all(8),
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
            const Icon(Icons.flare),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 14,
              child: Text(
                'Kayitli Urun Listesi',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
              ),
            ),
            InkWell(
              child: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ), // to return to the page
            const SizedBox(
              width: 30,
            )
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          createProposalViewContent(),
          favoriteListTable(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              createProposalButton(),
              Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 16),
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Guncelle'),
                        )),
                  )
            ],
          )
          
        ],
      ),
      
    );
  }
}
