import 'package:flutter/material.dart';

import '../../view_model/favorite_list_view_model.dart';
import 'favorite_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class navigationRailFavoriteContent extends ConsumerWidget {
  const navigationRailFavoriteContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteListResponse = ref.watch(favoriteListProvider);
    return favoriteListResponse.when(
      data: (data) {
        return Container(
          constraints: const BoxConstraints(maxHeight: 400),
          width: MediaQuery.of(context).size.width * 0.25,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              if (data[index] != null ) {
                return Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FavoriteListWidget(data: data[index]);
                          },
                        );
                      },
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(data[index].name!),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, __) => Text("An error occurred: $error"),
    );
  }
}
