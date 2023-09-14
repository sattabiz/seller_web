import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/view/widget/big_card%20/big_card.dart';
import 'package:seller_point/view/widget/big_card%20/header/header.dart';
import 'package:seller_point/view/widget/big_card%20/info/info.dart';
import 'package:seller_point/view/widget/big_card%20/info/info_box.dart';
import 'package:seller_point/view/widget/big_card%20/table/shipment_table.dart';
import 'package:seller_point/view/widget/small_card/body/small_card_shipment_table.dart';
import 'package:seller_point/view/widget/small_card/body/small_card_table.dart';
import 'package:seller_point/view/widget/small_card/header/header_invoice.dart';
import '../../utils/widget_helper.dart';
import '../../view_model/provider_controller.dart';
import '../../view_model/shipment_delivered_view_model.dart';
import '../../view_model/shipment_view_model.dart';
import '../widget/big_card /buttons/button_widget.dart';
import '../widget/big_card /info/info_shipment.dart';
import '../widget/big_card /info/proposal_sum_panel.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/small_card/body/body_header.dart';
import '../widget/small_card/header/header_shipment.dart';
import '../widget/small_card/small_card.dart';


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
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        return SmallCard(
                          id: shipmentList[index].shipmentId.toString(),
                          className: className,
                          status: shipmentList[index].state.toString(),
                          headerSmallCard: 
                          checkShipmentState(shipmentList[index].state.toString())
                          ? HeaderInvoice(
                            status: shipmentList[index].state.toString(),
                            headerDate: formattedDate(shipmentList[index].deliveryDate.toString()), 
                            className: className)
                          : HeaderShipment(
                            id: getOrderIdFromShipmentProductList(shipmentList[index].products), 
                            status: shipmentList[index].state.toString(),
                            headerDate: formattedDate(shipmentList[index].shipmentDate.toString()), 
                            newMessageSvg: newMessageSvg,
                          ),
                          bodyHeader:
                           BodyHeader( 
                            bodyHeader: shipmentList[index].waybillNo.toString(),
                          ),
                          smallCardTable: smallCardShipmentTable(
                            shipmentList[index].state.toString(),
                            SmallCardShipmentTable(
                              id: shipmentList[index].shipmentId.toString(), 
                              status: shipmentList[index].state.toString(), 
                              className: className, 
                              bodyList: shipmentList[index].products,
                            ),
                            SmallCardTable(
                              id: shipmentList[index].shipmentId.toString(), 
                              status: shipmentList[index].state.toString(), 
                              className: className, 
                              bodyList: shipmentList[index].products,
                            )
                          ),
                          bigCard: BigCard(
                            id: shipmentList[index].shipmentId.toString(),
                            bigCardHeader: Header(
                              className: className,
                              status: shipmentList[index].state.toString(),
                              id: checkShipmentState(shipmentList[index].state.toString())
                              ? formattedDate(shipmentList[index].deliveryDate.toString())
                              : getOrderIdFromShipmentProductList(shipmentList[index].products),
                            ), 
                            bigCardTable: ShipmentTable(
                              shipmentProductList: shipmentList[index].products, 
                              className: className
                            ),
                            tableInfoPanel: TableInfoPanel(
                              row1: costCalcForShipment(shipmentList[index].products, "raw_cost"),
                              row2: costCalcForShipment(shipmentList[index].products, "tax_amount"),
                              row3: costCalcForShipment(shipmentList[index].products, "total_cost"),
                            ),
                            buttons: ButtonWidget(
                              className: className,
                              status: shipmentList[index].state.toString(),
                              onPressed: () async {
                                await ref.watch(shipmentDeliveredProvider);
                                ref.read(drawerCountProvider.notifier).state = 1;
                                Navigator.pop(context);
                              },
                            ),
                            infoWidget: 
                            checkShipmentState(shipmentList[index].state.toString())
                            ? InfoShipment(
                              className: className, 
                              invoiceNo: shipmentList[index].waybillNo.toString(), //invoiceNo eklenecek
                              infoRow1: formattedDate(shipmentList[index].shipmentDate.toString()), //invoice date eklenecek
                              infoRow2: shipmentList[index].waybillNo.toString(),
                              infoRow3: checkPaymentType(shipmentList[index].paymentType.toString()),
                              infoRow4: shipmentList[index].paymentDueDate.toString(), 
                              infoRow5: getOrderIdFromShipmentProductList(shipmentList[index].products), 
                              infoRow6: checkTraking(shipmentList[index].includeShipmentCost!),
                            )
                            : Info(
                              className: className, 
                              demandName: shipmentList[index].demandListName.toString(),
                              infoRow1: formattedDate(shipmentList[index].orderDate.toString()),
                              infoRow2: formattedDate(shipmentList[index].deliveryDate.toString()),
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