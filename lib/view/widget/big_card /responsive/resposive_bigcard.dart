import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsiveBigCard extends StatelessWidget {

final Widget bigCardDesktop;
final Widget bigCardMobile;
static bool isMobile = false;

  ResponsiveBigCard({required this.bigCardDesktop, required this.bigCardMobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        if(constraints.maxWidth >= 810){
          return bigCardDesktop;
        }
        else{
          isMobile = true;
          return bigCardMobile;
        }
      },
    );
  }
}