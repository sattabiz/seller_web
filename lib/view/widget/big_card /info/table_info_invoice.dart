import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/utils/widget_helper.dart';

import '../../../../view_model/buyer_invoices_view_model.dart';

class TableInfoInvoice extends ConsumerWidget {
  final List<dynamic> productList;
  final String className;
  final String? price;
  final String? priceWithoutVat;
  final bool isFileAttached;
  final bool isPending;

  const TableInfoInvoice({
    Key? key,
    required this.productList,
    required this.className,
    this.price,
    this.priceWithoutVat,
    required this.isFileAttached,
    required this.isPending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
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

    Widget buildWidget() {
      if (className == "invoice") {
        String? currenciesValue = ref.watch(invoiceCurrenciesIndexProvider);
        return Text(
          currenciesValue!,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w400, color: Colors.black),
        );
      } else {
        return Container();
      }
    }
    
    Widget buildPrice(String? value){
      return Container(
        margin: const EdgeInsets.only(top: 5.0),
        alignment: Alignment.centerRight,
         // width: 50,
        child: Text(
          value!,
          maxLines: 1,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w400),
          ),
        );
    }

    double splitString(price){                             //Split prive and price_without_vat for KDV
      List<String>? value= price?.split(" ");
      double parsedPrice = double.parse((value![0]).replaceAll(",", "."));
      
      return parsedPrice;
    }

    String kdv = (splitString(price)-splitString(priceWithoutVat)).toStringAsFixed(2);    //KDV value
    

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 5.0, right: 20.0, bottom: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30.0),
                    alignment: Alignment.bottomLeft,
                    child: buildWidget(),
                  ),
                ),
                const Spacer(flex: 1,),
                Flexible(child: Column(children: keys)),
                Flexible(child: Column(children: [buildPrice(priceWithoutVat), buildPrice("$kdv ₺"), buildPrice(price)])),
                isFileAttached == true
                    ? const SizedBox(width: 100)
                    : const SizedBox(width: 0),
              ]),
        ),
      ),
    );
  }
}
