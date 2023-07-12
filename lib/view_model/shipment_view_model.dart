import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seller_point/config/apiUrls.dart';
import 'package:seller_point/service/get_services.dart';
import 'package:seller_point/view_model/order_list_view_model.dart';
import '../model/shipment_model.dart';
import '../service/get_shipment_list_service.dart';

final shipmentProvider = FutureProvider.autoDispose<List<Shipment>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.shipment);
  } catch (error) {
    if (error is DioException) {
      if (error.response?.statusCode != 200) {
        debugPrint(error.response!.statusCode.toString());
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }

  List<Shipment> _shipmentList = [];
  debugPrint('response 3434 dfsdf${response.toString()} sdfsdfsdfsd34234234');
  if (response.data['shipments'] != null) {
    _shipmentList = (response.data['shipments'] as List)
        .map((e) => Shipment.fromMap(e))
        .toList();
  }

  return _shipmentList;
});
