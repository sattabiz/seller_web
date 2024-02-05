import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/main_page_content.dart';

class DevelopmentProcessView extends ConsumerWidget {
  String text;
  String topic;
  DevelopmentProcessView({
    Key? key,
    required this.text,
    required this.topic
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            child: allMainPageContent(topic: topic),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: AutoSizeText(
                      text,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
