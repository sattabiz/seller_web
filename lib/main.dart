import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/theme/theme.dart';
import '/view/landing_view/landing_view.dart';

// k global degisken olustururken variable tanimlarken kullanilan generic  kural 


void main()  {
  runApp(const ProviderScope(
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home:  LandingView(),
    );
  }
}
