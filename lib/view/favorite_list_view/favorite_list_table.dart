

import 'package:flutter/material.dart';
import 'package:seller_point/model/get_favorite_list_model.dart';

import '../../utils/widget_helper.dart';

class favoriteListTable extends StatefulWidget {
  List<Product> items;
  favoriteListTable({required this.items, Key? key}) : super(key: key);

  @override
  _FavoriteListTable createState() => _FavoriteListTable();
}

class _FavoriteListTable extends State<favoriteListTable> {
  final categories = ["Category 1", "Category 2", "Category 3"];
  String? selectedCategories;
  bool masterCheckBox = false;

  List<Widget> _items = []; // We need to declare our list in the state class

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (var product in widget.items) {
        _addNewItem(product: product);
      }
    });
  }

  void _addNewItem({required Product product}) {
    _items.add(_buildItem(
        key: UniqueKey(), isChecked: masterCheckBox, product: product));
    setState(() {});
  }

  void _removeItem(Key key) {
    _items.removeWhere((widget) => widget.key == key);
    setState(() {});
  }

  Widget _buildItem({required Key? key, required bool isChecked, required Product product}) {
    double screenWidth = MediaQuery.of(context).size.width / 1250;
    final List<DropdownMenuEntry<String>> dropDownMenuCategory = <DropdownMenuEntry<String>>[];
    _items.map((detail) {
      dropDownMenuCategory.add(
        DropdownMenuEntry<String>(
          value: detail.toString(),
          label: truncateToTwoWords(detail.toString()),
        ),
      );
    }).toList();
    final itemKey = GlobalKey();
    return Flex(
      direction: Axis.horizontal,
      children: [
        Padding(
          padding: EdgeInsets.all(11.0),
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                _items = _items.map((item) {
                  if (item.key == itemKey) {
                    return _buildItem(
                        key: item.key,
                        isChecked: value ?? false,
                        product: product);
                  } else {
                    return item;
                  }
                }).toList();
              });
            },
          ),
        ),
        ClipRRect(
          child: DropdownMenu<String>(
            menuHeight: 100,
            width: screenWidth * 165,
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
              // formItem.category = value;
            },
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 10,
          child: TextFormField(
            initialValue: product.name,
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
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 4,
          child: TextFormField(
            initialValue: product.requesterAmount.toString(),
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
            ),
          ),
        ),
        InkWell(
          child: const Icon(Icons.attach_file),
          onTap: () {},
        ),
      ],
    );
  }

 

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Checkbox(
                    value: masterCheckBox,
                    onChanged: (value) {
                      
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(flex: 4, child: Text('Kategori')),
                Spacer(
                  flex: 2,
                ),
                Expanded(flex: 9, child: Text('Ürün')),
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
            constraints: const BoxConstraints(maxHeight: 400),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: [
                  ..._items,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
