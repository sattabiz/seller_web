import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../config/apiUrls.dart';
import '../model/get_order_list_model.dart';
import '../storage/jwt_storage.dart';

class getOrderlistService {

  final Dio _dio = Dio();

  Future<List<GetOrderlistModel>?> getOrderlistData() async {
    _dio.options.responseType = ResponseType.json;
    List<GetOrderlistModel>? _list;

    try {
      final _jwt = await jwtStorageService().getJwtData();

      var response = await _dio.get(
        ApiUrls.order,
        options: Options(
          headers: {
            "Authorization": _jwt,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw DioError(
            requestOptions: response.requestOptions,
            error: 'HTTP status error: ${response.statusCode}');
      }

      _list = [];
      List data = response.data['order'];
      data.forEach((element) {
        GetOrderlistModel getOrderlistModel =
            GetOrderlistModel.fromMap(element);
        _list!.add(getOrderlistModel);
      });
    } catch (e) {
      return null;
    }

    return _list;
  }
}