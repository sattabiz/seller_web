import 'package:file_picker/file_picker.dart';
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
    final formItems = ref.watch(formItemProvider);
    return ref.watch(getLandingViewContentProvider).when(
          data: (webContent) {
            final productDetails =
                webContent.products!.map((product) => product.title).toList();
            return Card(
              color: Theme.of(context).colorScheme.onPrimary,
              surfaceTintColor: Theme.of(context).colorScheme.onPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
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
                        Expanded(flex: 4, child: Text('Miktar')),
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
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(
                        parent: ClampingScrollPhysics(),
                      )),
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
                    padding: const EdgeInsets.only(
                        left: 10.0, bottom: 18.0, top: 10.0),
                    child: InkWell(
                      hoverColor: Colors.transparent,
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
    double screenWidth = MediaQuery.of(context).size.width / 1250;
    double screenHeight = MediaQuery.of(context).size.height / 720;

    final List<DropdownMenuEntry<String>> dropDownMenuCategory =
        <DropdownMenuEntry<String>>[];
    productDetails.map((detail) {
      dropDownMenuCategory.add(
        DropdownMenuEntry<String>(
          value: detail.toString(),
          label: truncateToTwoWords(detail!),
        ),
      );
    }).toList();

    return Flex(
      direction: Axis.horizontal,
      children: [
        SizedBox(
          width: 50,
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: InkWell(
              hoverColor: Colors.transparent,
              child: const Icon(Icons.close),
              onTap: () {
                ref.read(formItemProvider.notifier).removeItem(index);
              },
            ),
          ),
        ),
        DropdownMenu<String>(
          menuHeight: 100,
          width: screenWidth * 160,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Theme.of(context).colorScheme.onPrimary,
            constraints: const BoxConstraints(maxHeight: 40),
            contentPadding: const EdgeInsets.only(left: 10.0),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          label: Text(
            'Kategori',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.start,
          ),
          menuStyle: MenuStyle(
            fixedSize: MaterialStateProperty.all(Size(screenWidth * 160, 100)),
            alignment: AlignmentGeometry.lerp(
              Alignment.bottomLeft,
              Alignment.bottomLeft,
              0.5,
            ),
          ),
          dropdownMenuEntries: dropDownMenuCategory,
          onSelected: (value) {
            formItem.category = value;
          },
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: Container(
            // width: 460,
            // constraints:  BoxConstraints(maxWidth: screenWidth * 430, minWidth: screenWidth * 50),
            child: TextFormField(
              cursorColor: Theme.of(context).colorScheme.onBackground,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, bottom: 0.0, right: 0.0),
                constraints: const BoxConstraints(maxHeight: 40),
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
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 4,
          child: Container(
            width: 120,
            // constraints: BoxConstraints(maxWidth: screenWidth * 120, minWidth: screenWidth * 40),
            child: TextFormField(
              cursorColor: Theme.of(context).colorScheme.onBackground,
              decoration: InputDecoration(
                constraints: const BoxConstraints(maxHeight: 40),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.only(
                    left: 10.0, top: 0.0, bottom: 0.0, right: 5.0),
                labelText: 'Miktar',
                labelStyle: Theme.of(context).textTheme.bodySmall,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                suffixText: 'adet',
                // suffixStyle: TextStyle(
                //   textBaseline: TextBaseline.ideographic
                // ),
              ),
              onChanged: (value) {
                formItem.amount = value;
              },
            ),
          ),
        ),
        SizedBox(
          width: 50,
          child: IconButton(
            icon: const Icon(Icons.attach_file),
            iconSize: 25,
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
            },
          ),
        ),
      ],
    );
  }
}
