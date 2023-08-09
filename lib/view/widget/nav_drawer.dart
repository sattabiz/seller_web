import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'nav_drawer_header_button.dart';

class Destination {
  const Destination(this.label, this.svgPath);
  final String label;
  final String svgPath;
}

 List<Destination> destinations = const <Destination>[
  Destination('Teklifler', 'assets/proposal.svg'),
  Destination('Siparisler', 'assets/order.svg'),
  Destination('Sevkiyatlar', 'assets/shipment.svg'),
  Destination('Faturalar', 'assets/invoice.svg'),
];

class NavigationRailDrawer extends ConsumerStatefulWidget {
  final void Function(int index) onItemTap;
  final int screenIndex;

  const NavigationRailDrawer({
    super.key,
    required this.onItemTap,
    required this.screenIndex,
    });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationRailDrawerState();
}

class _NavigationRailDrawerState extends ConsumerState<NavigationRailDrawer> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return NavigationDrawer(
      onDestinationSelected: widget.onItemTap,
      selectedIndex: widget.screenIndex,
      children: [
        DrawerHeader(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Flexible(child: DrawerHeaderButton()),
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            'İşlemler',
            style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(
          height: 24,
        ),
        NavigationDrawerDestination(
          icon: SvgPicture.asset(
            'assets/proposal.svg',
            width: 20.0,
            height: 20.0,
          ),
          label: Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 170,
                child: Text(
                  FlutterI18n.translate(context, 'tr.proposal.proposals'),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Text(
                '24',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        NavigationDrawerDestination(
          icon: SvgPicture.asset(
            'assets/order.svg',
            width: 20.0,
            height: 20.0,
          ),
          label: Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 170,
                child: Text(
                  FlutterI18n.translate(context, 'tr.order.orders'),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Text(
                '24',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        NavigationDrawerDestination(
          icon: SvgPicture.asset(
            'assets/shipment.svg',
            width: 20.0,
            height: 20.0,
          ),
          label: Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 170,
                child: Text(
                  FlutterI18n.translate(context, 'tr.shipment.shipments'),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Text(
                '24',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        NavigationDrawerDestination(
          icon: SvgPicture.asset(
            'assets/invoice.svg',
            width: 20.0,
            height: 20.0,
          ),
          label: Row(
            children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 170,
                child: Text(
                  FlutterI18n.translate(context, 'tr.invoice.invoices'),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Text(
                '24',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}