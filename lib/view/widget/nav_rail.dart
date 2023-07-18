import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../view_model/buyer_invoices_view_model.dart';
import '../../view_model/order_list_view_model.dart';
import '../../view_model/proposal_view_model.dart';
import '../../view_model/provider_controller.dart';
import '../../view_model/shipment_view_model.dart';
import '../create_proposal_view/create_proposal_view.dart';
import '../favorite_list_view/navigation_rail_favorite.dart';
import '../favorite_list_view/navigation_rail_favorite_content.dart';
import 'nav_drawer_header_button.dart';

class NavigationRailWidget extends ConsumerStatefulWidget {
  const NavigationRailWidget({Key? key}) : super(key: key);

  @override
  _NavigationRailWidgetState createState() => _NavigationRailWidgetState();
}

class _NavigationRailWidgetState extends ConsumerState<NavigationRailWidget> {
  int currentIndex = 0;
  final _routes = [
    '/proposalScreen',
    '/orderScreen',
    '/shipmentScreen',
    '/invoiceScreen'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeName = ModalRoute.of(context)!.settings.name;
    if (routeName == '/proposalScreen') {
      currentIndex = 0;
    } else if (routeName == '/orderScreen') {
      currentIndex = 1;
    } else if (routeName == '/shipmentScreen') {
      currentIndex = 2;
    } else if (routeName == '/invoiceScreen') {
      currentIndex = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      backgroundColor: Colors.transparent,
      selectedIndex: currentIndex,
      groupAlignment: 0,
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: (int index) {
        setState(() {
          currentIndex = index;
          if(index == 0){
            ref.refresh(proposalListview);
            ref.read(proposalListview.future);
          }else if(index == 1){
            ref.refresh(getOrderListProvider);
            ref.read(getOrderListProvider.future);
          }else if(index == 2){
            ref.refresh(shipmentProvider);
            ref.read(shipmentProvider.future);
          }else if(index == 3){
            ref.refresh(getInvoicesProvider);
            ref.read(getInvoicesProvider.future);
          }
          currentIndex = index;
        });
        Navigator.pushNamed(context, _routes[index]);
      },
      leading: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          final RenderBox button = context.findRenderObject() as RenderBox;
          final RenderBox overlay =
              Overlay.of(context).context.findRenderObject() as RenderBox;
          final RelativeRect position = RelativeRect.fromRect(
            Rect.fromPoints(
              button.localToGlobal(
                  Offset(button.size.width-10, 60),
                  ancestor: overlay),
              button.localToGlobal(
                  button.size.bottomRight(Offset.zero) + Offset(-10, 60),
                  ancestor: overlay),
            ),
            Offset.zero & overlay.size,
          );

          showMenu(
              context: context,
              position: position,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              items: <PopupMenuEntry<SampleItem>>[
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemOne,
                  child: Text('Yeni Teklif İsteği Oluştur'),
                ),
                const PopupMenuItem<SampleItem>(
                  value: SampleItem.itemTwo,
                  child: Text('Listelerimden Teklif Oluştur'),
                ),
              ]).then((SampleItem? item) {
            if (item == null) return;
            switch (item) {
              case SampleItem.itemOne:
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const createProposalView();
                    });
                break;
              case SampleItem.itemTwo:
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: EdgeInsets.zero,
                        title: const navigationRailFavorite(),
                        content: navigationRailFavoriteContent(),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Tamam'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
                break;
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      destinations: [
        NavigationRailDestination(
            icon: SvgPicture.asset('assets/proposal.svg'),
            selectedIcon: SvgPicture.asset('assets/proposal.svg'),
            label: const Text('Teklif İstekleri'),
            padding: const EdgeInsets.only(bottom: 15)),
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/order.svg'),
          selectedIcon: SvgPicture.asset('assets/order.svg'),
          label: const Text('Siparişler'),

        ),
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/order.svg'),
          selectedIcon: SvgPicture.asset('assets/order.svg'),
          label: const Text('Sevkiyat'),
        ),
        NavigationRailDestination(
          icon: SvgPicture.asset('assets/invoice.svg'),
          selectedIcon: SvgPicture.asset('assets/invoice.svg'),
          label: const Text('Faturalar'),
        ),
      ],
    );
  }
}
