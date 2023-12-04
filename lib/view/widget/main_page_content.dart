import 'package:flutter/material.dart';

class allMainPageContent extends StatelessWidget {
  final String topic;

  allMainPageContent({Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(top:5, bottom: 15,right: 20),
      child: Text(topic, style: Theme.of(context).textTheme.headlineLarge,),
    );
  }
}

