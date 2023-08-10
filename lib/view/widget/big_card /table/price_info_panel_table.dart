import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class PriceInfoPanel extends StatelessWidget {
  final String className;
  final String ?row1;
  final String ?row2;
  final String ?row3;

const PriceInfoPanel({ 
  Key? key, 
  required this.className, 
  this.row1, 
  this.row2, 
  this.row3,
   }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 5),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          // borderRadius: BorderRadius.circular(10),
          //border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary), // TODO : dont forget to remove
          /* boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            ),
          ], */
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/5), // TODO : temporary solution
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /* Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    /* borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ), */
                  ),
                  child: Text(
                    FlutterI18n.translate(context, "Example"),
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                  ),
                ),
              ), */
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          FlutterI18n.translate(context, "Tutar: "),
                          style: Theme.of(context).textTheme.bodySmall,
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15), //padding between elements in row
                    Expanded(
                      flex: 2,
                      child: Text(
                        "paletfiyat*200",
                        /* row1! */
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          FlutterI18n.translate(context, "KDV(%20): "),
                          style: Theme.of(context).textTheme.bodySmall,
                          textDirection: TextDirection.ltr, 
                          maxLines: 1,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15), //padding between elements in row
                    Expanded(
                      flex: 2,
                      child: Text(
                        "kdv*Tutar",
                        /* row1! */
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          FlutterI18n.translate(context, "Toplam: "),
                          style: Theme.of(context).textTheme.bodySmall,
                          textDirection: TextDirection.ltr,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15), //padding between elements in row
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Tutar+KDV",
                        /* row1! */
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}