import 'package:flutter/material.dart';
import 'package:seller_point/utils/widget_helper.dart';

class TableInfoPanel extends StatelessWidget {
  final List<dynamic> productList;
  final bool isPending;

  const TableInfoPanel({
    Key? key,
    required this.productList,
    required this.isPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: calculateTaxRate(productList)
              .entries
              .map((entry) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(entry.key)
                        ),
                        isPending
                        ? const Text("-")
                        : Text(entry.value.toString()),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
