import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatefulWidget {
  final String paragraphs;
  


  const PageIndicator({
     Key? key,
     required this.paragraphs,
  }) : super(key: key);

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {

  var controller;  
  @override
  void initState() {
      controller =  PageController(
      viewportFraction:0.8,
    );
    super.initState();
}


  @override
  Widget build(BuildContext context) {
    List<String>  text = widget.paragraphs.split("\n");
    text.removeWhere((element) => element.isEmpty);
    final list = text.asMap();

    debugPrint('paragraphs: ${list}');
    // final container = List.generate(
    // list.length,
    // (index) => Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(16),
    //       ),
    //       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    //       child: Container(
    //         height: 280,
    //         child: Center(
    //           child: Text(
    //             "${list[index]}",
    //             style: TextStyle(color: Colors.white),
    //         )),
    //       ),
    //     ));


    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: controller,
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            // shrinkWrap: true,
            children: [
              for (int i = 0; list.length > i ; i++ )
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Container(
                    height: 280,
                    child: Center(
                      child: Text(
                        "${list[i]}",
                        style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
            ],
   
          ),
        ),
        SizedBox(height: 16.0),
        SmoothPageIndicator(
          controller: controller,
          // curve: Curves.easeInOut,
          // duration: const Duration(milliseconds: 600),
          count: list.length,
          axisDirection: Axis.horizontal,
          effect: WormEffect(
            activeDotColor: Colors.blue,
            dotColor: Colors.grey,
            dotHeight: 8,
            dotWidth: 8,
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
  