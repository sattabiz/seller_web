import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../view_model/buyer_invoices_view_model.dart';
import '../../view_model/order_list_view_model.dart';
import '../../view_model/proposal_view_model.dart';
import '../../view_model/provider_controller.dart';
import '../../view_model/shipment_view_model.dart';
import 'nav_drawer_header_button.dart';

class NavigationRailDrawer extends ConsumerWidget {
  const NavigationRailDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.01),
        child: ListView(
          padding: EdgeInsets.all(screenWidth * 0.005),
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Flexible(child: DrawerHeaderButton()),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('İşlemler',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(
              height: 24,
            ),
            drawerButton(context, 'Teklif İstekleri', 'assets/proposal.svg',
                '/proposalScreen', 0, ref, proposalListview),
            const SizedBox(
              height: 16,
            ),
            drawerButton(context, 'Siparişler', 'assets/order.svg',
                '/orderScreen', 1, ref, getOrderListProvider),
            const SizedBox(
              height: 16,
            ),
            drawerButton(context, 'Sevkiyat', 'assets/order.svg',
                '/shipmentScreen', 2, ref, shipmentProvider),
            const SizedBox(
              height: 16,
            ),
            drawerButton(context, 'Faturalar', 'assets/invoice.svg',
                '/invoiceScreen', 3, ref, getInvoicesProvider),
          ],
        ),
      ),
    );
  }

  drawerButton(
    BuildContext context,
    String text,
    String icon,
    String route,
    int index,
    WidgetRef ref,
    AutoDisposeFutureProvider<List<dynamic>> provider,
  ) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () async {
        ref.refresh(provider);
        ref.read(provider.future);
        ref.read(drawerCountProvider.notifier).state = index;
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: ref.watch(drawerCountProvider) == index
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
        ),
        width: screenWidth * 0.98,
        height: MediaQuery.of(context).size.width > 650
            ? screenHeight * 0.09
            : screenHeight * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(
              flex: 1,
            ),
            Flexible(
              child: SvgPicture.asset(
                icon,
                semanticsLabel: 'Order Status Icon',
                width: 30.0,
                height: 30.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 9,
              child: AutoSizeText(
                text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ),
            Flexible(
              child: AutoSizeText(
                '24',
                maxLines: 1,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}





















/* class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon, this.routeName);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final String routeName; 
}


const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
      'page 0', Icon(Icons.widgets_outlined), Icon(Icons.widgets), '/login'),
  ExampleDestination(
      'page 1', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint), '/orderScreen'),
];


class NavigationDrawerExample extends StatefulWidget {
  const NavigationDrawerExample({super.key});

  @override
  State<NavigationDrawerExample> createState() =>
      _NavigationDrawerExampleState();
}

class _NavigationDrawerExampleState extends State<NavigationDrawerExample> {
  int screenIndex = 0;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
    Navigator.pushNamed(context, destinations[selectedScreen].routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NavigationRail(
          minWidth: 50,
          destinations: destinations.map(
            (ExampleDestination destination) {
              return NavigationRailDestination(
                label: Text(destination.label),
                icon: destination.icon,
                selectedIcon: destination.selectedIcon,
              );
            },
          ).toList(),
          selectedIndex: screenIndex,
          useIndicator: true,
          onDestinationSelected: (int index) {
            setState(() {
              screenIndex = index;
            });
          },
        ),
        const VerticalDivider(thickness: 1, width: 1),
      ],
    );
  }
}

 */




















/* import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {

    return Material(
      color: Theme.of(context).navigationRailTheme.backgroundColor,
      child: ListView(
        children: <Widget>[Container(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70,),
                Text('İşlemler',style: TextStyle(fontSize: 24,color: Colors.black54),),
                const SizedBox(height: 24),
                buildMenuItem(
                  text: 'Teklif istekleri      34',
                  icon: Icons.people,
                  onClicked: () => selectedItem(context, 0),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Siparisler          23',
                  icon: Icons.favorite_border,
                  onClicked: () => selectedItem(context, 1),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Workflow',
                  icon: Icons.workspaces_outline,
                  onClicked: () => selectedItem(context, 2),
                ),
                const SizedBox(height: 16),
                buildMenuItem(
                  text: 'Updates',
                  icon: Icons.update,
                  onClicked: () => selectedItem(context, 3),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    /* switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrderScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavouritesPage(),
        ));
        break;
    } */
  }
} */