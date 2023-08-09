import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/view/widget/big_card%20/info/info_invoice.dart';

import '../../model/get_buyer_invoices_list_model.dart';
import '../../view_model/buyer_invoices_view_model.dart';
import '../widget/appbar.dart';
import '../widget/big_card /buttons/button_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/nav_drawer.dart';
import '../widget/nav_rail.dart';
import '../widget/small_card/small_card.dart';


class invoiceView extends ConsumerWidget {
  const invoiceView({Key? key}) : super(key: key);
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
                          infoWidget: InfoInvoice(
                            invoiceNo: invoiceList[index].invoiceNo.toString(), 
                            invoiceDate: invoiceList[index].invoiceDate.toString(),
                            paymentType: invoiceList[index].paymentType.toString(), 
                            orderId: invoiceList[index].orderId.toString(), 
                            className: className),
                          bigCardButtons: 
                          invoiceList[index].state.toString() == 'invoice_pending'
                          ? ButtonWidget(
                              className: className,
                              status: invoiceList[index].state.toString(),
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

  Padding buildBody(List<GetInvoicesModel> invoiceList, BuildContext context, String topic, String className) {
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
                  topic: topic,
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
                      infoWidget: InfoInvoice(
                        invoiceNo: invoiceList[index].invoiceNo.toString(), 
                        invoiceDate: invoiceList[index].invoiceDate.toString(),
                        paymentType: invoiceList[index].paymentType.toString(), 
                        orderId: invoiceList[index].orderId.toString(), 
                        className: className),
                      bigCardButtons: 
                      invoiceList[index].state.toString() == 'invoice_pending'
                      ? ButtonWidget(
                          className: className,
                          status: invoiceList[index].state.toString(),
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
