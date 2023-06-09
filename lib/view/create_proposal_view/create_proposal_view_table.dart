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
  return FormItemsNotifier([]);
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
    final formItems = ref.watch(formItemProvider);
    return ref.watch(getLandingViewContentProvider).when(
          data: (webContent) {
            final productDetails = webContent.products!
                .map((product) => product.productDetails)
                .toList();
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: Row(
                      children: const [
                        SizedBox(
                          width: 50,
                        ),
                        Expanded(flex: 4, child: Text('Kategori')),
                        Spacer(
                          flex: 2,
                        ),
                        Expanded(flex: 8, child: Text('Ürün')),
                        Spacer(
                          flex: 4,
                        ),
                        Expanded(flex: 3, child: Text('Miktar')),
                        SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 350),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: [
                          for (var i = 0; i < formItems.length; i++)
                            _buildItem(
                                context, formItems[i], i, ref, productDetails),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
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
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => Text('Bir hata oluştu'),
        );
  }

  Widget _buildItem(BuildContext context, FormItem formItem, int index,
      WidgetRef ref, List<String?> productDetails) {
    return Column(
      children: [
        Row(
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
              flex: 2,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                isExpanded: true,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                items: productDetails.map((detail) {
                  return DropdownMenuItem(
                    value: detail,
                    child: Text(
                      truncateToTwoWords(detail!),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  formItem.category = value as String?;
                },
                hint: Text('Kategori Seç'),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 4,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün',
                  suffixText: 'adet',
                ),
                onChanged: (value) {
                  formItem.product = value;
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Miktar',
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
              width: 16,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
