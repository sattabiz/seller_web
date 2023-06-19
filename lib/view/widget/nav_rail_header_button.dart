import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo }

class DrawerHeaderButton extends StatefulWidget {
  @override
  _DrawerHeaderButtonState createState() => _DrawerHeaderButtonState();
}

class _DrawerHeaderButtonState extends State<DrawerHeaderButton> {
  SampleItem? selectedMenu;
  TextEditingController dateInput1 = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();
  int? _selectedDay;
  @override
  void initState() {
    dateInput1.text = ""; //set the initial value of text field for termin
    dateInput2.text =
        ""; //set the initial value of text field for son teklif verme suresi
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(builder: (BuildContext context) {
        return InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            width: 250,
            height: 90,
            child: Card(
              color: Theme.of(context).colorScheme.secondary,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 24,
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: AutoSizeText(
                        'Yeni Teklif İsteği',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}