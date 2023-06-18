import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_buyer_invoices_list_model.dart';
import '../model/get_order_list_model.dart';
import '../service/get_buyer_invoices_list_service.dart';
import 'order_list_view_model.dart';

final getInvoicesProvider = FutureProvider<List<GetInvoicesModel>>((ref) async {
  final _invoiceslistservice = getInvoicesService();
  try {
    List<GetInvoicesModel> _orderList = await _invoiceslistservice.getInvoicesListData();
    return _orderList;
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    throw e;
  }
});
