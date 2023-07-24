import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ListHeader extends StatelessWidget {
  final String status;
  const ListHeader({ 
  Key? key, 
  required this.status 
  }) : super(key: key);

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
                  flex: 6,
                  child: Text(
                    FlutterI18n.translate(context, "tr.order.product"),
                    style: Theme.of(context).textTheme.bodySmall,
                    textDirection: TextDirection.ltr,
                    maxLines: 1,
                  ),
                ),
                // const Spacer(
                //   flex: 6,
                // )
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(
                flex: 2,
              ),
              Expanded(
                flex: 6,
                // child: Text(FlutterI18n.translate(context, "tr.order.$status")) sadece siparis edildide
                child: Text( 
                  style: Theme.of(context).textTheme.bodySmall,
                  status == 'order_approved'
                  ? FlutterI18n.translate(context, "tr.order.order_header")
                  : FlutterI18n.translate(context, "tr.order.amount"),
                  ), //buraya bakilacak
              ),
              const Spacer(
                flex: 2,
              ),
              Flexible(
                  flex: 4,
                  child: Text(
                    FlutterI18n.translate(context, "tr.order.price"),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  )),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
  }
  