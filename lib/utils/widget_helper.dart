import 'dart:collection';
import 'dart:js' as js;
import 'package:flutter/material.dart';

Map<String, String> statusIconMap = {
  'pending': 'assets/proposal_pending.svg',
  'replied': 'assets/exportNotes.svg',
  'proposal_stvs': 'assets/exportNotes.svg',
  'last_offer': 'assets/exportNotes.svg',
  'order_approved': 'assets/exportNotes.svg',
  'order_confirmed': 'assets/conveyor.svg',
  'order_prepared': 'assets/trolley.svg',
  'order_on_the_way': 'assets/shipment.svg',
  'order_delivered': 'assets/warehouse.svg',
  'invoice_paid': 'assets/paid.svg',
  'invoice_discounted': 'assets/paid.svg',
  'invoice_goods_delivered': 'assets/exportNotes.svg',
  'invoice_approved_dbs': 'assets/DBS.svg',
  'invoice_collecting': 'assets/paymentProcess.svg',
  'invoice_approved': 'assets/notsecure.svg',
  'delivered': 'assets/package.svg',
};

// formating dateTime
String formattedDate(String date) {
  if (date == 'null') {
    return '-';
  } else {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year.toString().padLeft(2, '0')}";
  }
}

String formettedDateAndTime(String date) {
  if (date == 'null') {
    return '-';
  } else {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day}-${parsedDate.month.toString().padLeft(2, '0')} ${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}";
  }
}

String formattedTime(String date) {
  if (date == 'null') {
    return '-';
  } else {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.hour}:${parsedDate.minute.toString().padLeft(2, '0')}";
  }
}

// calculate amount for big card table
String calcuteAmount(String amount, String price) {
  return (double.parse(amount) * double.parse(price)).toString();
}

String truncateToTwoWords(String text) {
  var words = text.split(' ');
  if (words.length > 3) {
    words = words.take(3).toList();
    return '${words.join(' ')}...';
  }
  return text;
}

String checkPaymentType(String paymentType) {
  if (paymentType == 'null') {
    return 'Cari Hesap';
  } else {
    return paymentType;
  }
}

String checkTraking(bool tracking) {
  if (tracking == true) {
    return 'Satıcı';
  } else {
    return 'Alıcı';
  }
}

bool checkShipmentState(String status) {
  return status == 'order_on_the_way';
}

bool checkOrderState(String status) {
  return status == 'order_confirmed' ||
      status == 'order_prepared' ||
      status == 'order_on_the_way' ||
      status == 'order_delivered';
}

bool isFilesAttached(List<dynamic> list) {
  for (var element in list) {
    if (element.productFiles!.entries.isNotEmpty ||
        element.productsProposalFiles!.entries.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  throw Exception('No files found in list');
}

Widget showProductFiles(Map productFiles) {
  if (productFiles.entries.isNotEmpty) {
    return IconButton(
      iconSize: 25,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.image_outlined),
      onPressed: () {
        js.context.callMethod('open', [
          productFiles.values.first.toString()
          // .replaceAll("http://", "https://")
        ]);
      },
    );
  } else {
    return const Text('-');
  }
}

Widget showProductsProposalFiles(Map productsProposalFiles) {
  if (productsProposalFiles.entries.isNotEmpty) {
    return IconButton(
      iconSize: 25,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.image_outlined),
      onPressed: () {
        js.context.callMethod(
            'open', [productsProposalFiles.values.first.toString()]);
      },
    );
  } else {
    return const Text('-');
  }
}

String invoiceBigCardHeader(
    String status, String paymentDate, String invoiceDate) {
  if (status == 'invoice_approved') {
    return formattedDate(paymentDate);
  } else {
    return formattedDate(invoiceDate);
  }
}

String invoiceSmallCardHeaderDate(
    String status, String paymentDate, String invoiceDate) {
  if (status == 'invoice_goods_delivered') {
    return formattedDate(invoiceDate);
  } else {
    return formattedDate(paymentDate);
  }
}

String bigCardHeader(String status, String className) {
  if (status == 'invoice_approved') {
    return 'Ödeme Tarihi: ';
  } else if (className == 'invoice' && status != 'invoice_approved') {
    return 'Fatura Tarihi: ';
  } else if (className == 'shipment' && status == 'order_on_the_way') {
    return 'Sevk Tarihi: ';
  } else if (className == 'proposal') {
    return 'Teklif No: ';
  } else {
    return 'Sipariş No: ';
  }
}

String getOrderIdFromShipmentProductList(List<dynamic> list) {
  for (var element in list) {
    return element.orderId.toString();
  }
  throw Exception('No orderId found in shipmentProductList');
}

Widget bigCardOrderTable(
    String status, Widget orderTable, Widget orderTableState) {
  if (status == 'order_approved' || status == 'order_pending') {
    return orderTable;
  } else {
    return orderTableState;
  }
}

String getCurrencySymbol(String currencyCode) {
  switch (currencyCode) {
    case 'TRY':
      return '₺';
    case 'EUR':
      return '€';
    case 'USD':
      return '\$';
    default:
      return currencyCode;
  }
}

Map<String, String> calculateTaxRate(List<dynamic> productList) {
  Map<String, double> taxRateMap = {};
  Map<String, String> getTotalCost = {};
  double? total;
  double taxRate = 0.0;
  late double totalWithoutTax;
  late double totalPrice;
  totalPrice = 0.0;
  totalWithoutTax = 0.0;
  String currencyCode = "empty";

  for (var product in productList) {
    total = (product.price ?? 1) *
        product.amount; //calculate total price only one product
    totalWithoutTax += total!; //calculate total price without tax
    taxRate = product.taxRate ?? 0.0;

    if (product.currencyCode != null && currencyCode == "empty") {
      currencyCode = product.currencyCode.toString();
    }

    if (taxRateMap.containsKey(taxRate)) {
      taxRateMap[taxRate.toString()] =
          taxRateMap[taxRate]! + (total * taxRate / 100); //calculate tax rate
    } else {
      taxRateMap[taxRate.toString()] = (total * taxRate / 100);
    }
  }

  taxRateMap.forEach((key, value) {
    totalPrice += value; //calculate total price with tax
  });

  taxRateMap["totalWithoutTax"] =
      totalWithoutTax; //calculate total price without tax
  taxRateMap["total"] =
      totalPrice + totalWithoutTax; //calculate total price with tax

  getTotalCost["Toplam Tutar:"] =
      '${taxRateMap["totalWithoutTax"].toString()} ${getCurrencySymbol(currencyCode)}';
  for (var product in productList) {
    getTotalCost["KDV(%${product.taxRate}):"] =
        '${taxRateMap[product.taxRate.toString()].toString()} ${getCurrencySymbol(currencyCode)}';
  }
  getTotalCost["Toplam:"] =
      '${taxRateMap["total"].toString()} ${getCurrencySymbol(currencyCode)}';

  return getTotalCost;
}
