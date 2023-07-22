import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/apiUrls.dart';
import '../model/get_order_list_model.dart';
import '../service/get_order_list_service.dart';
import '../service/get_services.dart';

final getOrderListProvider =
    FutureProvider.autoDispose<List<GetOrderlistModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.order);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  List<GetOrderlistModel> _orderList = [];
  if (response.data['order'] != null) {
    _orderList = (response.data['order'] as List)
        .map((e) => GetOrderlistModel.fromMap(e))
        .toList();
  }

  return _orderList;
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});
