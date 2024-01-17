import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

Future<void> openFile() async {
  var bytes = await rootBundle.load("assets/privacy_policy.pdf");

  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.window.open(url, "_blank");
  html.Url.revokeObjectUrl(url);
}

class Contact extends ConsumerWidget {
  final int sectionIndex;
  final String ?address;
  final String ?contactInfo;
  final String ?footer;
  const Contact({
    Key? key, 
    required this.sectionIndex,
    this.address,
    this.contactInfo,
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
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(flex: 1),
          Text(
            contactInfo ?? " ",
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 1),
          Text(
            address ?? " ",
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 1),
          TextButton(
            onPressed: openFile,
            child: Text(
              FlutterI18n.translate(context, "tr.login.privacy_policy"),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          ),
          const Spacer(flex: 1),
          Text(
            footer ?? " ",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(flex: 1)
        ],
      ),
    );
  }
}