

import 'package:flutter/material.dart';
import 'package:seller_point/model/get_favorite_list_model.dart';

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

  Widget _buildItem(
      {required Key? key, required bool isChecked, required Product product}) {
    final itemKey = GlobalKey();
    return Column(
      key: itemKey,
      children: [
        Column(
          children: <Widget>[
            Row(
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
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    items: categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // handle category change
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
                    ),
                    initialValue: product.name,
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
                    initialValue: product.requesterAmount.toString(),
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
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

 

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              children: [
                SizedBox(
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
