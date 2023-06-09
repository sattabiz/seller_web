import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '/view/landing_view/components/introduction.dart';
import '/view/landing_view/components/app_bar_landing_page.dart';
import '/view/landing_view/components/products.dart';
import '/view/landing_view/components/contact.dart';

class LandingView extends ConsumerWidget {
  LandingView({Key? key}) : super(key: key);

  final AutoScrollController _scrollController = AutoScrollController();

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // const Color surfaceContainer = Color(0xFFECEEEB);
    return Scaffold(
      appBar: AppbarLandingPage(scrollController: _scrollController,),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoScrollTag(
              key: ValueKey(0),
              controller: _scrollController,
              index: 0,
              child: Introduction(sectionIndex: 0)),
            AutoScrollTag(
              key: ValueKey(1),
              controller: _scrollController,
              index: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 40.0, bottom: 40.0),
                height: 400,
                // color: surfaceContainer,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Products(sectionIndex: 1)),
            ),
            AutoScrollTag(
              key: ValueKey(2),
              controller: _scrollController,
              index: 2,
              child: Contact(sectionIndex: 2),
            ),
          ],        
        ),
      ),
    );
  }

  

}
