import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/view/widget/big_card%20/info/info.dart';
import 'package:seller_point/view/widget/big_card%20/info/info_box.dart';

import '../../model/shipment_model.dart';
import '../../view_model/shipment_view_model.dart';
import '../widget/appbar.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/nav_drawer.dart';
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
            if (constraints.maxWidth <= 1100) {
              return Scaffold(
                appBar: AppbarTop(), //appbar
                body: Row(
                  children: [
                    const NavigationRailWidget(),
                    Expanded(child: buildBody(shipmentList, context, FlutterI18n.translate(context, "tr.shipment.shipments"), "shipment")),
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
                      bodyHeader: shipmentList[index].waybillNo.toString(),
                      infoWidget: Info(
                        className: className, 
                        demandName: "Acil Siparis", //demand_name is missing in shipment model
                        infoRow1: shipmentList[index].shipmentId.toString(), //order date is missing
                        infoRow2: shipmentList[index].shipmentDate.toString(), // teslim tarihi is missing in shipment model
                        infoRow3: 'Cari Hesap', //paymenttype is missing
                        infoRow4: '30', //payment due date is missing
                        infoRow5: '10233', //proposal id is missing
                        infoRow6: 'Satici', //nakliye odeme is missing
                      ),
                      infoBoxWidget: InfoBox(
                        className: className,
                        row1: shipmentList[index].carrier.toString(),
                        row2: shipmentList[index].trackingNo.toString(),
                        row3: 'Merkez', //address is missing
                      ),
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
    if (constraints.maxWidth > 900) {
      return 3;
    } else if (constraints.maxWidth > 550) {
      return 2;
    } else {
      return 1;
    }
  }

  
}