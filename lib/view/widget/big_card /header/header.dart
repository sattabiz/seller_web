import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/widget_helper.dart';

class Header extends ConsumerWidget {
  final String id;
  final String className;
  final String status;

  const Header({
    Key? key,
    required this.id,
    required this.className,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints.tightFor(height: 95.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 15, left: 30, bottom: 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  statusIconMap[status] ?? '',
                  width: 30.0,
                  height: 30.0,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    FlutterI18n.translate(context, "tr.$className.$status"),
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ),
                SizedBox(
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        opticalSize: 36,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 35.0,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // headerId
                Text(
                  bigCardHeader(status, className),
                  style:
                      Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  id,
                  style: Theme.of(context).textTheme.labelLarge,
                  maxLines: 1,
                ),
                const Spacer(flex: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

            // Expanded(
            //   flex: 9,
            //   child: ListTile(
            //     title: Text(statusMap,
            //     style: Theme.of(context).textTheme.titleLarge),
            //     subtitle: Text("${FlutterI18n.translate(context, "tr.$className.big_card_header")}  $id", style: Theme.of(context).textTheme.titleMedium),
            //     leading: SvgPicture.asset(
            //       svgPath,
            //       width: 30.0,
            //       height: 30.0,
            //     ),
            //   ),
            // ),