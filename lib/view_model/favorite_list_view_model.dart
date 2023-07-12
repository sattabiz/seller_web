import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/apiUrls.dart';
import '../model/get_favorite_list_model.dart';
import '../service/get_favorite_list_service.dart';
import '../service/get_services.dart';
import 'order_list_view_model.dart';

final favoriteListProvider = FutureProvider<List<GetFavoriteListModel>>((ref) async {
  final apiService = ApiService();
  Response response;
  try {
    response = await apiService.get(url: ApiUrls.favoriteList);
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode != 200) {
        ref.read(navigatorKeyProvider).currentState!.pushNamed("/login");
      }
    }
    rethrow;
  }
  //debugPrint('aaaaaaaaaasssssssssss 3434 dfsdf${response.data.toString()} sdfsdfsdfsd34234234');
  List<GetFavoriteListModel> _favoriteList = [];
  if (response.data['favorite_lists'] != null) {
    _favoriteList = (response.data['favorite_lists'] as List)
        .map((e) => GetFavoriteListModel.fromMap(e))
        .toList();
  }

  return _favoriteList;
});