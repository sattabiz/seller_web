import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ListHeaderShipment extends StatelessWidget {
const ListHeaderShipment({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  flex: 1,
                  child: Text('#'),
                ),
                Expanded(
                  flex: 2,
                  child: AutoSizeText(
                    FlutterI18n.translate(
                        context, "tr.order.product"),
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                  ),
                ),
                const Spacer(
                  flex: 6,
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(
                flex: 12,
              ),
              Flexible(
                  flex: 4,
                  child: AutoSizeText(
                    FlutterI18n.translate(context, "tr.order.amount"),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  )),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
  }
  