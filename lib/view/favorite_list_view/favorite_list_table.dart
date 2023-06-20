

import 'package:flutter/material.dart';

class favoriteListTable extends StatefulWidget {
  const favoriteListTable({Key? key}) : super(key: key);

  @override
  _FavoriteListTable createState() => _FavoriteListTable();
}

class _FavoriteListTable extends State<favoriteListTable> {
  List<Widget> _items = [];
  final categories = ["Category 1", "Category 2", "Category 3"];
  String? selectedCategories;
  bool masterCheckBox = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addNewItem();
    });
  }

  void _addNewItem() {
    _items.add(_buildItem(key: UniqueKey(), isChecked: masterCheckBox));
    setState(() {});
  }

  void _removeItem(Key key) {
    _items.removeWhere((widget) => widget.key == key);
    setState(() {});
  }

  Widget _buildItem({required Key? key, required bool isChecked}) {
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
                                key: item.key, isChecked: value ?? false);
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
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                InkWell(
                  child: const Icon(Icons.attach_file),
                  onTap: () {
                    
                  },
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

  Widget _updateItemCheckbox(Widget item, bool value) {
    final key = item.key;
    final isChecked = value;
    return _buildItem(key: key, isChecked: isChecked);
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
                      setState(() {
                        masterCheckBox = value ?? false;
                        _items = _items.map((item) {
                          return _updateItemCheckbox(item, masterCheckBox);
                        }).toList();
                      });
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
              onTap: () => _addNewItem(),
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
