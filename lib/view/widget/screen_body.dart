import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/view/widget/small_card.dart';


import '../../model/get_order_list_model.dart';
import 'main_page_content.dart';

class BodyWidget extends StatelessWidget {
  final List<GetOrderlistModel> orderList;
  final String topic;

  const BodyWidget({Key? key, required this.orderList, required this.topic}) : super(key: key);

  int getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 1250) {
      return 3;
    } else if (constraints.maxWidth > 600) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  topic: FlutterI18n.translate(context, "tr.order.orders"),
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
                      demandNo: orderList[index].demandNo.toString(),
                      demandName: orderList[index].demandName.toString(),
                      orderDate: orderList[index].orderDate.toString(),
                      deliveryDate: orderList[index].deliveryDate.toString(),
                      paymentDueDate: orderList[index].paymentDueDate.toString(),
                      orderStatus: orderList[index].state.toString(),
                      paymentType: orderList[index].paymentType.toString(),
                      products: orderList[index].products, 
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
}
