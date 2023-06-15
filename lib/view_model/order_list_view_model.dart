import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_order_list_model.dart';
import '../service/get_order_list_service.dart';


final getOrderListProvider = FutureProvider<List<GetOrderlistModel>>((ref) async {
  final _orderlistservice = getOrderlistService();
  try {
    List<GetOrderlistModel> _orderList = await _orderlistservice.getOrderlistData();
    return _orderList;
  } catch (e) {
    if (e is DioError) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    throw e;
  }
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});/* 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/get_order_list_model.dart';
import '../service/get_order_list_service.dart';

final getOrderListProvider = FutureProvider<List<GetOrderlistModel>>((ref) async {
  final orderlistservice = GetOrderlistService();  
  List<GetOrderlistModel> _orderList = await orderlistservice.getOrderlistData();
  return _orderList;  
});

final scrollControllerProvider = Provider<ScrollController>((ref) {
  return ScrollController();
}); */