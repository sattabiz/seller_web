import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/address/update_address.dart';
import '../../utils/widget_helper.dart';
import '../../view_model/create_update_address_view_model.dart';

class CreateAddress extends ConsumerStatefulWidget {
  const CreateAddress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateAddressState();
}

class _CreateAddressState extends ConsumerState<CreateAddress> {
  late final TextEditingController _nameController;
  late final TextEditingController _addresController;
  late final TextEditingController _phoneController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _addresController = TextEditingController();
    _phoneController = TextEditingController();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _addresController;
    _nameController;
    _phoneController;
  }

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: AlertDialog(
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        titlePadding: EdgeInsets.zero,
        actionsAlignment: MainAxisAlignment.end,
        title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          width: 400,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  FlutterI18n.translate(context, 'tr.address_dialog.address_btn'),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  dynamic value = ref.watch(addressProvider);
                  ref.refresh(addressProvider);
                },
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            customTextField(context,
                FlutterI18n.translate(context, 'tr.address_dialog.title'), _nameController, "name"),
            const SizedBox(height: 20),
            customTextField(context,
                FlutterI18n.translate(context, 'tr.address_dialog.address'), _addresController, "address"),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSecondary,
                labelText:
                    FlutterI18n.translate(context, 'tr.address_dialog.city'),
                labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                floatingLabelStyle: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withOpacity(0.5),
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                contentPadding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
                constraints: const BoxConstraints(
                  maxHeight: 45,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              items: CITY_LIST.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                ref.read(addressProvider.notifier).state!["city"] = value;
              },
            ),
            const SizedBox(height: 20),
            customTextField(context,
                FlutterI18n.translate(context, 'tr.address_dialog.phone'), _phoneController, "phone"),
            const SizedBox(height: 20),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async{
              if (_key.currentState!.validate()) {
                debugPrint('Form doğrulandı');
              }
              await ref.watch(addressFutureProvider);
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(130, 40),
              ),
            ),
            child: Text(
              FlutterI18n.translate(context, 'tr.address_dialog.save_btn'),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ],
      ),
    );
  }
  Widget customTextField(BuildContext context, String label, TextEditingController controller, String keyValue) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        cursorColor: Theme.of(context).colorScheme.onSurfaceVariant,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.onSecondary,
          contentPadding: const EdgeInsets.only(left: 10.0, bottom: 20.0),
          isDense: true,
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: (value) {
          ref.read(addressProvider.notifier).state?.update(keyValue, (value) => controller.text);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return FlutterI18n.translate(
                context, 'tr.address_dialog.validation_msg');
          }
          return null;
        },
      ),
    );
  }
}