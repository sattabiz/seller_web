import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  final String paragraphs;
  
  PageIndicator({
     Key? key,
     required this.paragraphs,
  }) : super(key: key);

  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    List<String>  text = paragraphs.split('\n');
    final list = text.asMap();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 250,
          child: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: [
              for (int i = 0; list.length > i ; i++ )
                Center(
                  child: AutoSizeText(
                    "${list[i]}",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        // SizedBox(height: 16.0),
        Flexible(
          child: SmoothPageIndicator(
            controller: controller,
            count: list.length,
            effect: WormEffect(
              dotColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              activeDotColor: Theme.of(context).colorScheme.primary,
              type: WormType.thin,
            ),
          ),
        ),
      ],
    );
  }
}

// Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     SizedBox(
    //       height: 240,
    //       child: PageView.builder(
    //         controller: _pageController,
    //         itemCount: container.length,
    //         // allowImplicitScrolling: true,
    //         itemBuilder: (BuildContext context, index) {
    //           return container[index % container.length];
    //         },
    //         onPageChanged: (int index) {
    //           setState(() {
    //             _currentPage = index;
    //           });
    //         },
    //       ),
    //     ),
    //     // Padding(
    //     //   padding: const EdgeInsets.only(top: 24, bottom: 12),
    //     //   child: Text(
    //     //     'Worm',
    //     //     style: TextStyle(color: Colors.black54),
    //     //   ),
    //     // ),
    //     SmoothPageIndicator(
    //       controller: _pageController,
    //       count: container.length,
    //       effect: const SlideEffect(  
    //         spacing:  8.0,  
    //         radius:  4.0,  
    //         dotWidth:  24.0,  
    //         dotHeight:  16.0,  
    //         paintStyle:  PaintingStyle.stroke,  
    //         strokeWidth:  1.5,  
    //         dotColor:  Colors.grey,  
    //         activeDotColor:  Colors.indigo  
    //       ),  
    //       onDotClicked: (index) {
    //         list[index];
    //         print(list[index]);
    //       },
    //     ),
    //   ],
      
    // );
  