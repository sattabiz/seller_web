import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/view/widget/big_card%20/header/header.dart';
import 'package:seller_point/view/widget/big_card%20/info/info.dart';
import 'package:seller_point/view/widget/big_card%20/info/info_box.dart';
import '../../model/shipment_model.dart';
import '../../utils/widget_helper.dart';
import '../../view_model/shipment_view_model.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/small_card/small_card_shipment.dart';
class ShipmentView extends ConsumerWidget {
 const ShipmentView({Key? key}) : super(key: key);
  final String className = 'shipment';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shipmentListAsyncValue = ref.watch(shipmentProvider);
    return shipmentListAsyncValue.when(
      data: (shipmentList) {
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
                      topic: FlutterI18n.translate(context, 'tr.shipment.shipments')
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
                          bigCardHeader: Header(
                            className: className,
                            status: shipmentList[index].state.toString(),
                            id: shipmentList[index].state.toString() == 'order_on_the_way'
                            ? shipmentList[index].shipmentDate.toString()
                            : shipmentList[index].shipmentId.toString(), //order_id eklenecek
                          ),
                          infoWidget: Info(
                            className: className, 
                            demandName: shipmentList[index].demandListName.toString(),
                            infoRow1: shipmentList[index].shipmentId.toString(), //order date is missing
                            infoRow2: shipmentList[index].shipmentDate.toString(), // teslim tarihi is missing in shipment model
                            infoRow3: checkPaymentType(shipmentList[index].paymentType.toString()),
                            infoRow4: shipmentList[index].paymentDueDate.toString(), 
                            infoRow5: shipmentList[index].proposalId.toString(), 
                            infoRow6: checkTraking(shipmentList[index].includeShipmentCost!),
                          ),
                          infoBoxWidget: InfoBox(
                            className: className,
                            row1: shipmentList[index].carrier.toString(),
                            row2: shipmentList[index].trackingNo.toString(),
                            row3: shipmentList[index].address.toString(),
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