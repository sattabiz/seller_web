import 'package:flutter/material.dart';

import 'component/login_card.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth =
        MediaQuery.of(context).size.width; //for screen widht
    double screenHeight =
        MediaQuery.of(context).size.height; //for screen height
    const Color bgColor = Color(0xFFD9D9D9);
    return Scaffold(
      body: Container(
          width: screenWidth,
          height: screenHeight,
          color: bgColor,
          child: Center(child: loginCard())
      ),
    );
  }
}
