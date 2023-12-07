import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:seller_point/utils/widget_helper.dart';

class TableInfoPanel extends StatelessWidget {
  final List<dynamic> productList;
  final bool isFileAttached;
  final bool isPending;

  const TableInfoPanel({
    Key? key,
    required this.productList,
    required this.isFileAttached,
    required this.isPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(productList.toString());
    List<Widget> keys = calculateTaxRate(productList)
        .entries
        .map((entry) => Container(
              margin: const EdgeInsets.only(top: 5.0),
              alignment: Alignment.centerRight,
              width: 100,
              child: Text(
                entry.key,
                style: Theme.of(context).textTheme.labelLarge,
                maxLines: 1,
              ),
            ))
        .toList();

    List<Widget> values = calculateTaxRate(productList)
        .entries
        .map((entry) => Container(
              margin: const EdgeInsets.only(top: 5.0),
              alignment: Alignment.centerRight,
              width: 100,
              child: Text(
                isPending 
                ? "-"
                : entry.value,
                maxLines: 1,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
                
              ),
            ))
        .toList();

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 5.0, right: 20.0, bottom: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(child: Column(children: keys)),
                Flexible(child: Column(children: values)),
                isFileAttached == true
                    ? const SizedBox(width: 100)
                    : const SizedBox(width: 0),
              ]),
        ),
      ),
    );
  }
}
