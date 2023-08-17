import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final proposalIdProvider = StateProvider<String?>((ref) => '');

class BigCard extends ConsumerWidget {
  final String id;
  final Widget bigCardHeader;
  final Widget bigCardTable;
  final Widget buttons;
  final Widget infoWidget;
  final Widget ?infoBoxWidget;

  const BigCard( {
    Key? key,
    required this.id,
    required this.bigCardHeader,
    required this.bigCardTable,
    required this.buttons,
    required this.infoWidget,
    this.infoBoxWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: 1280,
      height: 720,
      // constraints: BoxConstraints.tightFor(width: width * 0.7, height: height * 0.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        children: [
          bigCardHeader,
          Expanded(
            flex: 11,                    //body
            child: Row(
              children: [
                SizedBox(        // left-side
                  width: 840,
                  height: height * 0.7,
                  child: Column(  
                    crossAxisAlignment: CrossAxisAlignment.start,         
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: infoWidget
                          ),
                          infoBoxWidget ?? const SizedBox(width: 0),
                        ],
                      ),  //info        
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 30.0, right: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).colorScheme.onPrimary,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 4),
                                  blurRadius: 4.0,
                                ),
                              ],
                            ),
                            child: bigCardTable,
                          ),
                        ),
                      ),
                      buttons,
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30,top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints.tightFor(width: 250),
                          padding: const EdgeInsets.all(10),
                          child: Align(
                            alignment: (id == "1" ?Alignment.topLeft:Alignment.topRight),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ( id == "1" ? Colors.grey.shade200 :Colors.blue[200]),
                              ),
                              padding: const  EdgeInsets.all(16),
                              child: Text("Siparis yolda", style: const TextStyle(fontSize: 15),),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Container(                            
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          constraints: const BoxConstraints.tightFor(width: 250, height: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}