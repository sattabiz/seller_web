import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_order_list_model.dart';
import '../service/get_order_list_service.dart';



final getOrderListProvider = FutureProvider<List<GetOrderlistModel>>((ref) async {
  final _orderlistservice = getOrderlistService();
  List<GetOrderlistModel>? _orderList;
  try {
    _orderList = await _orderlistservice.getOrderlistData();
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
  }
  return _orderList ?? [];  // null durumunda boş liste döndürür
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});