import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/api_url.dart';
import '../service/post_service.dart';
import '../view/widget/small_card/small_card.dart';
import 'buyer_invoices_view_model.dart';
import 'order_list_view_model.dart';

final shipmentDeliveredProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  final invoiceIdValue = ref.watch(idProvider);

  Map<String, dynamic> _invoiceAttributes = {};
  if(invoiceIdValue != null) {
      _invoiceAttributes = {
        "invoice_id":invoiceIdValue
      };
  }
  try {
    response = await apiService.post(url: ApiUrls.invoiceApproved, data: _invoiceAttributes);
    await ref.refresh(getInvoicesProvider);
            ref.read(getInvoicesProvider.future);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  return response.statusCode;
});