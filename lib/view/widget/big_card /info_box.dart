import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


import '../countdown_date.dart';

class InfoBox extends StatelessWidget {
  final String header;
  final String className;
  final String ?row1;
  final String ?row2;
  final String ?row3;

const InfoBox({ 
  Key? key, 
  required this.header, 
  required this.className, 
  this.row1, 
  this.row2, 
  this.row3,
   }) : super(key: key);

  @override
  Widget build(BuildContext context){
    const surfaceDim = Color(0xFFD8DBD8);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            ),
          ],
        ),
        height: 100,
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                color: surfaceDim,
                child: AutoSizeText(
                  header,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: AutoSizeText(
                        FlutterI18n.translate(context, "tr.$className.row_1"),
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      '-',
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: AutoSizeText(
                        FlutterI18n.translate(context, "tr.$className.row_2"),
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  // Flexible(child: CountdownDate(headerDate: row2!)),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: AutoSizeText(
                        FlutterI18n.translate(context, "tr.$className.row_3"),
                        style: Theme.of(context).textTheme.bodySmall,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AutoSizeText(
                      '-',
                      style: Theme.of(context).textTheme.bodySmall,
                      textDirection: TextDirection.ltr,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}