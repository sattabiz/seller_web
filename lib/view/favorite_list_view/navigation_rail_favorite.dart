import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/favorite_list_view_model.dart';

class navigationRailFavorite extends ConsumerWidget {
  const navigationRailFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ato = ref.watch(favoriteListProvider);
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30))), //for border radiuss
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.format_list_bulleted),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Listelerim',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.shadow,
                  ),
            ),
            const Spacer(
              flex: 5,
            ),
            InkWell(
              child: Icon(Icons.close),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
