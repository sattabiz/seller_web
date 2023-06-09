import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../config/apiUrls.dart';
import '../model/get_favorite_list_model.dart';
import '../storage/jwt_storage.dart';

class getFavoriteListService {

  final Dio _dio = Dio();

  Future<List<GetFavoriteListModel>> getFavoriteListtData() async {
    _dio.options.responseType = ResponseType.json;
    List<GetFavoriteListModel> _list = [];

    try {
      final _jwt = await jwtStorageService().getJwtData();

      var _response = await _dio.get(
        ApiUrls.favoriteList,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );

      if (_response.statusCode != 200) {
        throw DioError(
            requestOptions: _response.requestOptions,
            error: 'HTTP status error: ${_response.statusCode}');
      }

      List _data = _response.data['favorite_lists'];

      _data.forEach((element) {
        GetFavoriteListModel getOrderlistModel =
            GetFavoriteListModel.fromMap(element);
        _list.add(getOrderlistModel);
      });
    } catch (e) {
      throw e;
    }

    return _list;
  }
}
