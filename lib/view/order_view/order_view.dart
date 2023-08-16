import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/utils/widget_helper.dart';
import 'package:seller_point/view/widget/big_card%20/info/info.dart';
import 'package:seller_point/view/widget/loading_widget.dart';
import '../../view_model/order_list_view_model.dart';
import '../widget/big_card /buttons/button_widget.dart';
import '../widget/big_card /header/header.dart';
import '../widget/main_page_content.dart';
import '../widget/small_card/header/header_order.dart';
import '../widget/small_card/small_card.dart';

class OrderView extends ConsumerWidget {
  const OrderView({Key? key}) : super(key: key);
  final String className = 'order';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListAsyncValue = ref.watch(getOrderListProvider);
    return orderListAsyncValue.when(
      data: (orderList) {
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
                        topic:
                            FlutterI18n.translate(context, 'tr.order.orders')),
                  ),
                  Flexible(
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: getCrossAxisCount(constraints),
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      itemCount: orderList.length,
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        return SmallCard(
                          index: index,
                          id: orderList[index].id.toString(),
                          className: className,
                          status: orderList[index].state.toString(),
                          headerDate: orderList[index].orderDate.toString(),
                          bodyHeader: orderList[index].demandName.toString(),
                          bodyList: orderList[index].products,
                          headerSmallCard: HeaderOrder(id: orderList[index].id.toString(),status: orderList[index].state.toString(),headerDate: formattedDate(orderList[index].orderDate.toString()),newMessageSvg: newMessageSvg, className: className),
                          bigCardHeader: Header(
                            id: orderList[index].id.toString(),
                            className: className,
                            status: orderList[index].state.toString(),
                          ),
                          infoWidget: Info(
                            className: className,
                            demandName: orderList[index].demandName.toString(),
                            infoRow1: formattedDate( orderList[index].orderDate.toString()),
                            infoRow2: orderList[index].deliveryDate.toString(),
                            infoRow3: checkPaymentType(orderList[index].paymentType.toString()),
                            infoRow4: orderList[index].paymentDueDate.toString(),
                            infoRow5: orderList[index].demandNo.toString(),
                            infoRow6: 'Satici', // tracking payment is missing in order model.
                          ),
                          bigCardButtons: ButtonWidget(
                            className: className,
                            status: orderList[index].state.toString(),
                          ),
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
