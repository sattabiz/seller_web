import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class BodyProposal extends StatelessWidget {
  final String id;
  final int i;
  final String status;
  final String className;
  final String bodyHeader;
  final List bodyList;

  const BodyProposal({ 
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
    return SizedBox(
      child: Padding(
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
                      child: AutoSizeText((i + 1).toString(),
                          textDirection: TextDirection.ltr,
                          maxLines: 1),
                    ),
                    Expanded(
                      flex: 10,
                      child: className == 'proposal'
                          ? AutoSizeText(
                              bodyList[i].productName.toString(),
                              textDirection: TextDirection.ltr,
                              maxLines: 1)
                          : AutoSizeText(
                              bodyList[i].name.toString(),
                              textDirection: TextDirection.ltr,
                              maxLines: 1),
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
                    Expanded(
                      flex: 6,
                      child: (className=='invoice' || className=='shipment')
                      ? AutoSizeText(
                          '${bodyList[i].shippedAmount} adet',
                          textDirection: TextDirection.ltr,
                          maxLines: 1)
                      : AutoSizeText(
                          '${bodyList[i].amount} adet',
                          textDirection: TextDirection.ltr,
                          maxLines: 1
                        ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      flex: 3,
                      child: bodyList[i].price == null
                      ? const AutoSizeText('-' ,textAlign: TextAlign.center)
                      : AutoSizeText(
                        '${bodyList[i].price} ₺',
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                      ),

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
      ),
    );
  }
}