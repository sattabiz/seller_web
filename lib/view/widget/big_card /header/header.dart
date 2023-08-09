import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';


class Header extends ConsumerWidget {
  final String id;
  final String statusMap;
  final String svgPath;
  final String className;

  const Header({
    Key? key,
    required this.id,
    required this.statusMap,
    required this.svgPath,
    required this.className,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints.tightFor(height: 80.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32.0),
        topRight: Radius.circular(32.0),
        ),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: ListTile(
                title: Text(statusMap,
                style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text("${FlutterI18n.translate(context, "tr.$className.big_card_header")}  $id", style: Theme.of(context).textTheme.titleMedium),
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
                  padding: const EdgeInsets.only(top: 0.0, right: 40.0, bottom: 0.0, left: 0.0),
                  iconSize: 36.0,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    // opticalSize: 36,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}