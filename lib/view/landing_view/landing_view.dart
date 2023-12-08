import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../view_model/landing_view_model.dart';
import '/view/landing_view/components/introduction.dart';
import '/view/landing_view/components/app_bar_landing_page.dart';
import '/view/landing_view/components/products.dart';
import '/view/landing_view/components/contact.dart';
import '/view/landing_view/components/products_small.dart';

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
        contentList.products!.sort((a, b) => a.categoryId.compareTo(b.categoryId));
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
                  child:
                   Introduction(
                    sectionIndex: 0,
                    title: contentList.title ?? " ",
                    introduction: contentList.introduction,
                    bgImage: contentList.bgImage,
                    )
                ),
                AutoScrollTag(
                  key: const ValueKey(1),
                  controller: _scrollController,
                  index: 1,
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      if (constraints.maxWidth > 800) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0; contentList.products!.length > i ; i++ )                      
                              Products(
                                sectionIndex: 1,
                                title: contentList.products![i].title ?? " ",
                                productDetails: contentList.products![i].productDetails,
                                productImage: contentList.products![i].productImage,
                              ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int i = 0; contentList.products!.length > i ; i++ )                      
                              ProductsSmall(
                                sectionIndex: 1,
                                title: contentList.products![i].title ?? " ",
                                productDetails: contentList.products![i].productDetails,
                                productImage: contentList.products![i].productImage,
                              ),
                          ],
                        );
                      }
                    }
                ),
                ),
                AutoScrollTag(
                  key: const ValueKey(2),
                  controller: _scrollController,
                  index: 2,
                  child:  Contact(
                    sectionIndex: 2,
                    address: contentList.address,
                    contactInfo: contentList.contactInfo,
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
