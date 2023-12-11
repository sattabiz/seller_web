import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/current_user_view_model.dart';
import '../widget/loading_widget.dart';

class CompanyInfo extends ConsumerWidget {
  const CompanyInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyInfo = ref.watch(getCurrentUserInfoProvider);
    return companyInfo.when(
      data: (data) {
        return AlertDialog(
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          titlePadding: EdgeInsets.zero,
          contentPadding: const EdgeInsets.all(20.0),
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
            width: 500,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.factory,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    FlutterI18n.translate(context, 'tr.company_info.header'),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant),
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                textDirection: TextDirection.ltr,
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(0.2),
                  1: FlexColumnWidth(0.6),
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          FlutterI18n.translate(context, 'tr.company_info.firm'),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          data.company?.name ?? '-',
                          maxLines: 1,
                          softWrap: true,
                          style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          FlutterI18n.translate(context, 'tr.company_info.contact_user'),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          data.currentUser?.fullName ?? '-',
                          style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          FlutterI18n.translate(context, 'tr.company_info.phone'),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          data.company?.phone ?? '-',
                          style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          FlutterI18n.translate(context, 'tr.company_info.tax_office'),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          data.company?.taxOffice ?? '-',
                          style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          FlutterI18n.translate(context, 'tr.company_info.tax_no'),
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          data.company?.taxId ?? '-',
                          style: Theme.of(context).textTheme.bodyMedium!),
                      ),
                    ]
                  ),
                ],
              ),
              InkWell(
                child: Text(
                  FlutterI18n.translate(context, 'tr.company_info.user_agreement'),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue
                  ),
                ),
              )

            ],
          ),
        );
      },
      loading: () => const LoadingWidget(),
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/login');
        });
        return Text('An error occurred: $error');
      }
    );
  }
}
