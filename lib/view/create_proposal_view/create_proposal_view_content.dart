import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OfferModel {
  String name;
  String deliveryDate;
  int validDays;
  bool includeShipmentCost;
  int patmentDueDate;

  OfferModel()
      : name = '',
        deliveryDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()
            .add(Duration(days: 3, hours: 17 - DateTime.now().hour))),
        validDays = 3,
        includeShipmentCost = true,
        patmentDueDate = 30;
}

final offerModelProvider = Provider<OfferModel>((ref) => OfferModel());

class createProposalViewContent extends ConsumerWidget {
  final String topic;
  createProposalViewContent({this.topic = ' ', Key? key}) : super(key: key);
  final _dropdownMaxValue = 150;
  final TextEditingController _topic = TextEditingController();
  final TextEditingController _deliveryDate = TextEditingController(
    text:
        DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 3))),
  );
  final TextEditingController _validDays = TextEditingController(
    text: DateFormat('yyyy-MM-dd 17:00:00')
        .format(DateTime.now().add(Duration(days: 3))),
  );

  // int? _selectedDay;
  // int? _selectedDay2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DropdownMenuEntry<int>> dropDownMenuDate = <DropdownMenuEntry<int>>[];
    for (var i = 0; i <= _dropdownMaxValue; i++) {
      dropDownMenuDate.add(
        DropdownMenuEntry<int>(
          value: i,
          label: i.toString(),
        ),
      );
    }

    // final List<DropdownMenuEntry<bool>> dropDownMenuTrackings = <DropdownMenuEntry<bool>>[];
    // if (true) {
    //   dropDownMenuTrackings.add(
    //     const DropdownMenuEntry<bool>(
    //       value: true,
    //       label: 'Alıcı',
    //     ),
    //   );
    // } else if (false){
    //   dropDownMenuTrackings.add(
    //    const DropdownMenuEntry<bool>(
    //       value: false,
    //       label: 'Satıcı',
    //     ),
    //   );
      
    // }

    final offerModel = ref.read(offerModelProvider);

    return Column(
      children: [
        TextFormField(
          cursorColor: Theme.of(context).colorScheme.onBackground,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.onPrimary,
            labelText: 'Konu',
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            focusColor: Theme.of(context).colorScheme.onSecondaryContainer,
            // constraints: const BoxConstraints(maxHeight: 40),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
            floatingLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          initialValue: topic,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Lütfen konu giriniz.';
            }
            return null;
          },
          onChanged: (value) {
            offerModel.name = value;
            value=ref.read(offerModelProvider).name;
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.onBackground,
                controller: _deliveryDate,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  constraints: const BoxConstraints(maxHeight: 40),
                  border: const UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    _deliveryDate.text = formattedDate; // <- Bu satır eklenmeli
                    offerModel.deliveryDate = formattedDate;
                    formattedDate=ref.read(offerModelProvider).deliveryDate;
                  } else {}
                },
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: TextField(
                cursorColor: Theme.of(context).colorScheme.onBackground,
                controller: _validDays,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.calendar_month),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  constraints: const BoxConstraints(maxHeight: 40),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  border: const UnderlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    DateTime currentDate = DateTime.now();
                    int differenceInDays =
                        pickedDate.difference(currentDate).inDays;
                    differenceInDays = differenceInDays + 1;

                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    _validDays.text = formattedDate;
                    offerModel.validDays = differenceInDays;
                    differenceInDays=ref.read(offerModelProvider).validDays;
                  } else {}
                },
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 3,
                child: Text('Termin Tarihi',
                    style: Theme.of(context).textTheme.bodySmall)),
            const Spacer(),
            Expanded(
                flex: 3,
                child: Text('Son Teklif Verme Süresi',
                    style: Theme.of(context).textTheme.bodySmall)),
            const Spacer(
              flex: 2,
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: DropdownMenu<int>(
                controller: _topic,
                width: 310,
                menuHeight: 200,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  constraints: const BoxConstraints(maxHeight: 40),
                  contentPadding: EdgeInsets.only(left: 10.0),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: const UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ),        
                label:  Text(
                  'Gun',
                  style: Theme.of(context).textTheme.bodySmall,
                  ),
                menuStyle: MenuStyle(
                  alignment: AlignmentGeometry.lerp(
                      Alignment.bottomLeft, Alignment.bottomLeft, 0.5,
                  ),
                ),
                onSelected: (value) {
                  offerModel.patmentDueDate = value ?? 0;
                  debugPrint(offerModel.includeShipmentCost.toString());
                  value = ref.read(offerModelProvider).patmentDueDate;
                },
                dropdownMenuEntries: dropDownMenuDate,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: DropdownMenu<bool>(
                width: 310,
                menuHeight: 200,
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  constraints: const BoxConstraints(maxHeight: 40),
                  contentPadding: EdgeInsets.only(left: 10.0),
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  border: const UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ),        
                label:  Text(
                  'Nakliye',
                  style: Theme.of(context).textTheme.bodySmall,
                  ),
                menuStyle: MenuStyle(
                  alignment: AlignmentGeometry.lerp(
                      Alignment.bottomLeft, Alignment.bottomLeft, 0.5,
                  ),
                ),
                onSelected: (bool? value) {
                  offerModel.includeShipmentCost = value ?? false;
                  debugPrint(offerModel.includeShipmentCost.toString());
                  value = ref.read(offerModelProvider).includeShipmentCost;
                },
                dropdownMenuEntries: <bool>[true, false]
                    .map<DropdownMenuEntry<bool>>((bool value) {
                  return DropdownMenuEntry<bool>(
                    value: value,
                    label: value ? "Satıcı" : "Alıcı"
                  );
                }).toList(),
              ),
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 3,
                child: Text('Ödeme Vadesi',
                    style: Theme.of(context).textTheme.bodySmall)),
            const Spacer(
              flex: 1,
            ),
            Expanded(
                flex: 3,
                child: Text('Nakliye Ödemesi',
                    style: Theme.of(context).textTheme.bodySmall)),
            const Spacer(
              flex: 2,
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
