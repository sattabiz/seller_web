import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';

class BodyShipment extends StatelessWidget {
  final String id;
  final int i;
  final String status;
  final String className;
  final String bodyHeader;
  final List bodyList;

  const BodyShipment({ 
  Key? key, 
    required this.id,
    required this.i, 
    required this.status, 
    required this.className, 
    required this.bodyHeader, 
    required this.bodyList
  }) : super(key: key);

  @override
  Widget build(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: 
                      Text(
                        (i + 1).toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1
                      ),
                  ),
                  Expanded(
                    flex: 10,
                    child: 
                      Text(
                        bodyList[i].name.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1
                      ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, right: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  status == 'order_on_the_way'
                  ? Expanded(
                    flex: 6,
                    child: Text(
                      bodyList[i].shippedAmount.toString() + 'adet',
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                    )
                  )
                  : const Spacer(flex:6),
                  Expanded(
                    flex: 4,
                    child: 
                     Text(
                      status == 'order_on_the_way'
                      ? bodyList[i].price.toString() + ' ₺'
                      : bodyList[i].shippedAmount.toString() + ' adet',
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.ltr,
                      maxLines: 1)
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}