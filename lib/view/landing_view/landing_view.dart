import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../view_model/landing_view_model.dart';
import '/view/landing_view/components/introduction.dart';
import '/view/landing_view/components/app_bar_landing_page.dart';
import '/view/landing_view/components/products.dart';
import '/view/landing_view/components/contact.dart';

class LandingView extends ConsumerWidget {
  final int ?sectionIndex;

  LandingView({
    Key? key,
    this.sectionIndex,
  }) : super(key: key);

  final AutoScrollController _scrollController = AutoScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color surfaceContainer = Color(0xFFECEEEB);
    final landingProvider = ref.watch(getLandingViewContentProvider);
    return landingProvider.when(
      data: (contentList) {
      debugPrint("products length: ${contentList.bgImage}");
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
                  child: Introduction(
                    sectionIndex: 0,
                    title: contentList.title ?? " ",
                    introduction: contentList.introduction,
                    bgImage: contentList.bgImage)
                ),
                AutoScrollTag(
                  key: const ValueKey(1),
                  controller: _scrollController,
                  index: 1,
                  child: Column(
                    children: [
                      for (int i = 0; i < contentList.products!.length; i++)                      
                        Products(
                          sectionIndex: 1,
                          productDetails: contentList.products![i].productDetails,
                          productImage: contentList.products![i].productImage,
                        ),
                    ],
                  ),
                ),
                AutoScrollTag(
                  key: const ValueKey(2),
                  controller: _scrollController,
                  index: 2,
                  child:  Contact(
                    sectionIndex: 2,
                    address: contentList.address,
                    footer: contentList.footer,
                  ),
                ),
              ],        
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
    );
  }

  

}
