import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/invoice_view/invoice_view.dart';
import 'package:seller_point/view/order_view/order_view.dart';
import 'package:seller_point/view/proposal_view/proposal_view.dart';
import 'package:seller_point/view/shipment_view/shipment_view.dart';
import 'package:seller_point/view/widget/appbar.dart';
import 'package:seller_point/view/widget/nav_drawer.dart';
import 'package:seller_point/view/widget/nav_rail.dart';
import 'package:seller_point/view_model/order_list_view_model.dart';
import 'package:seller_point/view_model/proposal_view_model.dart';
import '../view_model/buyer_invoices_view_model.dart';
import '../view_model/shipment_view_model.dart';
//test
class Index extends ConsumerStatefulWidget {
  const Index({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IndexState();
}

class _IndexState extends ConsumerState<Index> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  bool showNavigationDrawer = true;

  void onItemTap(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
      getProviders(viewProviders(selectedScreen));
    });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  AutoDisposeFutureProvider viewProviders(int index) {
    switch (index) {
      case 0:
        return getProposalListProvider;
      case 1:
        return getOrderListProvider;
      case 2:
        return shipmentProvider;
      case 3:
        return getInvoicesProvider;
      default:
        return getProposalListProvider;
    }
  }

  dynamic getProviders(AutoDisposeFutureProvider provider) async {
    ref.invalidate(provider);
    ref.read(provider.future);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= 1100) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: const AppbarTop(),
            body: Row(
              children: [
                NavigationRailWidget(
                  onItemTap: onItemTap,
                  screenIndex: screenIndex,
                ),
                Expanded(
                  child: IndexedStack(
                    index: screenIndex,
                    children: const  [
                      ProposalView(),
                      OrderView(),
                      ShipmentView(),
                      InvoiceView(),
                    ]
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            key: _scaffoldKey,
            appBar: const AppbarTop(), // appbar
            body: SafeArea(
              child: Row(
                children:  [
                   Expanded(
                    flex: 3,
                    child: NavigationRailDrawer(
                      onItemTap: onItemTap,
                      screenIndex: screenIndex,
                    ), //drawer
                  ),
                  Expanded(
                    flex: 10,
                    child: IndexedStack(
                      index: screenIndex,
                      children: const  [
                        ProposalView(),
                        OrderView(),
                        ShipmentView(),
                        InvoiceView(),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}