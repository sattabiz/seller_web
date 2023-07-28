
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
    'invoice_paid': 'assets/paid.svg',
    'invoice_discounted': 'assets/paymentProcess.svg',
    'invoice_approved_dbs': 'assets/DBS.svg',
    'invoice_pending': 'assets/pending.svg',
    'delivered': 'assets/package.svg',
  };

  // formating dateTime
  String formattedDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
  }
  
  // calculate amount for big card table
  String calcuteAmount(String amount, String price) {
    return (int.parse(amount) * int.parse(price)).toString();
  }

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
