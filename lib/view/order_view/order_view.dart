import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/utils/widget_helper.dart';
import 'package:seller_point/view/widget/big_card%20/big_card.dart';
import 'package:seller_point/view/widget/big_card%20/info/info.dart';
import 'package:seller_point/view/widget/big_card%20/info/table_info_panel.dart';
import 'package:seller_point/view/widget/loading_widget.dart';
import 'package:seller_point/view/widget/small_card/body/small_card_order_by_state.dart';
import '../../view_model/order_list_view_model.dart';
import '../widget/big_card /buttons/button_widget.dart';
import '../widget/big_card /header/header.dart';
import '../widget/big_card /table/order_table.dart';
import '../widget/big_card /table/order_table_status.dart';
import '../widget/main_page_content.dart';
import '../widget/small_card/body/body_header.dart';
import '../widget/small_card/body/small_card_table.dart';
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
                      staggeredTileBuilder: (index) =>
                          const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        return SmallCard(
                          id: orderList[index].id.toString(),
                          className: className,
                          messageId:'order_id=${orderList[index].id}',
                          createMessageMap:{'order_id': orderList[index].id} ,
                          status: orderList[index].state.toString(),
                          headerSmallCard: HeaderOrder(
                              id: orderList[index].id.toString(),
                              status: orderList[index].state.toString(),
                              headerDate: formattedDate(
                                  orderList[index].orderDate.toString()),
                              newMessageSvg: newMessageSvg(orderList[index].notification!, orderList[index].messageNotification!), 
                              className: className),
                          bodyHeader: BodyHeader(
                            bodyHeader: orderList[index].demandName.toString(),
                          ),
                          smallCardTable: 
                          checkOrderState(orderList[index].state.toString())
                            ? SmallCardOrderByState(
                              id: orderList[index].id.toString(),
                              status: orderList[index].state.toString(),
                              className: className,
                              bodyList: orderList[index].products,
                            )
                            : SmallCardTable(
                              id: orderList[index].id.toString(),
                              status: orderList[index].state.toString(),
                              className: className,
                              bodyList: orderList[index].products,
                            ),
                          bigCard: BigCard(
                            id: orderList[index].id.toString(),
                            bigCardHeader: Header(
                              id: orderList[index].id.toString(),
                              className: className,
                              status: orderList[index].state.toString(),
                            ),
                            bigCardTable: bigCardOrderTable(
                              orderList[index].state.toString(),
                                OrderTable(
                                  className: className,
                                  productList: orderList[index].products,
                                  filesAttached: isFilesAttached(orderList[index].products)
                                ),
                                OrderTableStatus(
                                  status: orderList[index].state.toString(),
                                  productList: orderList[index].products,
                                  filesAttached: isFilesAttached(orderList[index].products)
                                )
                            ),
                            // tableInfoPanel: 
                            // checkOrderState(orderList[index].state.toString())
                            // ? null
                            // : TableInfoPanel(
                            //     productList: orderList[index].products,
                            //     isPending: false,
                            //     isFileAttached: isFilesAttached(orderList[index].products)
                            // ),
                            buttons: ButtonWidget(
                              className: className,
                              status: orderList[index].state.toString(),
                            ),
                            infoWidget: Info(
                              className: className,
                              demandName:
                                  orderList[index].demandName.toString(),
                              infoRow1: formattedDate(
                                  orderList[index].orderDate.toString()),
                              infoRow2: formattedDate(
                                  orderList[index].deliveryDate.toString()),
                              infoRow3: checkPaymentType(
                                  orderList[index].paymentType.toString()),
                              infoRow4:
                                  orderList[index].paymentDueDate.toString(),
                              infoRow5: orderList[index].demandNo.toString(),
                              infoRow6: checkTraking(
                                  orderList[index].includeShipmentCost!),
                            ),
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
