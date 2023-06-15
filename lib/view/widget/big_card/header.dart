import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Header extends ConsumerWidget {
  final String id;
  final String status;

  const Header({
    Key? key,
    required this.id,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ListTile(
              title: Text(status,
              style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text("Siparis No: $id", style: Theme.of(context).textTheme.titleMedium),
              leading: Icon(
                Icons.fire_truck,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(top: 0.0, right: 8.0, bottom: 0.0, left: 8.0),
              iconSize: 36.0,
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                // opticalSize: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}