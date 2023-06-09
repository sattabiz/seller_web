import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Contact extends ConsumerWidget {
  final int sectionIndex;
  const Contact({Key? key, required this.sectionIndex})
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
            "İletişim",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const Spacer(flex: 1),
          AutoSizeText(
            "Yeni Mahalle İncirlik Bulvarı C Blok No:17/ C20 Sarıçam /ADANA-TURKİYE",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
          ),
          AutoSizeText(
            "hasansilah@glopal.com.tr - halukcig@glopal.com.t",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
          ),
          AutoSizeText(
            "+90 533 327 73 73 / +90 533 405 30 59",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
          ),
          const Spacer(flex: 3),
          AutoSizeText(
            "@2023 Glopal Palet Company",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(flex: 1)

        ],
      ),
    );
  }
}