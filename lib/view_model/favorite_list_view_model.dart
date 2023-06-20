import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/get_favorite_list_model.dart';
import '../service/get_favorite_list_service.dart';
import 'order_list_view_model.dart';

final favoriteListProvider = FutureProvider<List<GetFavoriteListModel>>((ref) async {
  final _orderlistservice = getFavoriteListService();
  try {
    List<GetFavoriteListModel> _orderList = await _orderlistservice.getFavoriteListtData();
    debugPrint("Received data from server: $_orderList");
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