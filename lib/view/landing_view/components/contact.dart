import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Contact extends ConsumerWidget {
  final int sectionIndex;
  final String ?address;
  final String ?footer;
  const Contact({
    Key? key, 
    required this.sectionIndex,
    this.address,
    this.footer, 
  })
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            FlutterI18n.translate(context, "tr.login.contact"),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const Spacer(flex: 1),
          AutoSizeText(
            address ?? " ",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 3),
          AutoSizeText(
            footer ?? " ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(flex: 1)

        ],
      ),
    );
  }
}