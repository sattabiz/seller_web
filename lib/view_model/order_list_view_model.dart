import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_url.dart';
import '../model/get_order_list_model.dart';
import '../service/get_services.dart';
import '../storage/current_user_storage.dart';

final getOrderListProvider =
    FutureProvider.autoDispose<List<GetOrderlistModel>>((ref) async {
  final apiService = ApiService();
  final _companyIdAsyncValue = await CompanyIdStorageLandingService().getCompanyIdData();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.order(_companyIdAsyncValue));
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
  _orderList.sort((a, b) => b.id!.compareTo(a.id!));
  debugPrint('-----------------');
  debugPrint(_orderList[0].toString());
  debugPrint(_orderList[0].products[0].sendedAmount.toString());
  return _orderList;
});

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});
