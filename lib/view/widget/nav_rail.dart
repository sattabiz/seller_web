import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../create_proposal_view/create_proposal_view.dart';
import '../favorite_list_view/navigation_rail_favorite.dart';
import '../favorite_list_view/navigation_rail_favorite_content.dart';
import 'nav_drawer_header_button.dart';

class NavigationRailWidget extends ConsumerStatefulWidget {
  final void Function(int index) onItemTap;
  final int screenIndex;
  const NavigationRailWidget(
    {Key? key,
    required this.onItemTap,
    required this.screenIndex,
    }) : super(key: key);

  @override
 ConsumerState<ConsumerStatefulWidget> createState() => _NavigationRailWidgetState();
}

class _NavigationRailWidgetState extends ConsumerState<NavigationRailWidget> {


  @override
  Widget build(BuildContext context) {
    // final newValue = ref.refresh(provider);

    return NavigationRail(
      backgroundColor: Colors.transparent,
      selectedIndex: widget.screenIndex,
      groupAlignment: 0,
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: widget.onItemTap,
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
