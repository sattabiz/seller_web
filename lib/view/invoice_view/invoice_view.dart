import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/utils/widget_helper.dart';
import 'package:seller_point/view/widget/big_card%20/info/info_invoice.dart';

import '../../model/get_buyer_invoices_list_model.dart';
import '../../view_model/buyer_invoices_view_model.dart';
import '../../view_model/invoice_approved_view_model.dart';
import '../widget/big_card /buttons/button_widget.dart';
import '../widget/big_card /header/header.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/small_card/header/header_invoice.dart';
import '../widget/small_card/small_card.dart';


class InvoiceView extends ConsumerWidget {
  const InvoiceView({Key? key}) : super(key: key);
  final String className = 'invoice';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceListAsyncValue = ref.watch(getInvoicesProvider);

    return invoiceListAsyncValue.when(
      data: (invoiceList) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: constraints.maxHeight > 300,
                    child: allMainPageContent(
                      topic: FlutterI18n.translate(context, 'tr.invoice.invoices')
                    ),
                  ),
                  Flexible(
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: getCrossAxisCount(constraints),
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      itemCount: invoiceList.length,
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        return SmallCard(
                          index: index,
                          id: invoiceList[index].invoiceId.toString(),
                          className: className,
                          status: invoiceList[index].state.toString(),
                          headerDate: invoiceList[index].invoiceDate.toString(),
                          bodyHeader: 'Fatura No: ${invoiceList[index].invoiceNo.toString()}',
                          bodyList: invoiceList[index].products!,
                          headerSmallCard: HeaderInvoice(
                            id: invoiceList[index].invoiceId.toString(),
                            status: invoiceList[index].state.toString(),
                            headerDate: invoiceBigCardHeader(invoiceList[index].state.toString(), invoiceList[index].paymentDate.toString(), invoiceList[index].invoiceDate.toString()), //statuye gore odeme tarihi ile degistirilecek
                            newMessageSvg: newMessageSvg, 
                            className: className
                          ),
                          bigCardHeader: Header(
                            className: className,
                            id: invoiceBigCardHeader(invoiceList[index].state.toString(), invoiceList[index].paymentDate.toString(), invoiceList[index].invoiceDate.toString()),
                            status: invoiceList[index].state.toString(),
                          ),
                          infoWidget: InfoInvoice(
                            status: invoiceList[index].state.toString(),
                            invoiceNo: invoiceList[index].invoiceNo.toString(), 
                            invoiceDate: invoiceList[index].invoiceDate.toString(),
                            paymentType: checkPaymentType(invoiceList[index].paymentType.toString()), 
                            orderId: invoiceList[index].orderId.toString(), 
                            className: className),
                          bigCardButtons: 
                          invoiceList[index].state.toString() == 'invoice_goods_delivered' //degistirdim 
                          ? ButtonWidget(
                              className: className,
                              status: invoiceList[index].state.toString(),
                              onPressed: () async{
                                ref.read(idProvider.notifier).state=invoiceList[index].invoiceId.toString();
                                ref.watch(shipmentDeliveredProvider);
                                Navigator.pop(context);
                              },
                            )
                          : const SizedBox(height: 20),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      loading: () => const LoadingWidget(),
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/login');
        });
        return Text('An error occurred: $error');
      },
    );
  }

  int getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 900) {
      return 3;
    } else if (constraints.maxWidth > 550) {
      return 2;
    } else {
      return 1;
    }
  }
}
