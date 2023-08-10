import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/view_model/shipment_view_model.dart';

import '../config/api_url.dart';
import '../service/post_service.dart';
import '../view/widget/small_card/small_card_shipment.dart';
import 'order_list_view_model.dart';

final shipmentDeliveredProvider = FutureProvider.autoDispose((ref) async {
  final apiService = PostService();
  Response response;
  final shipmentIdValue = ref.watch(shipmentIndexProvider);

  debugPrint('product proposal id value${shipmentIdValue.toString()}');
  Map<String, dynamic> _shipmentAttributes = {};
  if(shipmentIdValue != null) {
      _shipmentAttributes = {
        "shipment_id":shipmentIdValue
      };
  }
  try {
    response = await apiService.post(url: ApiUrls.shipmentDelivered, data: _shipmentAttributes);
    await ref.refresh(shipmentProvider);
            ref.read(shipmentProvider.future);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  debugPrint(response.toString());

  return response.statusCode;
});