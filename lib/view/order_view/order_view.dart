import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/view/widget/loading_widget.dart';
import '../../model/get_order_list_model.dart';
import '../../view_model/order_list_view_model.dart';
import '../../view_model/provider_controller.dart';
import '../widget/appbar.dart';
import '../widget/main_page_content.dart';
import '../widget/nav_drawer.dart';
import '../widget/nav_rail.dart';
import '../widget/small_card/small_card.dart';


class OrderView extends ConsumerWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListAsyncValue = ref.watch(getOrderListProvider);
    return orderListAsyncValue.when(
      data: (orderList) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth <= 1100) {
              return Scaffold(
                appBar: AppbarTop(), //appbar
                body: Row(
                  children: [
                    NavigationRailWidget(),
                    Expanded(child: buildBody(orderList, context, FlutterI18n.translate(context, "tr.order.orders"), "order")),
                  ],
                ),
              );
            } else {
              return Scaffold(
                appBar: AppbarTop(), // appbar
                body: SafeArea(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: NavigationRailDrawer(), //drawer
                      ),
                      Expanded(
                        flex: 10,
                        child: Padding(padding:const EdgeInsets.only(left: 10) ,child: buildBody(orderList, context, FlutterI18n.translate(context, "tr.order.orders"), "order")), //order screen body
                      ),
                    ],
                  ),
                ),
              );
            }
          },
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

  Padding buildBody(List<GetOrderlistModel> orderList, BuildContext context, String topic, String className) {
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
                  itemCount: orderList.length,
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    return SmallCard(
                      index: index,
                      id: orderList[index].id.toString(),
                      className: className,
                      status: orderList[index].state.toString(),
                      headerDate: orderList[index].orderDate.toString(),
                      bodyHeader: orderList[index].demandName.toString(),
                      paymentType: orderList[index].paymentType.toString(),
                      demandNo: orderList[index].demandNo.toString(),
                      deliveryDate: orderList[index].deliveryDate.toString(),
                      paymentDueDate: orderList[index].paymentDueDate.toString(), 
                      bodyList: orderList[index].products,
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
