import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';


class Header extends ConsumerWidget {
  final String id;
  final String statusMap;
  final String svgPath;

  const Header({
    Key? key,
    required this.id,
    required this.statusMap,
    required this.svgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const surfaceDim = Color(0xFFD8DBD8);
    return Container(
      // padding: EdgeInsets.all(10.0),
      constraints: BoxConstraints.tightFor(height: 80.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
        ),
        color: surfaceDim,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: ListTile(
              title: Text(statusMap,
              style: Theme.of(context).textTheme.titleLarge),
              subtitle: AutoSizeText("${FlutterI18n.translate(context, "tr.order.order_no")}:  $id", style: Theme.of(context).textTheme.titleMedium),
              leading: SvgPicture.asset(
                svgPath,
                semanticsLabel: 'Order Status Icon',
                width: 30.0,
                height: 30.0,
              ),
            ),
          ),
          Flexible(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context); // close the big card
                },
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
          ),
        ],
      ),
    );
  }
}