import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
const LoadingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Center(
      widthFactor: 40,
      heightFactor: 40,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
        value: 5.0,
      ),
    );
  }
}