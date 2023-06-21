import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/shipment_model.dart';
import '../../view_model/shipment_view_model.dart';
import '../widget/appbar.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/nav_rail.dart';
import '../widget/small_card/small_card_shipment.dart';
class ShipmentView extends ConsumerWidget {
 const ShipmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentListAsyncValue = ref.watch(shipmentProvider);
    return shipmentListAsyncValue.when(
      data: (shipmentList) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 1070) {
              return Scaffold(
                drawer: const Drawer(child: NavigationRailDrawer()),
                appBar: AppbarTop(), //appbar
                body: buildBody(shipmentList, context, FlutterI18n.translate(context, "tr.shipment.shipments"), "shipment"),
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
                        flex: 9,
                        child: buildBody(shipmentList, context, FlutterI18n.translate(context, "tr.shipment.shipments"), "shipment"),
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

  Padding buildBody(List<Shipment> shipmentList, BuildContext context, String topic, String className) {
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
                  itemCount: shipmentList.length,
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    return SmallCardShipment(
                      index: index,
                      id: shipmentList[index].shipmentId.toString(),
                      className: className,
                      status: shipmentList[index].state.toString(),
                      headerDate: shipmentList[index].shipmentDate.toString(),
                      bodyHeader: shipmentList[index].waybillNo.toString(), //fatura_no
                      // paymentType: shipmentList[index].paymentType.toString(), //shipment'da yok
                      // demandNo: shipmentList[index].demandNo.toString(),
                      // deliveryDate: shipmentList[index].deliveryDate.toString(),
                      // paymentDueDate: shipmentList[index].paymentDueDate.toString(), 
                      bodyList: shipmentList[index].products,
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
    if (constraints.maxWidth > 1250) {
      return 3;
    } else if (constraints.maxWidth > 600) {
      return 2;
    } else {
      return 1;
    }
  }

  
}