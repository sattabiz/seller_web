import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/landing_view_model.dart';

class FormItem {
  String? category;
  String? product;
  String? amount;

  FormItem({this.category, this.product, this.amount});
}

// State Notifier Provider for form items
final formItemProvider =
    StateNotifierProvider.autoDispose<FormItemsNotifier, List<FormItem>>((ref) {
  return FormItemsNotifier([FormItem()]);
});

class FormItemsNotifier extends StateNotifier<List<FormItem>> {
  FormItemsNotifier(List<FormItem> state) : super(state);

  void addItem(FormItem item) {
    state = [...state, item];
  }

  void removeItem(int index) {
    state = state.where((element) => state.indexOf(element) != index).toList();
  }
}

String truncateToTwoWords(String text) {
  var words = text.split(' ');
  if (words.length > 3) {
    words = words.take(3).toList();
    return '${words.join(' ')}...';
  }
  return text;
}

class createProposalViewTable extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenHeight = MediaQuery.of(context).size.height;
    final formItems = ref.watch(formItemProvider);
    return ref.watch(getLandingViewContentProvider).when(
          data: (webContent) {
            final productDetails =
                webContent.products!.map((product) => product.title).toList();
            return Card(
                color: Theme.of(context).colorScheme.onPrimary,
                elevation: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Kategori',
                              textDirection: TextDirection.ltr,
                              style: Theme.of(context).textTheme.labelMedium,
                            ), // textdirection text sola yaslar
                            const Spacer(),
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Ürün',
                                textDirection: TextDirection.ltr,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            Text(
                              'Miktar',
                              textDirection: TextDirection.ltr,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1000,
                        height: MediaQuery.of(context).size.height / 4,
                        padding: const EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          itemCount: formItems.length,
                          itemBuilder: (context, index) {
                            return _buildItem(context, formItems[index], index,
                                ref, productDetails);
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 10.0, bottom: 10.0),
                        child: InkWell(
                          onTap: () => ref
                              .read(formItemProvider.notifier)
                              .addItem(FormItem()),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => Text('Bir hata oluştu'),
        );
  }

  Widget _buildItem(BuildContext context, FormItem formItem, int index,
      WidgetRef ref, List<String?> productDetails) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: InkWell(
            child: Icon(Icons.close),
            onTap: () {
              ref.read(formItemProvider.notifier).removeItem(index);
            },
          ),
        ),
        Expanded(
          child: DropdownButtonFormField(
            menuMaxHeight: 100,
            alignment: Alignment.centerLeft,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.onPrimary,
              constraints: const BoxConstraints(maxHeight: 40),
              border: const OutlineInputBorder(),
              hintText: 'Kategori',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
            // isExpanded: true,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              textDirection: TextDirection.rtl,
            ),
            iconSize: 24,
            // elevation: 16,
            items: productDetails.map((detail) {
              return DropdownMenuItem(
                value: detail,
                child: Text(
                  truncateToTwoWords(detail!),
                ),
              );
            }).toList(),
            onChanged: (value) {
              formItem.category = value;
            },
            // hint: Text(
            //   'Kategori',
            //   style: Theme.of(context).textTheme.bodySmall,
            //   textAlign: TextAlign.start,
            // ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: TextFormField(
            cursorColor: Theme.of(context).colorScheme.onBackground,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.onPrimary,
              border: const OutlineInputBorder(),
              constraints: BoxConstraints(maxHeight: 40),
              labelText: 'Ürün',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              labelStyle: Theme.of(context).textTheme.bodySmall,
            ),
            onChanged: (value) {
              formItem.product = value;
            },
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(
          child: TextFormField(
            cursorColor: Theme.of(context).colorScheme.onBackground,
            decoration: InputDecoration(
              constraints: const BoxConstraints(maxHeight: 40),
              filled: true,
              fillColor: Theme.of(context).colorScheme.onPrimary,
              border: const OutlineInputBorder(),
              labelText: 'Miktar',
              labelStyle: Theme.of(context).textTheme.bodySmall,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              suffixText: 'adet',
            ),
            onChanged: (value) {
              formItem.amount = value;
            },
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        InkWell(
          child: const Icon(Icons.attach_file),
          onTap: () {},
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
