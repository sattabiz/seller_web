import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/web_content_model.dart';
import '../../utils/widget_helper.dart';
import '../../view_model/landing_view_model.dart';
import 'create_proposal_show_dialog.dart';

class FormItem {
  String? category;
  String? product;
  String? amount;
  String? unit;
  MultipartFile? image;
  String? filename = '  ';

  FormItem(
      {this.category, this.product, this.amount, this.unit, this.image, this.filename});
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

  void updateImage(int index, MultipartFile images) {
    if (index >= 0 && index < state.length) {
      state[index].image = images;
      state = [...state];
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.length) {
      state[index].image = null;
      state = [...state];
    }
  }

  void removeItem(int index) {
    state = state.where((element) => state.indexOf(element) != index).toList();
  }

  bool isImageSelected(int index) {
    if (index >= 0 && index < state.length) {
      if (state[index].image == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}

bool changeIcon(int index, WidgetRef ref) {
  if (ref.watch(formItemProvider.notifier).isImageSelected(index) == true) {
    return true;
  } else {
    return false;
  }
}
  // bool _validate = false;
  //  TextEditingController productController = TextEditingController();
  //  TextEditingController amountController = TextEditingController();
  //  TextEditingController dropDownController = TextEditingController();
  //  final _formKeyTable = GlobalKey<FormState>();


class createProposalViewTable extends ConsumerStatefulWidget {
  const createProposalViewTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _createProposalViewTableState();
}

class _createProposalViewTableState extends ConsumerState<createProposalViewTable> {

  @override
  Widget build(BuildContext context,) {
    final formItems = ref.watch(formItemProvider);
    return ref.watch(getLandingViewContentProvider).when(
          data: (webContent) {
            final productDetails =
                webContent;
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
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
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
      WidgetRef ref, WebContentModel productDetails) {
    double screenWidth = MediaQuery.of(context).size.width / 1250;
    double screenHeight = MediaQuery.of(context).size.height / 720;

    final List<DropdownMenuEntry<String>> dropDownMenuCategory =
        <DropdownMenuEntry<String>>[];
    productDetails.products!.map((product) => product.title).toList().map((detail) {
      dropDownMenuCategory.add(
        DropdownMenuEntry<String>(
          value: detail.toString(),
          label: truncateToTwoWords(detail!),
        ),
      );
    }).toList();

    return Form(
      // key: _formKeyTable,
      child: Flex(
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
            int index = productDetails.products!.map((product) => product.title).toList().indexWhere((element) => element == value);
            formItem.unit = productDetails.products![index].unit;
            setState(() {
              
            });
           
          },
          ),
          const Spacer(
            flex: 1,
          ),
          Expanded(
            flex: 10,
            child: TextFormField(
              cursorColor: Theme.of(context).colorScheme.onBackground,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                // errorText: _validate ? 'Value Cant Be Empty' : null,
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
              // validator: (String? value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Lütfen ürün giriniz.';
              //   }
              //   return null;
              // },
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
                autocorrect: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
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
                  suffixText:formItem.unit,
                ),
                onChanged: (value) {
                  formItem.amount = value;
                },
                // validator: (String? value) {
                //   if (value == "" || value!.isEmpty) {
                //     print("aaaaaaaaaaaa");
                //     return 'Lütfen miktar giriniz.';
                //   }
                //   return null;
                // },
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: IconButton(
              icon: Icon(changeIcon(index, ref)
                  ? Icons.image_outlined
                  : Icons.attach_file),
              iconSize: 25,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CreateProposalShowDialog(itemIndex: index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
