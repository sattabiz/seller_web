import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class PageIndicator extends StatelessWidget {
  final String paragraphs;

  PageIndicator({
    Key? key,
    required this.paragraphs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AutoSizeText(
            paragraphs,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

// not animated, just scrollable text with smooth page indicator package.

// Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: 240,
//           child: PageView(
//             controller: controller,
//             scrollDirection: Axis.vertical,
//             children: [
//               for (int i = 0; list.length > i ; i++ )
//                 Center(
//                   child: AutoSizeText(
//                     "${list[i]}",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         // SizedBox(height: 16.0),
//         Flexible(
//           child: SmoothPageIndicator(
//             controller: controller,
//             count: list.length,
//             effect: WormEffect(
//               dotColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
//               activeDotColor: Theme.of(context).colorScheme.primary,
//               type: WormType.thin,
//             ),
//           ),
//         ),
//       ],
//     );