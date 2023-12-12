import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view/address/update_address.dart';
import 'package:seller_point/view/address/create_address.dart';

import '../../view_model/customer_addresses_view_model.dart';
import '../widget/loading_widget.dart';

class Address extends ConsumerWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressList = ref.watch(getCustomerAddressesProvider);
    return addressList.when(
      data: (data) {
        return AlertDialog(
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.only(bottom: 10.0),
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
            width: 350,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.list,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    FlutterI18n.translate(context, 'tr.login.address'),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          content: SizedBox(
            width: 350,
            child: ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  shape: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      width: 1.0,
                    ),
                  ),
                  title: Text(
                    data[index].name!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  onTap: () async{
                    ref.refresh(addressProvider);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateAddress(addresses: data[index],);
                      }
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    ref.refresh(addressProvider);
                    return CreateAddress();
                  }
                );
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(130, 40),
                ),
              ),
              child: Text(
                FlutterI18n.translate(context, 'tr.address_dialog.address_btn'),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
          ],
        );
      }, 
      loading: () => const LoadingWidget(),
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/login');
        });
        return Text('An error occurred: $error');
      },
    );
  }
}
