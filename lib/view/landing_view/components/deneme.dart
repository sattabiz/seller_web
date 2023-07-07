import 'package:flutter/material.dart';

class Deneme extends StatelessWidget {
  final String paragraphs;
  const Deneme({
    Key? key,
    this.currentValue = 0,
    required this.paragraphs,
  }) : super(key: key);
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    List<String>  text = paragraphs.split("\n");
    text.removeWhere((element) => element.isEmpty);
    final list = text.asMap();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500),
                  width: index == currentValue ? 50 : 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "${list[index]}",
                    style: TextStyle(color: Colors.white),
                  ),     
                ),
              )),
    );
  }
}