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
    return Scaffold(
      body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Center(child: loginCard())
      ),
    );
  }
}
