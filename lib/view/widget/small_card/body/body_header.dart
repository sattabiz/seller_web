import 'package:flutter/material.dart';

class BodyHeader extends StatelessWidget {
  final String ?bodyHeader;

  const BodyHeader({ 
  Key? key, 
     this.bodyHeader, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Padding(
      padding: const EdgeInsets.only(
          bottom: 4.0, top: 5.0, left: 16.0),
      child: Text(
        bodyHeader ?? '-',
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
      ),
    );
  }
}