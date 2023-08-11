import 'dart:html';

Map<String, String> statusIconMap = {
  'pending': 'assets/proposal_pending.svg',
  'replied': 'assets/exportNotes.svg',
  'proposal_stvs': 'assets/exportNotes.svg',
  'last_offer': 'assets/exportNotes.svg',
  // 'order_pending': 'assets/exportNotes.svg',
  'order_approved': 'assets/exportNotes.svg',
  'order_confirmed': 'assets/conveyor.svg',
  'order_prepared': 'assets/trolley.svg',
  'order_on_the_way': 'assets/shipment.svg',
  'order_delivered': 'assets/warehouse.svg',
  'invoice_goods_delivered': 'assets/pending.svg',
  'invoice_discounted': 'assets/paid.svg',
  'invoice_approved_dbs': 'assets/DBS.svg',
  'invoice_approved': 'assets/notsecure.svg',
  'invoice_collecting': 'assets/paymentProcess.svg',
  'delivered': 'assets/package.svg',
};

// formating dateTime
String formattedDate(String date) {
  if (date == 'null') {
    return '-';
  } else {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
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

String costCalc(List<dynamic> productsProposalList, String className,
    {double taxRate = 18.3}) {
  late int itemAmount;
  late double itemPrice;
  late double itemRawCost;

  double allItemsRawCost = 0;
  late double taxAmount;
  late double allItemsTotalCost;

  String currencyCode = "empty";

  for (var item in productsProposalList) {
    if (item.currencyCode != null && currencyCode == "empty") {
      currencyCode = item.currencyCode.toString();
    }

    itemAmount = item.amount ?? 0;
    itemPrice = item.price ?? 1; //price is null for now !

    itemRawCost = itemAmount * itemPrice;
    allItemsRawCost += itemRawCost;
  }
  taxAmount = allItemsRawCost * (taxRate / 100);
  allItemsTotalCost = allItemsRawCost + taxAmount;

  switch (className) {
    case "raw_cost":
      return '${allItemsRawCost.toStringAsFixed(2)} $currencyCode';
    case "tax_amount":
      return '${taxAmount.toStringAsFixed(2)} $currencyCode';
    case "total_cost":
      return '${allItemsTotalCost.toStringAsFixed(2)} $currencyCode';
    default:
      return '--';

    /* return '$allItemsRawCost $currencyCode';  */
  }
}



/* productsProposalList.map((item) => item.amount.toString()).reduce((value, element) => value + element); */




// class ScreenSize {
//    MediaQueryData ?mediaQueryData;
//    double ?screenWidth;
//    double ?screenHeight;
//    double ?widthLarge;
//    double ?heightLarge;


//   //  ScreenSize( {
//   //   Key? key,
//   //   this.mediaQueryData,
//   //   this.screenWidth,
//   //   this.screenHeight,
//   //   this.widthLarge,
//   //   this.heightLarge,
//   // });


//   void init(BuildContext context) {
//     mediaQueryData = MediaQuery.of(context);
//     screenWidth = mediaQueryData!.size.width;
//     screenHeight = mediaQueryData!.size.height;
//     widthLarge = screenWidth! / 1280 ;
//     heightLarge = screenHeight! / 720 ;

//   }

// }
