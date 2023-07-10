import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../create_proposal_view/create_proposal_view.dart';
import '../favorite_list_view/navigation_rail_favorite.dart';
import '../favorite_list_view/navigation_rail_favorite_content.dart';

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
          onTap: () {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
            final RelativeRect position = RelativeRect.fromRect(
              Rect.fromPoints(
                button.localToGlobal(
                    Offset(button.size.width * 0.75, button.size.height),
                    ancestor: overlay),
                button.localToGlobal(button.size.bottomRight(Offset.zero),
                    ancestor: overlay),
              ),
              Offset.zero & overlay.size,
            );
            showMenu(
                context: context,
                position: position,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                items: <PopupMenuEntry<SampleItem>>[
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.itemOne,
                    child: Text('Yeni Teklif İsteği Oluştur'),
                  ),
                  const PopupMenuItem<SampleItem>(
                    value: SampleItem.itemTwo,
                    child: Text('Listelerimden Teklif Oluştur'),
                  ),
                ]).then((SampleItem? item) {
              if (item == null) return;
              switch (item) {
                case SampleItem.itemOne:
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const createProposalView();
                      });
                  break;
                case SampleItem.itemTwo:
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          titlePadding: EdgeInsets.zero,
                          title: const navigationRailFavorite(),
                          content: navigationRailFavoriteContent(),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Tamam'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                  break;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width > 1500
                ? MediaQuery.of(context).size.width * 0.13
                : MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width > 800
                ? MediaQuery.of(context).size.height * 0.080
                : MediaQuery.of(context).size.height * 0.2,
            child: Card(
              color: Theme.of(context).colorScheme.primary,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.onPrimary,
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
                              color: Theme.of(context).colorScheme.onPrimary,
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
